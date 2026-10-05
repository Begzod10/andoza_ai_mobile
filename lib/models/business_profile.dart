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

enum LeadStatus {
  fresh('new'),
  viewed('viewed'),
  contacted('contacted'),
  closed('closed');

  const LeadStatus(this.wire);
  final String wire;

  static LeadStatus parse(Object? raw) => values.firstWhere((s) => s.wire == raw, orElse: () => LeadStatus.fresh);
}

/// A customer request in the usta's inbox (`GET /usta/leads`).
class UstaLead {
  const UstaLead({
    required this.id,
    required this.status,
    required this.createdAt,
    this.clientName,
    this.clientPhone,
    this.roomName,
    this.totalUzs,
    this.linesCount = 0,
  });

  final String id;
  final LeadStatus status;
  final DateTime createdAt;
  final String? clientName;
  final String? clientPhone;
  final String? roomName;
  final int? totalUzs;
  final int linesCount;

  factory UstaLead.fromJson(Map<String, dynamic> json) => UstaLead(
        id: json['id'] as String,
        status: LeadStatus.parse(json['status']),
        createdAt: DateTime.parse(json['created_at'] as String),
        clientName: json['client_name'] as String?,
        clientPhone: json['client_phone'] as String?,
        roomName: json['room_name'] as String?,
        totalUzs: (json['total_uzs'] as num?)?.toInt(),
        linesCount: (json['lines_count'] as num?)?.toInt() ?? 0,
      );
}

/// A customer inquiry about a shop's product (`GET /seller/inquiries`).
class ShopInquiry {
  const ShopInquiry({
    required this.id,
    required this.status,
    required this.createdAt,
    this.clientName,
    this.clientPhone,
    this.message,
    this.productName,
    this.roomName,
  });

  final String id;
  final LeadStatus status;
  final DateTime createdAt;
  final String? clientName;
  final String? clientPhone;
  final String? message;
  final String? productName;
  final String? roomName;

  factory ShopInquiry.fromJson(Map<String, dynamic> json) => ShopInquiry(
    id: json['id'].toString(),
    status: LeadStatus.parse(json['status']),
    createdAt: DateTime.parse(json['created_at'] as String),
    clientName: json['client_name'] as String?,
    clientPhone: json['client_phone'] as String?,
    message: json['message'] as String?,
    productName: json['product_name'] as String?,
    roomName: json['room_name'] as String?,
  );
}

class TopProduct {
  const TopProduct({
    required this.id,
    required this.name,
    required this.placements,
  });

  final String id;
  final String name;
  final int placements;

  factory TopProduct.fromJson(Map<String, dynamic> json) => TopProduct(
    id: json['id'].toString(),
    name: (json['name_uz'] as String?) ?? '',
    placements: (json['placements'] as num?)?.toInt() ?? 0,
  );
}

/// Shop dashboard numbers (`GET /seller/stats`).
class SellerStats {
  const SellerStats({
    this.productsTotal = 0,
    this.productsApproved = 0,
    this.productsPending = 0,
    this.productsRejected = 0,
    this.visible = 0,
    this.inquiriesTotal = 0,
    this.inquiriesNew = 0,
    this.placementsTotal = 0,
    this.topProducts = const [],
  });

  final int productsTotal;
  final int productsApproved;
  final int productsPending;
  final int productsRejected;
  final int visible;
  final int inquiriesTotal;
  final int inquiriesNew;
  final int placementsTotal;
  final List<TopProduct> topProducts;

  factory SellerStats.fromJson(Map<String, dynamic> json) {
    int n(Object? v) => (v as num?)?.toInt() ?? 0;
    final p = (json['products'] as Map<String, dynamic>?) ?? const {};
    final q = (json['inquiries'] as Map<String, dynamic>?) ?? const {};
    return SellerStats(
      productsTotal: n(p['total']),
      productsApproved: n(p['approved']),
      productsPending: n(p['pending']),
      productsRejected: n(p['rejected']),
      visible: n(json['visible']),
      inquiriesTotal: n(q['total']),
      inquiriesNew: n(q['new']),
      placementsTotal: n(json['placements_total']),
      topProducts: [
        for (final t in (json['top_products'] as List<dynamic>? ?? const []))
          TopProduct.fromJson(t as Map<String, dynamic>),
      ],
    );
  }
}
