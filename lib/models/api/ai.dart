import 'package:freezed_annotation/freezed_annotation.dart';

part 'ai.freezed.dart';
part 'ai.g.dart';

/// The set of pending changes the AI builder proposes for a room, applied only
/// when the user confirms. Mirrors `RoomDraft.to_patch()` in
/// `app/services/ai_builder.py` — every field is optional; only the keys the AI
/// actually set are present.
@freezed
class AiPatch with _$AiPatch {
  const factory AiPatch({
    @JsonKey(name: 'ceiling_h') double? ceilingH,
    @JsonKey(name: 'wall_lengths') Map<String, double>? wallLengths,
    Map<String, String>? surfaces,
    @JsonKey(name: 'material_colors') Map<String, String>? materialColors,
    List<Map<String, dynamic>>? furniture,
    List<Map<String, dynamic>>? lights,
  }) = _AiPatch;

  factory AiPatch.fromJson(Map<String, dynamic> json) =>
      _$AiPatchFromJson(json);
}

/// One event from the AI-builder SSE stream (`POST /rooms/{id}/ai-build`).
/// The backend sends `data: {"type": ...}` frames; [AiBuildEvent.fromJson]
/// dispatches on that `type` into the variants below.
sealed class AiBuildEvent {
  const AiBuildEvent();

  factory AiBuildEvent.fromJson(Map<String, dynamic> json) {
    switch (json['type']) {
      case 'thinking':
        return AiThinking(text: json['text'] as String? ?? '');
      case 'tool_call':
        return AiToolCall(
          name: json['name'] as String? ?? '',
          args: (json['args'] as Map?)?.cast<String, dynamic>() ?? const {},
        );
      case 'tool_result':
        return AiToolResult(
          name: json['name'] as String? ?? '',
          summary: json['summary'] as String? ?? json['result'] as String?,
        );
      case 'done':
        return AiDone(
          summary: json['summary'] as String? ?? '',
          patch: json['patch'] == null
              ? null
              : AiPatch.fromJson((json['patch'] as Map).cast<String, dynamic>()),
        );
      case 'error':
        return AiError(message: json['message'] as String? ?? 'Xato yuz berdi');
      default:
        return AiUnknown(raw: json);
    }
  }
}

/// The agent is reasoning ("So'rov tahlil qilinmoqda...").
class AiThinking extends AiBuildEvent {
  const AiThinking({required this.text});
  final String text;
}

/// The agent invoked a tool (e.g. apply_material, place_furniture).
class AiToolCall extends AiBuildEvent {
  const AiToolCall({required this.name, required this.args});
  final String name;
  final Map<String, dynamic> args;
}

/// A tool returned a result.
class AiToolResult extends AiBuildEvent {
  const AiToolResult({required this.name, this.summary});
  final String name;
  final String? summary;
}

/// The agent finished: [patch] holds the proposed changes to apply/discard.
class AiDone extends AiBuildEvent {
  const AiDone({required this.summary, this.patch});
  final String summary;
  final AiPatch? patch;
}

/// The stream errored (e.g. LLM unavailable, budget exceeded).
class AiError extends AiBuildEvent {
  const AiError({required this.message});
  final String message;
}

/// An unrecognised event type — kept so the UI can ignore it gracefully.
class AiUnknown extends AiBuildEvent {
  const AiUnknown({required this.raw});
  final Map<String, dynamic> raw;
}

/// Response from the smeta explainer (`POST /rooms/{id}/smeta/ask`).
@freezed
class SmetaAnswer with _$SmetaAnswer {
  const factory SmetaAnswer({
    @JsonKey(name: 'answer_uz') required String answerUz,
    @JsonKey(name: 'related_line_ids') @Default(<String>[]) List<String> relatedLineIds,
  }) = _SmetaAnswer;

  factory SmetaAnswer.fromJson(Map<String, dynamic> json) =>
      _$SmetaAnswerFromJson(json);
}
