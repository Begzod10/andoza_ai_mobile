import 'dart:ui';
import 'package:freezed_annotation/freezed_annotation.dart';

/// Converts between [Offset] and a plain `{dx, dy}` JSON map.
///
/// [Offset] is not natively JSON-serializable, so all coordinates
/// (electrical, furniture, etc.) are routed through this converter to keep
/// encoding/decoding explicit and defensive against numbers arriving as `int` from JSON.
class OffsetConverter implements JsonConverter<Offset, Map<String, dynamic>> {
  const OffsetConverter();

  @override
  Offset fromJson(Map<String, dynamic> json) {
    final dx = json['dx'];
    final dy = json['dy'];
    if (dx is! num || dy is! num) {
      throw FormatException('Invalid offset json: $json');
    }
    return Offset(dx.toDouble(), dy.toDouble());
  }

  @override
  Map<String, dynamic> toJson(Offset object) => {
        'dx': object.dx,
        'dy': object.dy,
      };
}
