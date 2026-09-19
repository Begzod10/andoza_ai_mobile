import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod/riverpod.dart';
import 'package:tamir_uy_mobile_flutter/models/api/usta.dart';
import 'package:tamir_uy_mobile_flutter/providers/catalog_provider.dart';
import 'package:tamir_uy_mobile_flutter/providers/masters_provider.dart';

/// The exact (unfiltered) filter [mockMastersProvider] watches; records have
/// structural equality so overriding this key reaches the provider.
const UstaFilter _allFilter = (category: null, district: null);

Future<List<MockMaster>> _masters(List<Usta> ustalar) async {
  final container = ProviderContainer(
    overrides: [
      ustalarProvider(_allFilter).overrideWith((ref) async => ustalar),
    ],
  );
  addTearDown(container.dispose);
  await container.read(ustalarProvider(_allFilter).future);
  return container.read(mockMastersProvider);
}

/// The backend's `usta_category` enum, verbatim. Every value must map onto a
/// Trade of its own; [Trade.boshqa] exists only for values NOT in this list.
const List<String> _backendCategories = [
  'elektrik',
  'elektrik_loyihachi',
  'santexnik',
  'malyar',
  'oboy',
  'laminat',
  'brigada',
];

Usta _usta({
  required String id,
  required String category,
  String name = 'Aliyev',
  String phone = '998900000000',
  String? district,
  double rating = 4.5,
  int jobsCount = 0,
  bool verified = false,
  double? lat,
  double? lng,
}) =>
    Usta(
      id: id,
      name: name,
      category: category,
      phone: phone,
      district: district,
      rating: rating,
      jobsCount: jobsCount,
      verified: verified,
      lat: lat,
      lng: lng,
    );

void main() {
  group('_tradeFromCategory (via mockMastersProvider)', () {
    test('every backend usta_category maps to its own distinct trade',
        () async {
      final masters = await _masters([
        for (final c in _backendCategories) _usta(id: c, category: c),
      ]);
      final byCategory = {for (final m in masters) m.master.id: m.trade};

      expect(byCategory['elektrik'], Trade.elektrik);
      // Mapped explicitly, not via the unknown-category fallback — a design
      // engineer must never render as the installer.
      expect(byCategory['elektrik_loyihachi'], Trade.elektrikLoyihachi);
      expect(byCategory['santexnik'], Trade.santexnik);
      expect(byCategory['malyar'], Trade.malyar);
      expect(byCategory['oboy'], Trade.oboy);
      expect(byCategory['laminat'], Trade.laminat);
      expect(byCategory['brigada'], Trade.brigada);

      // No two categories may share a trade — the regression that let the
      // painter and the wallpaper fitter collapse into one filter chip.
      expect(
        byCategory.values.toSet().length,
        _backendCategories.length,
        reason: 'two backend categories map onto the same Trade',
      );
      // And none of them may land on the unknown bucket: a category the
      // backend has must be taught to the app, not silently swept up.
      expect(byCategory.values, isNot(contains(Trade.boshqa)));
    });

    test('an unknown category maps to boshqa, never to elektrik', () async {
      final masters = await _masters([
        _usta(id: 'x', category: 'mystery_trade'),
        _usta(id: 'y', category: ''),
      ]);
      for (final m in masters) {
        expect(
          m.trade,
          Trade.boshqa,
          reason: 'an unmapped category must fail visibly, not pose as an '
              'electrician',
        );
      }
    });

    test('a new backend category cannot be added without teaching the app',
        () async {
      // Guard: keep [_backendCategories] in step with the server's
      // `usta_category` enum. Adding one there without a case in
      // _tradeFromCategory makes the distinctness test above fail loudly.
      expect(_backendCategories, hasLength(Trade.values.length - 1));
    });

    test('every trade has a non-empty label, an emoji and a colour', () {
      for (final trade in Trade.values) {
        expect(trade.label, isNotEmpty, reason: '${trade.name} has no label');
        expect(trade.emoji, isNotEmpty, reason: '${trade.name} has no emoji');
        // Opaque ARGB — a 0 colour would paint an invisible pin.
        expect(trade.colorValue & 0xFF000000, 0xFF000000,
            reason: '${trade.name} has no opaque colour');
      }
      // Labels and pin colours are what the user actually tells trades apart
      // by, so they must be distinct too.
      expect(Trade.values.map((t) => t.label).toSet(),
          hasLength(Trade.values.length));
      expect(Trade.values.map((t) => t.colorValue).toSet(),
          hasLength(Trade.values.length));
    });
  });

  group('Usta → MockMaster field mapping', () {
    test('lat/lng flow through to the Master, including null', () async {
      final masters = await _masters([
        _usta(id: 'geo', category: 'elektrik', lat: 41.31, lng: 69.24),
        _usta(id: 'nogeo', category: 'santexnik'),
      ]);
      final byId = {for (final m in masters) m.master.id: m.master};
      expect(byId['geo']!.latitude, closeTo(41.31, 1e-9));
      expect(byId['geo']!.longitude, closeTo(69.24, 1e-9));
      expect(byId['nogeo']!.latitude, isNull);
      expect(byId['nogeo']!.longitude, isNull);
    });

    test('district → areaName, verified → isVerified, jobsCount → reviewCount',
        () async {
      final masters = await _masters([
        _usta(
          id: 'u1',
          category: 'elektrik',
          name: 'Karimov',
          district: 'Chilonzor',
          jobsCount: 36,
          verified: true,
        ),
      ]);
      final m = masters.single;
      expect(m.areaName, 'Chilonzor');
      expect(m.isVerified, isTrue);
      expect(m.isOnline, isTrue); // no backend presence signal → assumed online
      expect(m.master.reviewCount, 36);
      expect(m.master.specialty, 'elektrik');
      // ~1 year of experience per dozen jobs → 36/12 = 3.
      expect(m.experienceYears, 3);
    });

    test('experienceYears falls back to 5 when there are no completed jobs',
        () async {
      final masters = await _masters([_usta(id: 'u1', category: 'elektrik')]);
      expect(masters.single.experienceYears, 5);
    });

    test('a null district maps to an empty areaName', () async {
      final masters = await _masters([_usta(id: 'u1', category: 'elektrik')]);
      expect(masters.single.areaName, '');
    });
  });
}
