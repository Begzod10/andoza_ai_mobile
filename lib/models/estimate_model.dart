import 'package:freezed_annotation/freezed_annotation.dart';

import 'design_selection_model.dart' show RenovationStage;

part 'estimate_model.freezed.dart';
part 'estimate_model.g.dart';

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

/// A group of priced [EstimateLineItem]s belonging to one of the 8 canonical
/// [RenovationStage]s.
///
/// [subtotal] is the real delta price the user is actually charged — it is
/// `0` whenever [isExcluded] is `true` (the room already had this stage's
/// work done before the app started, per the delta mechanic). [counterfactualSubtotal]
/// holds what this stage *would* have cost starting from zero, and is what
/// powers E1's green "tejaldingiz" (you saved) banner — it must be
/// populated even when [isExcluded] is `true`, since the savings banner
/// needs both figures simultaneously.
@freezed
class EstimateStage with _$EstimateStage {
  const factory EstimateStage({
    required RenovationStage name,
    @Default(<EstimateLineItem>[]) List<EstimateLineItem> lineItems,
    required double subtotal,
    @Default(false) bool isExcluded,
    @Default(0) double counterfactualSubtotal,
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
