/// Do'kon (Batch S) domain types.
library;

// Mock/local-only — no backend `/shop` endpoint exists, same rationale as
// masters_provider.dart's [MockMaster].

enum ShopCategory {
  boyoq,
  oboy,
  laminat,
  kafel,
  parket,
  gips,
  sement,
  santexnika,
  elektr,
}

extension ShopCategoryInfo on ShopCategory {
  String get label => switch (this) {
    ShopCategory.boyoq => 'Bo\'yoq',
    ShopCategory.oboy => 'Oboy',
    ShopCategory.laminat => 'Laminat',
    ShopCategory.kafel => 'Kafel',
    ShopCategory.parket => 'Parket',
    ShopCategory.gips => 'Gips',
    ShopCategory.sement => 'Sement',
    ShopCategory.santexnika => 'Santexnika',
    ShopCategory.elektr => 'Elektr',
  };
}

/// A shop product. [projectQuantity] is non-null only when the app can
/// compute how much of this item the active project actually needs (the
/// delta mechanic) — that quantity, never a hardcoded guess, is what
/// renders in S1's banner, S2's grouped list, and S3's recommendation card.
class Product {
  const Product({
    required this.id,
    required this.name,
    required this.brand,
    required this.category,
    required this.pricePerUnit,
    required this.unit,
    required this.isOfficialDealer,
    this.coverage,
    this.dryingTime,
    this.washable,
    this.projectQuantity,
  });

  final String id;
  final String name;
  final String brand;
  final ShopCategory category;
  final int pricePerUnit;
  final String unit;
  final bool isOfficialDealer;
  final String? coverage;
  final String? dryingTime;
  final bool? washable;

  /// Real computed requirement for the active project, or null if this
  /// product isn't tied to the current renovation stage's material need.
  final double? projectQuantity;

  bool get isInProject => projectQuantity != null;
}

class Dealer {
  const Dealer({
    required this.id,
    required this.name,
    required this.isOfficial,
    required this.district,
    required this.deliveryDays,
    required this.pricePerUnit,
  });

  final String id;
  final String name;
  final bool isOfficial;
  final String district;
  final int deliveryDays;
  final int pricePerUnit;

  /// Value equality by [id] — used as a Map key by cart_provider.dart's
  /// grouped-by-dealer view, so identity equality would be wrong here.
  @override
  bool operator ==(Object other) => other is Dealer && other.id == id;

  @override
  int get hashCode => id.hashCode;
}

class CartLine {
  const CartLine({
    required this.product,
    required this.dealer,
    required this.quantity,
  });

  final Product product;
  final Dealer dealer;
  final double quantity;

  int get lineTotal => (dealer.pricePerUnit * quantity).round();

  CartLine copyWith({double? quantity}) => CartLine(
    product: product,
    dealer: dealer,
    quantity: quantity ?? this.quantity,
  );
}

/// One stage's worth of required materials for S2's grouped list — built
/// from the same [RenovationStage] enum the delta mechanic already uses,
/// so a stage the room's starting condition already excludes never shows
/// up here (nothing to buy for work that's already done).
class StageMaterialGroup {
  const StageMaterialGroup({required this.stageLabel, required this.items});

  final String stageLabel;
  final List<StageMaterialItem> items;
}

class StageMaterialItem {
  const StageMaterialItem({
    required this.name,
    required this.quantity,
    required this.unit,
  });

  final String name;
  final double quantity;
  final String unit;
}

enum OrderStep { accepted, gathering, onTheWay, delivered }

extension OrderStepInfo on OrderStep {
  String get label => switch (this) {
    OrderStep.accepted => 'Qabul qilindi',
    OrderStep.gathering => 'Yig\'ilmoqda',
    OrderStep.onTheWay => 'Yo\'lda',
    OrderStep.delivered => 'Yetkazildi',
  };
}

class ShopOrder {
  const ShopOrder({
    required this.id,
    required this.lines,
    required this.total,
    required this.currentStep,
    required this.dealerName,
    required this.createdAt,
  });

  final String id;
  final List<CartLine> lines;
  final int total;
  final OrderStep currentStep;
  final String dealerName;
  final DateTime createdAt;
}
