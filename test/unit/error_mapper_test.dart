import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tamir_uy_mobile_flutter/services/api_client.dart';
import 'package:tamir_uy_mobile_flutter/utils/error_mapper.dart';

DioException _dio(DioExceptionType type, {int? statusCode, Object? error}) {
  final options = RequestOptions(path: '/test');
  return DioException(
    requestOptions: options,
    type: type,
    error: error,
    response: statusCode == null
        ? null
        : Response<dynamic>(requestOptions: options, statusCode: statusCode),
  );
}

void main() {
  group('mapErrorToMessage — DioException transport errors', () {
    test('connection timeout → timeout message', () {
      expect(
        mapErrorToMessage(_dio(DioExceptionType.connectionTimeout)),
        errorTimeout,
      );
    });

    test('send timeout → timeout message', () {
      expect(
        mapErrorToMessage(_dio(DioExceptionType.sendTimeout)),
        errorTimeout,
      );
    });

    test('receive timeout → timeout message', () {
      expect(
        mapErrorToMessage(_dio(DioExceptionType.receiveTimeout)),
        errorTimeout,
      );
    });

    test('connection error → no internet message', () {
      expect(
        mapErrorToMessage(_dio(DioExceptionType.connectionError)),
        errorNoInternet,
      );
    });

    test('bad certificate → server message', () {
      expect(
        mapErrorToMessage(_dio(DioExceptionType.badCertificate)),
        errorServer,
      );
    });

    test('cancel → generic message', () {
      expect(
        mapErrorToMessage(_dio(DioExceptionType.cancel)),
        errorGeneric,
      );
    });

    test('unknown wrapping a SocketException → no internet message', () {
      expect(
        mapErrorToMessage(
          _dio(DioExceptionType.unknown,
              error: const SocketException('no route')),
        ),
        errorNoInternet,
      );
    });

    test('unknown without a socket cause → generic message', () {
      expect(
        mapErrorToMessage(_dio(DioExceptionType.unknown)),
        errorGeneric,
      );
    });
  });

  group('mapErrorToMessage — DioException bad responses', () {
    test('401 → session message', () {
      expect(
        mapErrorToMessage(
            _dio(DioExceptionType.badResponse, statusCode: 401)),
        errorSession,
      );
    });

    test('403 → session message', () {
      expect(
        mapErrorToMessage(
            _dio(DioExceptionType.badResponse, statusCode: 403)),
        errorSession,
      );
    });

    test('404 → not found message', () {
      expect(
        mapErrorToMessage(
            _dio(DioExceptionType.badResponse, statusCode: 404)),
        errorNotFound,
      );
    });

    test('500 → server message', () {
      expect(
        mapErrorToMessage(
            _dio(DioExceptionType.badResponse, statusCode: 500)),
        errorServer,
      );
    });

    test('503 → server message', () {
      expect(
        mapErrorToMessage(
            _dio(DioExceptionType.badResponse, statusCode: 503)),
        errorServer,
      );
    });

    test('400 client error → generic fallback', () {
      expect(
        mapErrorToMessage(
            _dio(DioExceptionType.badResponse, statusCode: 400)),
        errorGeneric,
      );
    });

    test('422 validation error → generic fallback', () {
      expect(
        mapErrorToMessage(
            _dio(DioExceptionType.badResponse, statusCode: 422)),
        errorGeneric,
      );
    });

    test('bad response with no status code → generic fallback', () {
      expect(
        mapErrorToMessage(_dio(DioExceptionType.badResponse)),
        errorGeneric,
      );
    });
  });

  group('mapErrorToMessage — ApiException wrapper', () {
    test('401 status → session message', () {
      expect(
        mapErrorToMessage(
            ApiException(message: 'Unauthorized', statusCode: 401)),
        errorSession,
      );
    });

    test('404 status → not found message', () {
      expect(
        mapErrorToMessage(ApiException(message: 'Not found', statusCode: 404)),
        errorNotFound,
      );
    });

    test('500 status → server message', () {
      expect(
        mapErrorToMessage(
            ApiException(message: 'Server error', statusCode: 500)),
        errorServer,
      );
    });

    test('no status but timeout message → timeout message', () {
      expect(
        mapErrorToMessage(ApiException(message: 'Connection timeout')),
        errorTimeout,
      );
    });

    test('no status but network message → no internet message', () {
      expect(
        mapErrorToMessage(ApiException(message: 'Network error: failed')),
        errorNoInternet,
      );
    });

    test('no status and unrecognised message → generic fallback', () {
      expect(
        mapErrorToMessage(ApiException(message: 'Something odd')),
        errorGeneric,
      );
    });
  });

  group('mapErrorToMessage — non-Dio errors', () {
    test('raw SocketException → no internet message', () {
      expect(
        mapErrorToMessage(const SocketException('down')),
        errorNoInternet,
      );
    });

    test('arbitrary exception → generic fallback', () {
      expect(mapErrorToMessage(Exception('boom')), errorGeneric);
    });

    test('null → generic fallback', () {
      expect(mapErrorToMessage(null), errorGeneric);
    });
  });
}
