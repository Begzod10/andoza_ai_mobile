import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tamir_uy_mobile_flutter/features/room_scan/models/captured_room.dart';
import 'package:tamir_uy_mobile_flutter/features/room_scan/room_scan_converter.dart';
import 'package:tamir_uy_mobile_flutter/features/room_scan/room_scan_service.dart';
import 'package:tamir_uy_mobile_flutter/l10n/app_localizations.dart';
import 'package:tamir_uy_mobile_flutter/screens/scanning/room_scan_review_page.dart';

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
const List<({double x, double z})> _corners = [
  (x: 0.00, z: 0.00),
  (x: 6.70, z: 0.00),
  (x: 6.70, z: 5.64),
  (x: 0.95, z: 5.64),
  (x: 0.00, z: 4.91),
];

/// RoomPlan's world origin sits at device height, not on the floor.
const double _floorY = -1.6;
const double _ceilingH = 3.18;

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

List<ScanSurface> _walls() {
  final out = <ScanSurface>[];
  for (var i = 0; i < _corners.length; i++) {
    final a = _corners[i];
    final b = _corners[(i + 1) % _corners.length];
    final dx = b.x - a.x, dz = b.z - a.z;
    final len = math.sqrt(dx * dx + dz * dz);
    out.add(ScanSurface(
      dimensions: Vec3(len, _ceilingH, 0.1),
      transform: ScanTransform(_transform(
        dx: dx,
        dz: dz,
        cx: (a.x + b.x) / 2,
        cy: _floorY + _ceilingH / 2,
        cz: (a.z + b.z) / 2,
      )),
      confidence: ScanConfidence.high,
    ));
  }
  return out;
}

/// A point at fraction [t] along the wall between corner [i] and [i]+1.
({double x, double z}) _along(int i, double t) {
  final a = _corners[i];
  final b = _corners[(i + 1) % _corners.length];
  return (x: a.x + (b.x - a.x) * t, z: a.z + (b.z - a.z) * t);
}

/// The measured door: wall 0, w=1.14 h=2.20 sill=0.000 pos=0.91.
ScanSurface _door({ScanConfidence confidence = ScanConfidence.high}) {
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
ScanSurface _window({ScanConfidence confidence = ScanConfidence.high}) {
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
List<ScanObject> _objects() {
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

RoomScanReviewArgs _args(CapturedRoom room) {
  final draft = RoomScanConverter.toRoomDraft(room);
  return RoomScanReviewArgs(
    draft: draft,
    scan: ScanResult(
      room: room,
      rawJson: '{}',
      usdzPath: '/tmp/scan.usdz',
      version: 'roomplan-1',
    ),
  );
}

Future<void> _pump(WidgetTester tester, CapturedRoom room) async {
  await tester.pumpWidget(
    ProviderScope(
      child: MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: const Locale('uz'),
        home: RoomScanReviewPage(args: _args(room)),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('the summary reports the detected walls, door, window and objects',
      (tester) async {
    await _pump(
      tester,
      CapturedRoom(
        walls: _walls(),
        doors: [_door()],
        windows: [_window()],
        objects: _objects(),
      ),
    );

    expect(find.text('Nimalar aniqlandi'), findsOneWidget);
    expect(find.text('5 Devor'), findsOneWidget);
    expect(find.text('1 Eshik'), findsOneWidget);
    expect(find.text('1 Deraza'), findsOneWidget);
    expect(find.text('16 Buyum'), findsOneWidget);
    // Both openings were found, so the rescan hint stays out of the way.
    expect(find.textContaining('Shisha va ochiq eshiklar'), findsNothing);
  });

  testWidgets('zero detected doors surfaces the glass/open-door rescan hint',
      (tester) async {
    // Matches the real scan of this room that came back with no doors at all.
    await _pump(
      tester,
      CapturedRoom(
        walls: _walls(),
        doors: const [],
        windows: [_window()],
        objects: _objects(),
      ),
    );

    expect(find.text('0 Eshik'), findsOneWidget);
    expect(find.text('1 Deraza'), findsOneWidget);
    expect(find.textContaining('Shisha va ochiq eshiklar'), findsOneWidget);
    expect(find.textContaining('Yaqinroqdan, sekinroq'), findsOneWidget);
    // The rescan affordance the hint points at is on this screen.
    final rescan = find.text('Qayta skanerlash');
    await tester.scrollUntilVisible(rescan, 300);
    expect(rescan, findsOneWidget);
  });

  testWidgets('a low-confidence opening is flagged', (tester) async {
    await _pump(
      tester,
      CapturedRoom(
        walls: _walls(),
        doors: [_door(confidence: ScanConfidence.low)],
        windows: [_window()],
        objects: _objects(),
      ),
    );

    expect(find.textContaining('1 ta element past aniqlikda'), findsOneWidget);
  });
}
