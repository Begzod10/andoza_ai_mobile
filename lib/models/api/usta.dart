import 'package:freezed_annotation/freezed_annotation.dart';

part 'usta.freezed.dart';
part 'usta.g.dart';

/// A craftsman ("usta") from the directory (`GET /api/v1/ustalar`).
///
/// Mirrors `app/schemas/usta.py::UstaOut`. [priceMin]/[priceMax] are a UZS
/// per-unit range and may be null when the usta hasn't published pricing.
@freezed
class Usta with _$Usta {
  const factory Usta({
    required String id,
    required String name,
    required String category,
    String? district,
    required String phone,
    String? telegram,
    @Default(0.0) double rating,
    @JsonKey(name: 'jobs_count') @Default(0) int jobsCount,
    @JsonKey(name: 'price_min') int? priceMin,
    @JsonKey(name: 'price_max') int? priceMax,
    @Default(false) bool verified,
  }) = _Usta;

  factory Usta.fromJson(Map<String, dynamic> json) => _$UstaFromJson(json);
}
