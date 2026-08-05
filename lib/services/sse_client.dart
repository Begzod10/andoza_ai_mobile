import 'dart:convert';

/// A single Server-Sent Event parsed off the wire.
///
/// The backend's AI builder (`POST /rooms/{id}/ai-build`) streams events like
/// `thinking`, `tool_call`, `tool_result`, `done`, and `error`, each carrying a
/// JSON `data` payload. [event] defaults to `"message"` per the SSE spec when
/// the server omits an explicit `event:` line.
class SseEvent {
  const SseEvent({required this.event, required this.data});

  final String event;
  final String data;

  /// Convenience: decode [data] as a JSON object. Returns an empty map if the
  /// payload isn't valid JSON (e.g. a bare keep-alive), so callers don't crash.
  Map<String, dynamic> get json {
    try {
      final decoded = jsonDecode(data);
      return decoded is Map<String, dynamic> ? decoded : <String, dynamic>{};
    } on FormatException {
      return <String, dynamic>{};
    }
  }

  @override
  String toString() => 'SseEvent(event: $event, data: $data)';
}

/// Transforms a raw byte stream (as produced by dio's `ResponseType.stream`)
/// into discrete [SseEvent]s following the text/event-stream framing rules:
/// lines are grouped into events, a blank line dispatches the accumulated
/// event, `:`-prefixed lines are comments/keep-alives, and multiple `data:`
/// lines within one event are joined with newlines.
Stream<SseEvent> parseSseStream(Stream<List<int>> byteStream) async* {
  final lines = byteStream
      .transform(utf8.decoder)
      .transform(const LineSplitter());

  var eventName = 'message';
  final dataLines = <String>[];

  await for (final line in lines) {
    if (line.isEmpty) {
      // Blank line = dispatch the buffered event.
      if (dataLines.isNotEmpty) {
        yield SseEvent(event: eventName, data: dataLines.join('\n'));
      }
      eventName = 'message';
      dataLines.clear();
      continue;
    }
    if (line.startsWith(':')) {
      // Comment / keep-alive — ignore.
      continue;
    }
    if (line.startsWith('event:')) {
      eventName = line.substring(6).trim();
    } else if (line.startsWith('data:')) {
      // Per spec, a single leading space after the colon is stripped.
      dataLines.add(line.substring(5).replaceFirst(RegExp(r'^ '), ''));
    }
    // Other fields (id:, retry:) are not used by this backend; ignore.
  }

  // Flush any trailing event that wasn't terminated by a blank line.
  if (dataLines.isNotEmpty) {
    yield SseEvent(event: eventName, data: dataLines.join('\n'));
  }
}
