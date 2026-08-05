import 'package:freezed_annotation/freezed_annotation.dart';

part 'estimate.freezed.dart';
part 'estimate.g.dart';

/// One line item in a computed smeta.
///
/// Mirrors `app/schemas/estimate.py::EstimateLine`. All money is in whole UZS
/// (the backend does its internal math in tiyin and exposes UZS here).
@freezed
class EstimateLine with _$EstimateLine {
  const factory EstimateLine({
    required String label,
    required String formula,
    required double quantity,
    required String unit,
    @JsonKey(name: 'unit_price') required int unitPrice,
    @JsonKey(name: 'total_uzs') required int totalUzs,
    @JsonKey(name: 'is_approximate') @Default(false) bool isApproximate,
    @JsonKey(name: 'store_id') String? storeId,
    @Default('') String category,
  }) = _EstimateLine;

  factory EstimateLine.fromJson(Map<String, dynamic> json) =>
      _$EstimateLineFromJson(json);
}

/// A full computed/persisted estimate (`POST /rooms/{id}/estimate[/preview]`).
///
/// Mirrors `app/schemas/estimate.py::EstimateResponse`.
@freezed
class Estimate with _$Estimate {
  const factory Estimate({
    required String id,
    @JsonKey(name: 'room_id') required String roomId,
    @Default(<EstimateLine>[]) List<EstimateLine> lines,
    @JsonKey(name: 'total_uzs') required int totalUzs,
    @JsonKey(name: 'total_min') required int totalMin,
    @JsonKey(name: 'total_max') required int totalMax,
    @Default('UZS') String currency,
    @Default('final') String status,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'has_electrical') @Default(false) bool hasElectrical,
  }) = _Estimate;

  factory Estimate.fromJson(Map<String, dynamic> json) =>
      _$EstimateFromJson(json);
}

/// Lightweight row for the estimate-history list (`GET /rooms/{id}/estimates`).
///
/// Mirrors `app/schemas/estimate.py::EstimateSummary`.
@freezed
class EstimateSummary with _$EstimateSummary {
  const factory EstimateSummary({
    required String id,
    @JsonKey(name: 'room_id') required String roomId,
    @JsonKey(name: 'total_uzs') required int totalUzs,
    required String currency,
    required String status,
    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _EstimateSummary;

  factory EstimateSummary.fromJson(Map<String, dynamic> json) =>
      _$EstimateSummaryFromJson(json);
}

/// Paginated envelope for `GET /rooms/{id}/estimates`.
@freezed
class PaginatedEstimates with _$PaginatedEstimates {
  const factory PaginatedEstimates({
    @Default(<EstimateSummary>[]) List<EstimateSummary> items,
    @Default(0) int total,
    @Default(20) int limit,
    @Default(0) int offset,
  }) = _PaginatedEstimates;

  factory PaginatedEstimates.fromJson(Map<String, dynamic> json) =>
      _$PaginatedEstimatesFromJson(json);
}
