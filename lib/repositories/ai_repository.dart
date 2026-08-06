import '../models/api/api.dart';
import '../services/api_client.dart';

/// Access to the AI features: the room-builder agent (SSE) and the smeta
/// explainer. Paths are relative to the `/api/v1` base.
class AiRepository {
  AiRepository(this._client);

  final ApiClient _client;

  /// Runs the AI room-builder for [prompt] and yields typed [AiBuildEvent]s as
  /// they stream in (thinking → tool calls → done/error). The terminal event is
  /// either [AiDone] (with a patch to apply) or [AiError].
  Stream<AiBuildEvent> build(String roomId, String prompt) {
    return _client
        .stream('/rooms/$roomId/ai-build', method: 'POST', data: {'prompt': prompt})
        .map((sse) => AiBuildEvent.fromJson(sse.json));
  }

  /// Asks the smeta explainer a question about the room's estimate.
  Future<SmetaAnswer> smetaAsk(String roomId, String question) {
    return _client.post<SmetaAnswer>(
      '/rooms/$roomId/smeta/ask',
      data: {'question': question},
      fromJson: (json) => SmetaAnswer.fromJson(json as Map<String, dynamic>),
    );
  }
}
