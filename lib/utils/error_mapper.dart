import 'dart:io';

import 'package:dio/dio.dart';

import '../services/api_client.dart';

/// Centralized, single-source-of-truth error → user-message mapping.
///
/// Turns any thrown error — especially a [DioException] (timeout, no
/// connection, 4xx/5xx) or the app's own [ApiException] wrapper — into a short,
/// user-friendly **Uzbek** message safe to show in an [ErrorView], a snackbar
/// or an inline banner. It never leaks a raw exception/stack string to the UI.
///
/// Covered cases: no internet / connection, timeout, 400/422 (validation),
/// 401 (session expired), 403 (forbidden), 404 (not found), 409 (conflict),
/// 5xx / server, and a generic fallback for everything else.
String mapErrorToMessage(Object? error) {
  if (error is DioException) return _mapDio(error);
  if (error is ApiException) return _mapApiException(error);
  if (error is SocketException) return errorNoInternet;
  return errorGeneric;
}

/// "No internet / connection" — the device can't reach the network at all.
const String errorNoInternet = 'Internet aloqasi yo\'q. Ulanishni tekshiring.';

/// The request reached the network but the server didn't answer in time.
const String errorTimeout = 'Server javob bermadi. Qayta urinib ko\'ring.';

/// 400 / 422 — the request payload failed client-side / server-side validation.
const String errorValidation =
    'Kiritilgan ma\'lumotlar noto\'g\'ri. Tekshirib, qaytadan kiriting.';

/// 401 — the session is no longer valid; the user must re-authenticate.
const String errorSession = 'Sessiya tugadi. Iltimos, qaytadan kiring.';

/// 403 — authenticated, but not allowed to perform this action.
const String errorForbidden = 'Bu amalni bajarishga ruxsatingiz yo\'q.';

/// 404 — the requested resource doesn't exist.
const String errorNotFound = 'Ma\'lumot topilmadi.';

/// 409 — the request conflicts with the current server state.
const String errorConflict =
    'Ma\'lumotlarda ziddiyat yuz berdi. Iltimos, qaytadan urinib ko\'ring.';

/// 5xx / bad certificate — the server itself failed.
const String errorServer =
    'Serverda xatolik yuz berdi. Birozdan so\'ng urinib ko\'ring.';

/// Fallback for anything not otherwise recognised.
const String errorGeneric = 'Xatolik yuz berdi. Qayta urinib ko\'ring.';

String _mapDio(DioException error) {
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
    case DioExceptionType.transformTimeout:
      return errorTimeout;
    case DioExceptionType.connectionError:
      return errorNoInternet;
    case DioExceptionType.badCertificate:
      return errorServer;
    case DioExceptionType.badResponse:
      return _mapStatus(error.response?.statusCode);
    case DioExceptionType.cancel:
      return errorGeneric;
    case DioExceptionType.unknown:
      if (error.error is SocketException) return errorNoInternet;
      return errorGeneric;
  }
}

/// [ApiException] (thrown by [ApiClient]) keeps the HTTP status code for
/// bad responses but flattens the [DioExceptionType] into a message string for
/// transport/timeout failures — so map by status code when present, otherwise
/// fall back to matching the known message markers the client produces.
String _mapApiException(ApiException error) {
  final statusCode = error.statusCode;
  if (statusCode != null) return _mapStatus(statusCode);
  final message = error.message.toLowerCase();
  if (message.contains('timeout')) return errorTimeout;
  if (message.contains('network') || message.contains('connection')) {
    return errorNoInternet;
  }
  if (message.contains('server')) return errorServer;
  return errorGeneric;
}

String _mapStatus(int? statusCode) {
  if (statusCode == null) return errorGeneric;
  if (statusCode == 400 || statusCode == 422) return errorValidation;
  if (statusCode == 401) return errorSession;
  if (statusCode == 403) return errorForbidden;
  if (statusCode == 404) return errorNotFound;
  if (statusCode == 409) return errorConflict;
  if (statusCode >= 500) return errorServer;
  return errorGeneric;
}
