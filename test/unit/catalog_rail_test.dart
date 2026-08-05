import 'package:flutter/material.dart' hide Material;
import 'package:flutter_test/flutter_test.dart';
import 'package:tamir_uy_mobile_flutter/models/api/catalog.dart';
import 'package:tamir_uy_mobile_flutter/utils/catalog_rail.dart';

/// Verifies the material→rail mapping that powers the C1 paint/wallpaper rail,
/// using real seeded catalog values (paint `#FFFFFF`, tile `#9E9E9E`, …).
void main() {
  group('hexToColor', () {
    test('parses #RRGGBB as opaque', () {
      expect(hexToColor('#FFFFFF'), const Color(0xFFFFFFFF));
      expect(hexToColor('#9E9E9E'), const Color(0xFF9E9E9E));
    });

    test('accepts hex without the leading #', () {
      expect(hexToColor('8B6F47'), const Color(0xFF8B6F47));
    });

    test('returns null for missing/malformed input', () {
      expect(hexToColor(null), isNull);
      expect(hexToColor('nope'), isNull);
      expect(hexToColor('#12'), isNull);
    });
  });

  group('materialsToRailItems', () {
    test('maps real paint materials to labelled, coloured swatches', () {
      final materials = [
        const Material(
          id: '2f772bf6-867a-4904-9039-b81f6b8f0b18',
          storeId: 's1',
          category: 'boyoq',
          nameUz: 'Tikkurila Euro 3 Oq',
          unit: 'litr',
          priceUzs: 45000,
          colorHex: '#FFFFFF',
          pbrRoughness: 0.9,
        ),
        const Material(
          id: 'm2',
          storeId: 's1',
          category: 'boyoq',
          nameUz: 'Tikkurila Optiva Kulrang',
          unit: 'litr',
          priceUzs: 48000,
          colorHex: '#C0BFBC',
        ),
      ];

      final items = materialsToRailItems(materials);
      expect(items, hasLength(2));
      // The catalog id is preserved so a selection can map back to the row.
      expect(items.first.id, '2f772bf6-867a-4904-9039-b81f6b8f0b18');
      expect(items.first.label, 'Tikkurila Euro 3 Oq');
      expect(items.first.color, const Color(0xFFFFFFFF));
      expect(items[1].color, const Color(0xFFC0BFBC));
    });

    test('leaves color null when the material has no hex', () {
      final items = materialsToRailItems([
        const Material(
          id: 'm3',
          storeId: 's1',
          category: 'oboy',
          nameUz: 'Naqshli oboy',
          unit: 'rulon',
          priceUzs: 85000,
        ),
      ]);
      expect(items.single.color, isNull);
      expect(items.single.label, 'Naqshli oboy');
    });
  });
}
