/// Where an application stands with the admins. Anything the server sends that
/// we do not know is treated as pending — the safe reading (not live, not
/// rejected) for a state the app cannot explain.
enum ModerationStatus {
  pending,
  approved,
  rejected;

  static ModerationStatus parse(Object? raw) => switch (raw) {
        'approved' => ModerationStatus.approved,
        'rejected' => ModerationStatus.rejected,
        _ => ModerationStatus.pending,
      };
}

/// What the signed-in account is, from `GET /account/roles`. There is no role
/// column on the server: a person is always a user, a shop owner when they own
/// a shop and an usta when they own a craftsman profile (in any status, so an
/// applicant already sees their own business area). Someone can be all three.
class AccountRoles {
  const AccountRoles({
    this.roles = const ['user'],
    this.storeStatus,
    this.storeName,
    this.ustaStatus,
    this.ustaName,
  });

  /// Before the first answer arrives, and when it cannot be fetched: an
  /// ordinary user, which is what everyone is at the least.
  static const plainUser = AccountRoles();

  final List<String> roles;
  final ModerationStatus? storeStatus;
  final String? storeName;
  final ModerationStatus? ustaStatus;
  final String? ustaName;

  bool get isShopOwner => roles.contains('shop_owner');
  bool get isUsta => roles.contains('usta');
  bool get hasBusiness => isShopOwner || isUsta;

  factory AccountRoles.fromJson(Map<String, dynamic> json) {
    ModerationStatus? status(String key) =>
        json[key] == null ? null : ModerationStatus.parse(json[key]);
    return AccountRoles(
      roles: [for (final r in (json['roles'] as List<dynamic>? ?? const ['user'])) r as String],
      storeStatus: status('store_status'),
      storeName: json['store_name'] as String?,
      ustaStatus: status('usta_status'),
      ustaName: json['usta_name'] as String?,
    );
  }
}

/// The caller's own shop (`/seller/store`).
class ShopProfile {
  const ShopProfile({
    required this.id,
    required this.name,
    required this.status,
    this.district,
    this.phone,
    this.telegram,
    this.moderationNote,
  });

  final String id;
  final String name;
  final String? district;
  final String? phone;
  final String? telegram;
  final ModerationStatus status;
  final String? moderationNote;

  factory ShopProfile.fromJson(Map<String, dynamic> json) => ShopProfile(
        id: json['id'] as String,
        name: json['name'] as String,
        district: json['district'] as String?,
        phone: json['phone'] as String?,
        telegram: json['telegram'] as String?,
        status: ModerationStatus.parse(json['status']),
        moderationNote: json['moderation_note'] as String?,
      );
}

/// The trades an usta can be listed under; `wire` is the backend's value.
enum UstaTrade {
  elektrik('elektrik'),
  elektrikLoyihachi('elektrik_loyihachi'),
  santexnik('santexnik'),
  malyar('malyar'),
  oboy('oboy'),
  laminat('laminat'),
  brigada('brigada');

  const UstaTrade(this.wire);
  final String wire;

  static UstaTrade? parse(Object? raw) {
    for (final t in values) {
      if (t.wire == raw) return t;
    }
    return null;
  }
}

/// The caller's own usta profile (`/usta/profile`).
class UstaProfile {
  const UstaProfile({
    required this.id,
    required this.name,
    required this.status,
    this.trade,
    this.district,
    this.phone,
    this.telegram,
    this.priceMin,
    this.priceMax,
    this.rating = 0,
    this.jobsCount = 0,
    this.verified = false,
    this.moderationNote,
  });

  final String id;
  final String name;
  final UstaTrade? trade;
  final String? district;
  final String? phone;
  final String? telegram;
  final int? priceMin;
  final int? priceMax;
  final double rating;
  final int jobsCount;
  final bool verified;
  final ModerationStatus status;
  final String? moderationNote;

  factory UstaProfile.fromJson(Map<String, dynamic> json) => UstaProfile(
        id: json['id'] as String,
        name: json['name'] as String,
        trade: UstaTrade.parse(json['category']),
        district: json['district'] as String?,
        phone: json['phone'] as String?,
        telegram: json['telegram'] as String?,
        priceMin: (json['price_min'] as num?)?.toInt(),
        priceMax: (json['price_max'] as num?)?.toInt(),
        rating: (json['rating'] as num?)?.toDouble() ?? 0,
        jobsCount: (json['jobs_count'] as num?)?.toInt() ?? 0,
        verified: json['verified'] as bool? ?? false,
        status: ModerationStatus.parse(json['status']),
        moderationNote: json['moderation_note'] as String?,
      );
}

/// One of the shop's own 3D models (`/seller/furniture`), in any moderation status.
class ShopProduct {
  const ShopProduct({
    required this.id,
    required this.name,
    required this.category,
    required this.status,
    required this.isActive,
    this.priceUzs,
    this.thumbnailUrl,
    this.moderationNote,
  });

  final String id;
  final String name;
  final String category;
  final int? priceUzs;
  final String? thumbnailUrl;
  final ModerationStatus status;
  final bool isActive;
  final String? moderationNote;

  factory ShopProduct.fromJson(Map<String, dynamic> json) => ShopProduct(
        id: json['id'] as String,
        name: json['name_uz'] as String,
        category: json['category'] as String,
        priceUzs: (json['price_uzs'] as num?)?.toInt(),
        thumbnailUrl: json['thumbnail_url'] as String?,
        status: ModerationStatus.parse(json['status']),
        isActive: json['is_active'] as bool? ?? false,
        moderationNote: json['moderation_note'] as String?,
      );
}

/// A "3D model from a photo" background job (`GET /jobs/{id}`).
class ModelJob {
  const ModelJob({this.key, this.error});

  /// Storage key of the finished GLB.
  final String? key;
  final String? error;

  bool get isDone => key != null;
  bool get isFailed => error != null;

  factory ModelJob.fromJson(Map<String, dynamic> json) {
    final state = json['status'] as String?;
    final result = json['result'];
    if (state == 'SUCCESS' && result is Map<String, dynamic>) {
      if (result['status'] == 'ok' && result['key'] is String) {
        return ModelJob(key: result['key'] as String);
      }
      return ModelJob(error: (result['error'] as String?) ?? 'failed');
    }
    if (state == 'FAILURE' || state == 'REVOKED') return const ModelJob(error: 'failed');
    return const ModelJob();
  }
}
