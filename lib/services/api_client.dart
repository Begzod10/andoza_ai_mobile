import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

import 'sse_client.dart';

class ApiException implements Exception {
  ApiException({required this.message, this.statusCode, this.response});

  final String message;
  final int? statusCode;
  final dynamic response;

  @override
  String toString() => message;
}

class ApiClient {
  ApiClient({
    required String baseUrl,
    this.onUnauthorized,
    this.connectTimeout = const Duration(seconds: 10),
    this.receiveTimeout = const Duration(seconds: 30),
  }) {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: connectTimeout,
        receiveTimeout: receiveTimeout,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // Order matters: auth first (so the token is attached before logging),
    // logging last.
    _dio.interceptors.add(_AuthInterceptor(() => _authToken, onUnauthorized));
    _dio.interceptors.add(_LoggingInterceptor());
  }

  late final Dio _dio;
  final Duration connectTimeout;
  final Duration receiveTimeout;

  /// Invoked whenever the backend answers 401, so the app can drop to the
  /// login screen from a single place instead of every call site.
  final void Function()? onUnauthorized;

  String? _authToken;

  void setAuthToken(String token) {
    _authToken = token;
  }

  void clearAuthToken() {
    _authToken = null;
  }

  Future<T> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    required T Function(dynamic) fromJson,
  }) async {
    try {
      final response = await _dio.get<dynamic>(
        path,
        queryParameters: queryParameters,
      );
      return fromJson(response.data);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<T> post<T>(
    String path, {
    required dynamic data,
    Map<String, dynamic>? queryParameters,
    required T Function(dynamic) fromJson,
  }) async {
    try {
      final response = await _dio.post<dynamic>(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      return fromJson(response.data);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<T> put<T>(
    String path, {
    required dynamic data,
    required T Function(dynamic) fromJson,
  }) async {
    try {
      final response = await _dio.put<dynamic>(path, data: data);
      return fromJson(response.data);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<T> patch<T>(
    String path, {
    required dynamic data,
    required T Function(dynamic) fromJson,
  }) async {
    try {
      final response = await _dio.patch<dynamic>(path, data: data);
      return fromJson(response.data);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<void> delete(String path) async {
    try {
      await _dio.delete<dynamic>(path);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// Uploads a file as `multipart/form-data` under the field [fieldName].
  /// [bytes] + [filename] describe the file; dio sets the multipart content
  /// type (with boundary) automatically. Used for wallpaper image uploads.
  Future<T> uploadFile<T>(
    String path, {
    required List<int> bytes,
    required String filename,
    String fieldName = 'file',
    String? contentType,
    required T Function(dynamic) fromJson,
  }) async {
    try {
      final formData = FormData.fromMap({
        fieldName: MultipartFile.fromBytes(
          bytes,
          filename: filename,
          contentType: contentType == null
              ? null
              : DioMediaType.parse(contentType),
        ),
      });
      final response = await _dio.post<dynamic>(
        path,
        data: formData,
        options: Options(contentType: 'multipart/form-data'),
      );
      return fromJson(response.data);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// Fetches a binary response (e.g. a generated PDF) as raw bytes. The auth
  /// token is attached via the interceptor like any other request.
  Future<List<int>> getBytes(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.get<List<int>>(
        path,
        queryParameters: queryParameters,
        options: Options(responseType: ResponseType.bytes),
      );
      return response.data ?? const <int>[];
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// Opens a Server-Sent Events stream (used by the AI builder). Yields one
  /// [SseEvent] per server event until the response completes or the
  /// subscription is cancelled. The auth token is attached via the interceptor
  /// just like any other request.
  Stream<SseEvent> stream(
    String path, {
    String method = 'POST',
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async* {
    try {
      final response = await _dio.request<ResponseBody>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          method: method,
          responseType: ResponseType.stream,
          headers: {'Accept': 'text/event-stream'},
          // SSE connections are long-lived; don't time out mid-stream.
          receiveTimeout: Duration.zero,
        ),
      );
      final body = response.data;
      if (body == null) return;
      yield* parseSseStream(body.stream.cast<List<int>>());
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  ApiException _handleDioError(DioException error) {
    final message = switch (error.type) {
      DioExceptionType.connectionTimeout => 'Connection timeout',
      DioExceptionType.sendTimeout => 'Send timeout',
      DioExceptionType.receiveTimeout => 'Receive timeout',
      DioExceptionType.badResponse => _handleBadResponse(error),
      DioExceptionType.badCertificate => 'Bad SSL certificate',
      _ => 'Network error: ${error.message}',
    };

    return ApiException(
      message: message,
      statusCode: error.response?.statusCode,
      response: error.response?.data,
    );
  }

  String _handleBadResponse(DioException error) {
    final statusCode = error.response?.statusCode;
    final errorMessage = _extractErrorMessage(error.response?.data);

    return switch (statusCode) {
      400 => 'Bad request: $errorMessage',
      401 => 'Unauthorized',
      403 => 'Forbidden',
      404 => 'Not found',
      409 => 'Conflict: $errorMessage',
      422 => 'Validation error: $errorMessage',
      500 => 'Server error',
      _ => 'HTTP $statusCode: $errorMessage',
    };
  }

  /// FastAPI returns errors as `{"detail": "..."}` or, for validation
  /// failures, `{"detail": [{"msg": "...", "loc": [...]}, ...]}`. Fall back to
  /// the older `message`/`error` keys for anything non-FastAPI.
  String _extractErrorMessage(dynamic data) {
    if (data is Map<String, dynamic>) {
      final detail = data['detail'] ?? data['message'] ?? data['error'];
      if (detail is String) return detail;
      if (detail is List && detail.isNotEmpty) {
        final first = detail.first;
        if (first is Map && first['msg'] != null) {
          return first['msg'].toString();
        }
        return detail.join(', ');
      }
      if (detail != null) return detail.toString();
    }
    return 'Unknown error';
  }
}

/// Attaches the bearer token to every outgoing request and routes 401s to a
/// single [onUnauthorized] callback.
class _AuthInterceptor extends Interceptor {
  _AuthInterceptor(this._tokenGetter, this._onUnauthorized);

  final String? Function() _tokenGetter;
  final void Function()? _onUnauthorized;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = _tokenGetter();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      _onUnauthorized?.call();
    }
    handler.next(err);
  }
}

class _LoggingInterceptor extends Interceptor {
  static final _logger = Logger();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _logger.i(
      'REQUEST: ${options.method} ${options.path}',
      error: options.queryParameters.isEmpty
          ? null
          : 'Query: ${options.queryParameters}',
    );
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _logger.i(
      'RESPONSE: ${response.statusCode} ${response.requestOptions.path}',
    );
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _logger.e(
      'ERROR: ${err.requestOptions.path}',
      error: err.message,
      stackTrace: err.stackTrace,
    );
    handler.next(err);
  }
}
