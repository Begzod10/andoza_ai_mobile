import 'package:freezed_annotation/freezed_annotation.dart';

part 'material_offer.freezed.dart';
part 'material_offer.g.dart';

/// One store's offer for a material (`GET /api/v1/materials/{id}/offers`).
///
/// The endpoint returns an array of these, cheapest first. Each row is a real
/// per-store price/stock/delivery quote for the same material, replacing the
/// old synthetic `dealersForProduct()` fabrication in S4. [storePartnerTier]
/// ∈ standard|gold|platinum.
@freezed
class MaterialOffer with _$MaterialOffer {
  const factory MaterialOffer({
    required String id,
    @JsonKey(name: 'material_id') required String materialId,
    @JsonKey(name: 'store_id') required String storeId,
    @JsonKey(name: 'store_name') required String storeName,
    @JsonKey(name: 'store_district') String? storeDistrict,
    @JsonKey(name: 'store_partner_tier') required String storePartnerTier,
    @JsonKey(name: 'price_uzs') required int priceUzs,
    @JsonKey(name: 'in_stock') required bool inStock,
    @JsonKey(name: 'delivery_days') required int deliveryDays,
  }) = _MaterialOffer;

  factory MaterialOffer.fromJson(Map<String, dynamic> json) =>
      _$MaterialOfferFromJson(json);
}
