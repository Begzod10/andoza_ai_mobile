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

  /// Changes only what is passed; blank name/phone are left alone, a blank
  /// district/telegram clears the field.
  Future<ShopProfile> updateShop({String? name, String? district, String? phone, String? telegram}) =>
      _client.patch<ShopProfile>(
        '/seller/store',
        data: {
          'name': ?_blankToNull(name),
          'district': ?district,
          'phone': ?_blankToNull(phone),
          'telegram': ?telegram,
        },
        fromJson: (j) => ShopProfile.fromJson(j as Map<String, dynamic>),
      );

  Future<ShopProfile> resubmitShop() => _client.post<ShopProfile>(
        '/seller/store/resubmit',
        data: const <String, dynamic>{},
        fromJson: (j) => ShopProfile.fromJson(j as Map<String, dynamic>),
      );

  // --- Shop products -------------------------------------------------------

  Future<List<ShopProduct>> fetchProducts() => _client.get<List<ShopProduct>>(
        '/seller/furniture',
        queryParameters: {'per_page': 100},
        fromJson: (j) => [
          for (final i in (j as Map<String, dynamic>)['items'] as List<dynamic>)
            ShopProduct.fromJson(i as Map<String, dynamic>),
        ],
      );

  /// Changes only what is passed; [priceUzs] of null leaves the price alone.
  Future<ShopProduct> updateProduct(String id, {String? name, int? priceUzs, bool? isActive}) =>
      _client.patch<ShopProduct>(
        '/seller/furniture/$id',
        data: {'name_uz': ?name, 'price_uzs': ?priceUzs, 'is_active': ?isActive},
        fromJson: (j) => ShopProduct.fromJson(j as Map<String, dynamic>),
      );

  /// Starts building a 3D model from a photo (Tripo, 1–2 minutes); returns the job id.
  /// [extraViews] maps `left` / `back` / `right` to an extra photo
  /// `(bytes, filename, contentType)`; with extras Tripo builds from all views.
  Future<String> startModelFromPhoto(
    List<int> bytes,
    String filename,
    String contentType, {
    Map<String, (List<int>, String, String)> extraViews = const {},
  }) {
    String parse(dynamic j) => (j as Map<String, dynamic>)['job_id'] as String;
    if (extraViews.isEmpty) {
      return _client.uploadFile<String>(
        '/models/from-photo',
        bytes: bytes,
        filename: filename,
        contentType: contentType,
        fromJson: parse,
      );
    }
    return _client.uploadFiles<String>(
      '/models/from-photo',
      files: [
        ('file', bytes, filename, contentType),
        for (final e in extraViews.entries) (e.key, e.value.$1, e.value.$2, e.value.$3),
      ],
      fromJson: parse,
    );
  }

  /// The job's state: a finished one carries the built model's storage `key`,
  /// a failed one an `error`. `null` key and null error mean still working.
  Future<ModelJob> fetchModelJob(String jobId) => _client.get<ModelJob>(
        '/jobs/$jobId',
        fromJson: (j) => ModelJob.fromJson(j as Map<String, dynamic>),
      );

  Future<List<int>> fetchBuiltModel(String key) =>
      _client.getBytes('/models/from-photo/glb', queryParameters: {'key': key});

  /// Adds the built model to the shop; it waits for an admin like any upload.
  Future<ShopProduct> createProduct({
    required List<int> glb,
    required List<int> thumbnail,
    required String thumbnailType,
    required String name,
    required String category,
    required String placement,
    String? roomType,
    int? priceUzs,
  }) =>
      _client.uploadFiles<ShopProduct>(
        '/seller/furniture',
        files: [
          ('file', glb, 'model.glb', 'model/gltf-binary'),
          ('thumbnail', thumbnail, 'photo.${thumbnailType == 'image/png' ? 'png' : 'jpg'}', thumbnailType),
        ],
        fields: {
          'name_uz': name,
          'category': category,
          'placement': placement,
          'room_type': ?roomType,
          'price_uzs': ?priceUzs?.toString(),
        },
        fromJson: (j) => ShopProduct.fromJson(j as Map<String, dynamic>),
      );

  Future<void> deleteProduct(String id) => _client.delete('/seller/furniture/$id');

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

  /// Changes only what is passed.
  Future<UstaProfile> updateUsta({
    String? name,
    UstaTrade? trade,
    String? district,
    String? phone,
    String? telegram,
    int? priceMin,
    int? priceMax,
  }) =>
      _client.patch<UstaProfile>(
        '/usta/profile',
        data: {
          'name': ?_blankToNull(name),
          'category': ?trade?.wire,
          'district': ?district,
          'phone': ?_blankToNull(phone),
          'telegram': ?telegram,
          'price_min': ?priceMin,
          'price_max': ?priceMax,
        },
        fromJson: (j) => UstaProfile.fromJson(j as Map<String, dynamic>),
      );

  Future<List<UstaLead>> fetchLeads() => _client.get<List<UstaLead>>(
        '/usta/leads',
        fromJson: (j) => [for (final i in j as List<dynamic>) UstaLead.fromJson(i as Map<String, dynamic>)],
      );

  Future<UstaLead> setLeadStatus(String id, LeadStatus status) => _client.patch<UstaLead>(
        '/usta/leads/$id',
        data: {'status': status.wire},
        fromJson: (j) => UstaLead.fromJson(j as Map<String, dynamic>),
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
