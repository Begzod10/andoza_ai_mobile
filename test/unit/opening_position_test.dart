import 'package:flutter_test/flutter_test.dart';

import 'package:tamir_uy_mobile_flutter/utils/opening_position.dart';

/// Guards the centre-vs-left-edge contract. Getting these two confused shifted
/// every manually-measured opening by half its width once it reached the
/// backend — invisible locally, because the wizard and the summary screen
/// round-tripped symmetrically between themselves.
void main() {
  group('centreFractionToLeftEdgeM', () {
    test('subtracts half the width from the centre', () {
      // A 0.9 m door centred at 1.2 m along a 4 m wall starts at 0.75 m.
      expect(
        centreFractionToLeftEdgeM(position: 0.3, wallLengthM: 4.0, widthM: 0.9),
        closeTo(0.75, 1e-9),
      );
    });

    test('a corner-flush opening yields a negative edge rather than sliding in', () {
      expect(
        centreFractionToLeftEdgeM(position: 0.0, wallLengthM: 4.0, widthM: 0.9),
        closeTo(-0.45, 1e-9),
      );
    });
  });

  group('leftEdgeToCentreFraction', () {
    test('adds half the width back', () {
      expect(
        leftEdgeToCentreFraction(offsetM: 0.75, wallLengthM: 4.0, widthM: 0.9),
        closeTo(0.3, 1e-9),
      );
    });

    test('clamps past either end of the wall', () {
      expect(
        leftEdgeToCentreFraction(offsetM: 9.0, wallLengthM: 4.0, widthM: 0.9),
        1.0,
      );
      expect(
        leftEdgeToCentreFraction(offsetM: -9.0, wallLengthM: 4.0, widthM: 0.9),
        0.0,
      );
    });

    test('a degenerate wall falls back to centred', () {
      expect(
        leftEdgeToCentreFraction(offsetM: 0.0, wallLengthM: 0.0, widthM: 0.9),
        0.5,
      );
    });
  });

  test('round-trips without drift over repeated save/load cycles', () {
    const wall = 6.696; // a real scanned wall length
    const width = 0.9;
    var position = 0.909; // the scan's stored centre fraction

    for (var i = 0; i < 10; i++) {
      final edge = centreFractionToLeftEdgeM(
        position: position, wallLengthM: wall, widthM: width,
      );
      position = leftEdgeToCentreFraction(
        offsetM: edge, wallLengthM: wall, widthM: width,
      );
    }

    expect(position, closeTo(0.909, 1e-9));
  });
}
