import 'package:flutter_test/flutter_test.dart';
import 'package:tamir_uy_mobile_flutter/models/api/api.dart';

/// These fixtures are REAL responses captured from the running backend
/// (`GET /api/v1/...`) on 2026-08-04, so this test verifies the Phase 0/1
/// models deserialize the actual wire format — snake_case keys, nullable
/// fields, and the paginated envelope — not a hand-guessed shape.
void main() {
  group('Material / PaginatedMaterials', () {
    test('parses the real /materials envelope', () {
      final json = {
        'items': [
          {
            'id': '2f772bf6-867a-4904-9039-b81f6b8f0b18',
            'store_id': '5cd446a1-72df-47df-ae2e-1ee6fd53cdf9',
            'category': 'boyoq',
            'name_uz': 'Tikkurila Euro 3 Oq',
            'unit': 'litr',
            'price_uzs': 45000,
            'color_hex': '#FFFFFF',
            'texture_key': null,
            'pbr_roughness': 0.9,
          },
        ],
        'total': 9,
        'page': 1,
        'per_page': 1,
      };

      final page = PaginatedMaterials.fromJson(json);
      expect(page.total, 9);
      expect(page.items, hasLength(1));

      final m = page.items.single;
      expect(m.storeId, '5cd446a1-72df-47df-ae2e-1ee6fd53cdf9');
      expect(m.nameUz, 'Tikkurila Euro 3 Oq');
      expect(m.priceUzs, 45000);
      expect(m.colorHex, '#FFFFFF');
      expect(m.textureKey, isNull);
      expect(m.pbrRoughness, 0.9);
    });
  });

  group('Store', () {
    test('parses the real /stores item (null optional fields)', () {
      final s = Store.fromJson({
        'id': '458a2232-d9ca-46aa-bc49-f4beaf1e4068',
        'name': 'LaminatShop',
        'district': 'Mirzo-Ulugbek',
        'phone': '+998901234569',
        'telegram': null,
        'logo_color': null,
        'partner_tier': 'bronze',
      });
      expect(s.name, 'LaminatShop');
      expect(s.partnerTier, 'bronze');
      expect(s.telegram, isNull);
      expect(s.logoColor, isNull);
    });
  });

  group('Usta', () {
    test('parses the real /ustalar item', () {
      final u = Usta.fromJson({
        'id': 'a669235e-5446-428a-8b02-90c02f121e18',
        'name': 'Bekzod Ergashev',
        'category': 'laminat',
        'district': 'Mirzo-Ulugbek',
        'phone': '+998901111103',
        'telegram': null,
        'rating': 4.9,
        'jobs_count': 203,
        'price_min': 35000,
        'price_max': 55000,
        'verified': true,
      });
      expect(u.name, 'Bekzod Ergashev');
      expect(u.rating, 4.9);
      expect(u.jobsCount, 203);
      expect(u.priceMin, 35000);
      expect(u.priceMax, 55000);
      expect(u.verified, isTrue);
    });
  });

  group('Furniture (empty catalog)', () {
    test('parses an empty /furniture envelope', () {
      final page = PaginatedFurniture.fromJson({
        'items': <dynamic>[],
        'total': 0,
        'page': 1,
        'per_page': 1,
      });
      expect(page.items, isEmpty);
      expect(page.total, 0);
    });
  });

  group('RoomState enum', () {
    test('maps the construction-stage wire values', () {
      final rs = RoomState.fromJson({
        'room_id': '11111111-1111-1111-1111-111111111111',
        'current_state': 'suvoq',
        'floor_state': 'xom',
        'ceiling_state': null,
        'walls_state': 'tayyor',
        'updated_at': '2026-08-04T12:00:00Z',
      });
      expect(rs.currentState, RoomStateValue.suvoq);
      expect(rs.floorState, RoomStateValue.xom);
      expect(rs.ceilingState, isNull);
      expect(rs.wallsState, RoomStateValue.tayyor);
    });
  });
}
