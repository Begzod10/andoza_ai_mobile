import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

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

    _dio.interceptors.add(_LoggingInterceptor());
  }

  late final Dio _dio;
  final Duration connectTimeout;
  final Duration receiveTimeout;

  void setAuthToken(String token) {
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  void clearAuthToken() {
    _dio.options.headers.remove('Authorization');
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
    required T Function(dynamic) fromJson,
  }) async {
    try {
      final response = await _dio.post<dynamic>(path, data: data);
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

  Future<void> delete(String path) async {
    try {
      await _dio.delete<dynamic>(path);
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
    final data = error.response?.data as Map<String, dynamic>?;
    final errorMessage = data?['message'] ?? data?['error'] ?? 'Unknown error';

    return switch (statusCode) {
      400 => 'Bad request: $errorMessage',
      401 => 'Unauthorized',
      403 => 'Forbidden',
      404 => 'Not found',
      409 => 'Conflict: $errorMessage',
      500 => 'Server error',
      _ => 'HTTP $statusCode: $errorMessage',
    };
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
