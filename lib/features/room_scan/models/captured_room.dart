import 'dart:math' as math;

import 'package:freezed_annotation/freezed_annotation.dart';

part 'captured_room.freezed.dart';

/// Models for the subset of Apple RoomPlan `CapturedRoom` JSON we actually
/// consume. This is deliberately NOT the full Apple schema — only what the
/// converter needs (walls, doors, windows, openings, objects; each with
/// dimensions, transform, confidence; objects also a category).
///
/// Parsing is intentionally defensive (see [parseCapturedRoom]): unknown keys
/// are ignored, malformed entries are skipped, and unknown object categories
/// fall back to [ScanObjectCategory.other]. The native side encodes this via
/// `JSONEncoder().encode(CapturedRoom)` (Phase 2); the exact simd encodings are
/// documented at each parse helper and are the main thing to re-verify against a
/// real device export.

enum ScanConfidence { high, medium, low }

/// Internal furniture category. Apple's `CapturedRoom.Object.Category` strings
/// map onto this; anything unrecognised becomes [other].
enum ScanObjectCategory {
  table,
  chair,
  sofa,
  bed,
  storage,
  refrigerator,
  stove,
  sink,
  toilet,
  bathtub,
  washer,
  television,
  fireplace,
  stairs,
  other,
}

@freezed
class Vec3 with _$Vec3 {
  const factory Vec3(double x, double y, double z) = _Vec3;
}

/// A 4×4 transform, stored as 16 floats in **column-major** order (Apple's
/// `simd_float4x4`). Element (row r, col c) is at index `c * 4 + r`.
@freezed
class ScanTransform with _$ScanTransform {
  const ScanTransform._();
  const factory ScanTransform(List<double> m) = _ScanTransform;

  /// The identity transform — fallback when a transform is missing/malformed.
  factory ScanTransform.identity() => const ScanTransform(
        <double>[1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1],
      );

  /// World-space translation = the 4th column (indices 12,13,14).
  Vec3 get translation => Vec3(m[12], m[13], m[14]);

  /// Yaw around the world Y axis, radians. The local X axis (column 0) is
  /// `(m[0], m[1], m[2])`; its projection on the XZ plane gives the heading.
  double get yRotationRad => math.atan2(m[2], m[0]);
}

/// A planar RoomPlan surface (wall/door/window/opening). The surface *kind* is
/// determined by which list it lives in on [CapturedRoom], so it isn't stored
/// here.
@freezed
class ScanSurface with _$ScanSurface {
  const factory ScanSurface({
    required Vec3 dimensions,
    required ScanTransform transform,
    @Default(ScanConfidence.medium) ScanConfidence confidence,
  }) = _ScanSurface;
}

/// A detected furniture/object in the room.
@freezed
class ScanObject with _$ScanObject {
  const factory ScanObject({
    required ScanObjectCategory category,
    required Vec3 dimensions,
    required ScanTransform transform,
    @Default(ScanConfidence.medium) ScanConfidence confidence,
  }) = _ScanObject;
}

@freezed
class CapturedRoom with _$CapturedRoom {
  const factory CapturedRoom({
    @Default(<ScanSurface>[]) List<ScanSurface> walls,
    @Default(<ScanSurface>[]) List<ScanSurface> doors,
    @Default(<ScanSurface>[]) List<ScanSurface> windows,
    @Default(<ScanSurface>[]) List<ScanSurface> openings,
    @Default(<ScanObject>[]) List<ScanObject> objects,
  }) = _CapturedRoom;
}

// ─────────────────────────── Defensive parsing ───────────────────────────

CapturedRoom parseCapturedRoom(Map<String, dynamic> json) {
  return CapturedRoom(
    walls: _surfaces(json['walls']),
    doors: _surfaces(json['doors']),
    windows: _surfaces(json['windows']),
    openings: _surfaces(json['openings']),
    objects: _objects(json['objects']),
  );
}

List<ScanSurface> _surfaces(Object? raw) {
  if (raw is! List) return const [];
  final out = <ScanSurface>[];
  for (final e in raw) {
    if (e is! Map) continue;
    final map = e.cast<String, dynamic>();
    final dims = _vec3(map['dimensions']);
    if (dims == null) continue; // a surface with no size is unusable
    out.add(ScanSurface(
      dimensions: dims,
      transform: _transform(map['transform']),
      confidence: _confidence(map['confidence']),
    ));
  }
  return out;
}

List<ScanObject> _objects(Object? raw) {
  if (raw is! List) return const [];
  final out = <ScanObject>[];
  for (final e in raw) {
    if (e is! Map) continue;
    final map = e.cast<String, dynamic>();
    final dims = _vec3(map['dimensions']);
    if (dims == null) continue;
    out.add(ScanObject(
      category: _category(map['category']),
      dimensions: dims,
      transform: _transform(map['transform']),
      confidence: _confidence(map['confidence']),
    ));
  }
  return out;
}

/// `dimensions` is `simd_float3` → a 3-element array `[x, y, z]`.
Vec3? _vec3(Object? raw) {
  if (raw is! List || raw.length < 3) return null;
  final x = _toDouble(raw[0]);
  final y = _toDouble(raw[1]);
  final z = _toDouble(raw[2]);
  if (x == null || y == null || z == null) return null;
  return Vec3(x, y, z);
}

/// `transform` is `simd_float4x4`. Accept either a flat 16-array (column-major)
/// or a nested 4×4 (4 columns of 4); normalise to a flat-16 column-major list.
/// Falls back to identity when malformed.
ScanTransform _transform(Object? raw) {
  if (raw is! List) return ScanTransform.identity();
  // Nested 4×4 → flatten column-major.
  if (raw.isNotEmpty && raw.first is List) {
    final flat = <double>[];
    for (final col in raw) {
      if (col is! List) return ScanTransform.identity();
      for (final v in col) {
        final d = _toDouble(v);
        if (d == null) return ScanTransform.identity();
        flat.add(d);
      }
    }
    return flat.length == 16 ? ScanTransform(flat) : ScanTransform.identity();
  }
  // Flat array.
  final flat = <double>[];
  for (final v in raw) {
    final d = _toDouble(v);
    if (d == null) return ScanTransform.identity();
    flat.add(d);
  }
  return flat.length == 16 ? ScanTransform(flat) : ScanTransform.identity();
}

ScanConfidence _confidence(Object? raw) {
  switch (raw is String ? raw.toLowerCase() : '') {
    case 'high':
      return ScanConfidence.high;
    case 'low':
      return ScanConfidence.low;
    case 'medium':
      return ScanConfidence.medium;
    default:
      return ScanConfidence.medium;
  }
}

/// Apple's `CapturedRoom.Object.Category`. It may encode as a bare string
/// (`"chair"`) or as a single-key object (`{"chair": {}}`) depending on SDK —
/// handle both, and map onto our internal enum. Unknown → [other].
ScanObjectCategory _category(Object? raw) {
  String? key;
  if (raw is String) {
    key = raw;
  } else if (raw is Map && raw.isNotEmpty) {
    key = raw.keys.first.toString();
  }
  switch (key?.toLowerCase()) {
    case 'table':
      return ScanObjectCategory.table;
    case 'chair':
      return ScanObjectCategory.chair;
    case 'sofa':
      return ScanObjectCategory.sofa;
    case 'bed':
      return ScanObjectCategory.bed;
    case 'storage':
      return ScanObjectCategory.storage;
    case 'refrigerator':
      return ScanObjectCategory.refrigerator;
    case 'stove':
    case 'oven':
      return ScanObjectCategory.stove;
    case 'sink':
      return ScanObjectCategory.sink;
    case 'toilet':
      return ScanObjectCategory.toilet;
    case 'bathtub':
      return ScanObjectCategory.bathtub;
    case 'washer':
    case 'washerdryer':
    case 'dishwasher':
      return ScanObjectCategory.washer;
    case 'television':
      return ScanObjectCategory.television;
    case 'fireplace':
      return ScanObjectCategory.fireplace;
    case 'stairs':
      return ScanObjectCategory.stairs;
    default:
      return ScanObjectCategory.other;
  }
}

double? _toDouble(Object? v) {
  if (v is num) return v.toDouble();
  if (v is String) return double.tryParse(v);
  return null;
}
