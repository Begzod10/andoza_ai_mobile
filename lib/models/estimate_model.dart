import 'package:freezed_annotation/freezed_annotation.dart';

part 'estimate_model.freezed.dart';
part 'estimate_model.g.dart';

/// Named phase of work an [EstimateStage] contributes pricing for.
enum EstimateStageName {
  @JsonValue('FLOOR')
  floor,
  @JsonValue('PAINT')
  paint,
  @JsonValue('FURNITURE')
  furniture,
  @JsonValue('ELECTRICAL')
  electrical,
  @JsonValue('MEP')
  mep,
}

/// A single priced line within an [EstimateStage] (e.g. one material or
/// labor item).
@freezed
class EstimateLineItem with _$EstimateLineItem {
  const factory EstimateLineItem({
    required String id,
    required String description,
    required double quantity,
    required double unitPrice,
    required double lineTotal,
  }) = _EstimateLineItem;

  factory EstimateLineItem.fromJson(Map<String, dynamic> json) =>
      _$EstimateLineItemFromJson(json);
}

/// A group of priced [EstimateLineItem]s belonging to one phase of work
/// (floor, paint, furniture, electrical or MEP).
@freezed
class EstimateStage with _$EstimateStage {
  const factory EstimateStage({
    required EstimateStageName name,
    @Default(<EstimateLineItem>[]) List<EstimateLineItem> lineItems,
    required double subtotal,
  }) = _EstimateStage;

  factory EstimateStage.fromJson(Map<String, dynamic> json) =>
      _$EstimateStageFromJson(json);
}

/// The full cost estimate generated for a single room, aggregating every
/// priced stage of work into a total.
@freezed
class Estimate with _$Estimate {
  const factory Estimate({
    required String id,
    required String roomId,
    required double roomArea,
    @Default(<EstimateStage>[]) List<EstimateStage> stages,
    required double totalPrice,
    required String currency,
    required DateTime createdAt,
  }) = _Estimate;

  factory Estimate.fromJson(Map<String, dynamic> json) =>
      _$EstimateFromJson(json);
}
