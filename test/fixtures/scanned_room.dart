import 'dart:math' as math;

import 'package:tamir_uy_mobile_flutter/features/room_scan/models/captured_room.dart';

/// Fixture built from a real measured scan of the computer lab (the room whose
/// six RoomPlan scans motivated this summary):
///
///   5 walls: 6.70, 5.64, 5.75, 1.20, 4.91 m, ceiling 3.18 m, area 37.45 m²
///   wall 0: eshik  w=1.14 h=2.20 sill=0.000 pos=0.91
///   wall 4: deraza w=3.62 h=1.74 sill=1.068 pos=0.42
///   objects: 12 chair, 3 table, 1 storage
///
/// The floor-plan corners below reproduce those wall lengths and the 37.45 m²
/// area exactly (shoelace = 37.44 m²): a 6.70 × 5.64 rectangle with one corner
/// cut off by the 1.20 m diagonal.
const List<({double x, double z})> scanCorners = [
  (x: 0.00, z: 0.00),
  (x: 6.70, z: 0.00),
  (x: 6.70, z: 5.64),
  (x: 0.95, z: 5.64),
  (x: 0.00, z: 4.91),
];

/// RoomPlan's world origin sits at device height, not on the floor.
const double _floorY = -1.6;
const double scanCeilingH = 3.18;

/// Column-major `simd_float4x4` whose local X axis runs along `(dx, 0, dz)`.
List<double> _transform({
  required double dx,
  required double dz,
  required double cx,
  required double cy,
  required double cz,
}) {
  final len = math.sqrt(dx * dx + dz * dz);
  final ux = dx / len, uz = dz / len;
  return <double>[
    ux, 0, uz, 0, // col 0 — length axis
    0, 1, 0, 0, // col 1 — up
    -uz, 0, ux, 0, // col 2
    cx, cy, cz, 1, // col 3 — translation
  ];
}

List<ScanSurface> scanWalls() {
  final out = <ScanSurface>[];
  for (var i = 0; i < scanCorners.length; i++) {
    final a = scanCorners[i];
    final b = scanCorners[(i + 1) % scanCorners.length];
    final dx = b.x - a.x, dz = b.z - a.z;
    final len = math.sqrt(dx * dx + dz * dz);
    out.add(ScanSurface(
      dimensions: Vec3(len, scanCeilingH, 0.1),
      transform: ScanTransform(_transform(
        dx: dx,
        dz: dz,
        cx: (a.x + b.x) / 2,
        cy: _floorY + scanCeilingH / 2,
        cz: (a.z + b.z) / 2,
      )),
      confidence: ScanConfidence.high,
    ));
  }
  return out;
}

/// A point at fraction [t] along the wall between corner [i] and [i]+1.
({double x, double z}) _along(int i, double t) {
  final a = scanCorners[i];
  final b = scanCorners[(i + 1) % scanCorners.length];
  return (x: a.x + (b.x - a.x) * t, z: a.z + (b.z - a.z) * t);
}

/// The measured door: wall 0, w=1.14 h=2.20 sill=0.000 pos=0.91.
ScanSurface scanDoor({ScanConfidence confidence = ScanConfidence.high}) {
  final p = _along(0, 0.91);
  return ScanSurface(
    dimensions: const Vec3(1.14, 2.20, 0.05),
    transform: ScanTransform(_transform(
      dx: 1,
      dz: 0,
      cx: p.x,
      cy: _floorY + 2.20 / 2,
      cz: p.z,
    )),
    confidence: confidence,
  );
}

/// The measured window: wall 4, w=3.62 h=1.74 sill=1.068 pos=0.42.
ScanSurface scanWindow({ScanConfidence confidence = ScanConfidence.high}) {
  final p = _along(4, 0.42);
  return ScanSurface(
    dimensions: const Vec3(3.62, 1.74, 0.05),
    transform: ScanTransform(_transform(
      dx: 0,
      dz: -1,
      cx: p.x,
      cy: _floorY + 1.068 + 1.74 / 2,
      cz: p.z,
    )),
    confidence: confidence,
  );
}

/// 12 chairs + 3 tables + 1 storage, spread over the floor.
List<ScanObject> scanObjects() {
  final out = <ScanObject>[];
  void add(ScanObjectCategory c, double w, double h, double d, int n) {
    for (var i = 0; i < n; i++) {
      out.add(ScanObject(
        category: c,
        dimensions: Vec3(w, h, d),
        transform: ScanTransform(_transform(
          dx: 1,
          dz: 0,
          cx: 1.0 + (i % 4) * 1.3,
          cy: _floorY + h / 2,
          cz: 1.0 + (i ~/ 4) * 1.2,
        )),
      ));
    }
  }

  add(ScanObjectCategory.chair, 0.5, 0.9, 0.5, 12);
  add(ScanObjectCategory.table, 1.4, 0.75, 0.7, 3);
  add(ScanObjectCategory.storage, 0.9, 1.8, 0.45, 1);
  return out;
}
