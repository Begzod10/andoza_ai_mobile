import 'package:flutter_test/flutter_test.dart';
import 'package:tamir_uy_mobile_flutter/models/api/api.dart';

/// The event fixtures below are REAL frames captured from the running backend's
/// SSE stream (`POST /rooms/{id}/ai-build`) on 2026-08-06 (with a placeholder
/// LLM key, which is why the terminal event is an error). This verifies the
/// Phase 6 event/patch parsing against the actual wire format.
void main() {
  group('AiBuildEvent.fromJson', () {
    test('parses a thinking frame', () {
      final e = AiBuildEvent.fromJson({
        'type': 'thinking',
        'text': "So'rov tahlil qilinmoqda...",
      });
      expect(e, isA<AiThinking>());
      expect((e as AiThinking).text, "So'rov tahlil qilinmoqda...");
    });

    test('parses an error frame (real 401 from the LLM)', () {
      final e = AiBuildEvent.fromJson({
        'type': 'error',
        'message': 'Error code: 401 - Incorrect API key provided',
      });
      expect(e, isA<AiError>());
      expect((e as AiError).message, contains('401'));
    });

    test('parses a tool_call frame', () {
      final e = AiBuildEvent.fromJson({
        'type': 'tool_call',
        'name': 'apply_material',
        'args': {'surface': 'A', 'material_id': 'abc'},
      });
      expect(e, isA<AiToolCall>());
      final tc = e as AiToolCall;
      expect(tc.name, 'apply_material');
      expect(tc.args['surface'], 'A');
    });

    test('parses a done frame with a patch', () {
      final e = AiBuildEvent.fromJson({
        'type': 'done',
        'summary': 'Devorlar oq rangga bo\'yaldi',
        'patch': {
          'ceiling_h': 2.9,
          'surfaces': {'A': 'mat-1', 'B': 'mat-1'},
          'material_colors': {'A': '#FFFFFF'},
          'furniture': [
            {'furniture_id': 'f1', 'x': 1.0, 'y': 2.0},
          ],
        },
      });
      expect(e, isA<AiDone>());
      final done = e as AiDone;
      expect(done.summary, 'Devorlar oq rangga bo\'yaldi');
      expect(done.patch, isNotNull);
      expect(done.patch!.ceilingH, 2.9);
      expect(done.patch!.surfaces, {'A': 'mat-1', 'B': 'mat-1'});
      expect(done.patch!.materialColors, {'A': '#FFFFFF'});
      expect(done.patch!.furniture, hasLength(1));
    });

    test('unknown type falls back to AiUnknown, not a crash', () {
      final e = AiBuildEvent.fromJson({'type': 'heartbeat'});
      expect(e, isA<AiUnknown>());
    });
  });

  group('SmetaAnswer', () {
    test('parses the explainer response', () {
      final a = SmetaAnswer.fromJson({
        'answer_uz': 'Suvoq narxi 25000 so\'m.',
        'related_line_ids': ['0', '2'],
      });
      expect(a.answerUz, 'Suvoq narxi 25000 so\'m.');
      expect(a.relatedLineIds, ['0', '2']);
    });
  });
}
