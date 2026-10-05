import '../models/business_profile.dart';
import '../services/api_client.dart';

/// The signed-in account's businesses: which roles it has, and its own shop and
/// usta profile. Every call acts on the caller — the server finds the shop and
/// the profile from the token, there is no id to pass.
class BusinessRepository {
  BusinessRepository(this._client);

  final ApiClient _client;

  Future<AccountRoles> fetchRoles() => _client.get<AccountRoles>(
        '/account/roles',
        fromJson: (j) => AccountRoles.fromJson(j as Map<String, dynamic>),
      );

  // --- Shop ---------------------------------------------------------------

  /// The caller's shop, or null when they have none ("not a seller yet").
  Future<ShopProfile?> fetchShop() => _client.get<ShopProfile?>(
        '/seller/store',
        fromJson: (j) => j == null ? null : ShopProfile.fromJson(j as Map<String, dynamic>),
      );

  Future<ShopProfile> applyShop({
    required String name,
    String? district,
    String? phone,
    String? telegram,
  }) =>
      _client.post<ShopProfile>(
        '/seller/store',
        data: {
          'name': name,
          'district': ?_blankToNull(district),
          'phone': ?_blankToNull(phone),
          'telegram': ?_blankToNull(telegram),
        },
        fromJson: (j) => ShopProfile.fromJson(j as Map<String, dynamic>),
      );

  Future<ShopProfile> resubmitShop() => _client.post<ShopProfile>(
        '/seller/store/resubmit',
        data: const <String, dynamic>{},
        fromJson: (j) => ShopProfile.fromJson(j as Map<String, dynamic>),
      );

  // --- Usta ---------------------------------------------------------------

  Future<UstaProfile?> fetchUsta() => _client.get<UstaProfile?>(
        '/usta/profile',
        fromJson: (j) => j == null ? null : UstaProfile.fromJson(j as Map<String, dynamic>),
      );

  Future<UstaProfile> applyUsta({
    required String name,
    required UstaTrade trade,
    required String phone,
    String? district,
    String? telegram,
    int? priceMin,
    int? priceMax,
  }) =>
      _client.post<UstaProfile>(
        '/usta/profile',
        data: {
          'name': name,
          'category': trade.wire,
          'phone': phone,
          'district': ?_blankToNull(district),
          'telegram': ?_blankToNull(telegram),
          'price_min': ?priceMin,
          'price_max': ?priceMax,
        },
        fromJson: (j) => UstaProfile.fromJson(j as Map<String, dynamic>),
      );

  Future<UstaProfile> resubmitUsta() => _client.post<UstaProfile>(
        '/usta/profile/resubmit',
        data: const <String, dynamic>{},
        fromJson: (j) => UstaProfile.fromJson(j as Map<String, dynamic>),
      );
}

String? _blankToNull(String? s) {
  final t = s?.trim();
  return (t == null || t.isEmpty) ? null : t;
}
