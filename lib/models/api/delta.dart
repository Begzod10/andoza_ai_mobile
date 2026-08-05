import 'package:freezed_annotation/freezed_annotation.dart';

import 'estimate.dart';
import 'room_state.dart';

part 'delta.freezed.dart';
part 'delta.g.dart';

/// One construction stage in a delta response, flagged as already-done or not.
///
/// Mirrors `app/schemas/delta.py::DeltaStage`.
@freezed
class DeltaStage with _$DeltaStage {
  const factory DeltaStage({
    required RoomStateValue stage,
    @JsonKey(name: 'label_uz') required String labelUz,
    @JsonKey(name: 'already_done') required bool alreadyDone,
  }) = _DeltaStage;

  factory DeltaStage.fromJson(Map<String, dynamic> json) =>
      _$DeltaStageFromJson(json);
}

/// The authoritative delta calculation (`GET /rooms/{id}/delta`): the material
/// and cost difference between the room's current construction stage and a
/// fully-finished room.
///
/// Mirrors `app/schemas/delta.py::DeltaResponse`. [fullLines]/[fullTotalUzs]
/// are a reference point only; [deltaLines]/[deltaTotalUzs] are what the user
/// actually pays, and [deltaSavingsUzs] feeds the "tejaldingiz" (you saved)
/// banner.
@freezed
class DeltaResponse with _$DeltaResponse {
  const factory DeltaResponse({
    @JsonKey(name: 'room_id') required String roomId,
    @JsonKey(name: 'current_state') required RoomStateValue currentState,
    @JsonKey(name: 'full_lines') @Default(<EstimateLine>[]) List<EstimateLine> fullLines,
    @JsonKey(name: 'full_total_uzs') required int fullTotalUzs,
    @JsonKey(name: 'delta_lines') @Default(<EstimateLine>[]) List<EstimateLine> deltaLines,
    @JsonKey(name: 'delta_total_uzs') required int deltaTotalUzs,
    @JsonKey(name: 'delta_savings_uzs') required int deltaSavingsUzs,
    @JsonKey(name: 'completed_stages') @Default(<DeltaStage>[]) List<DeltaStage> completedStages,
    @JsonKey(name: 'remaining_stages') @Default(<DeltaStage>[]) List<DeltaStage> remainingStages,
  }) = _DeltaResponse;

  factory DeltaResponse.fromJson(Map<String, dynamic> json) =>
      _$DeltaResponseFromJson(json);
}
