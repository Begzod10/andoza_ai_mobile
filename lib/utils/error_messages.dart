import '../services/api_client.dart';

/// Maps any thrown [error] onto a short, friendly Uzbek message suitable for
/// showing to the user (in a SnackBar, toast, or error panel).
///
/// The networking layer ([ApiClient]) converts every failure into an
/// [ApiException] carrying an English/technical `message` and an HTTP
/// `statusCode`. Surfacing that raw string ("HTTP 500: ...", "Unauthorized")
/// in an Uzbek app is confusing, so this function classifies the error by its
/// status code and returns a localized, human-readable equivalent instead.
///
/// Non-[ApiException] errors (unexpected/programmer errors) fall back to a
/// generic Uzbek message rather than leaking a Dart exception string.
String userFacingError(Object error) {
  if (error is ApiException) {
    final status = error.statusCode;

    // No status code → the request never reached the server (connection /
    // send / receive timeout, DNS/socket failure, bad certificate).
    if (status == null) {
      return _networkError;
    }

    return switch (status) {
      400 || 422 => _validationError,
      401 => _sessionExpired,
      403 => _forbidden,
      404 => _notFound,
      409 => _conflict,
      >= 500 => _serverError,
      _ => _genericError,
    };
  }

  return _genericError;
}

const String _networkError =
    'Internetga ulanishda muammo. Aloqani tekshirib, qayta urinib ko\'ring.';

const String _serverError =
    'Serverda vaqtinchalik xatolik yuz berdi. Birozdan so\'ng qayta urinib ko\'ring.';

const String _notFound = 'Ma\'lumot topilmadi.';

const String _sessionExpired =
    'Sessiya muddati tugadi. Iltimos, tizimga qaytadan kiring.';

const String _forbidden = 'Bu amalni bajarishga ruxsatingiz yo\'q.';

const String _validationError =
    'Kiritilgan ma\'lumotlar noto\'g\'ri. Tekshirib, qaytadan kiriting.';

const String _conflict =
    'Ma\'lumotlarda ziddiyat yuz berdi. Iltimos, qaytadan urinib ko\'ring.';

const String _genericError =
    'Xatolik yuz berdi. Iltimos, qaytadan urinib ko\'ring.';
