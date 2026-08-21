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
    test('maps each server category slug onto the right UI trade', () async {
      final masters = await _masters([
        _usta(id: 'e', category: 'elektrik'),
        _usta(id: 's', category: 'santexnik'),
        _usta(id: 'm', category: 'malyar'),
        _usta(id: 'o', category: 'oboy'),
        _usta(id: 'l', category: 'laminat'),
        _usta(id: 'b', category: 'brigada'),
      ]);
      final byId = {for (final m in masters) m.master.id: m.trade};
      expect(byId['e'], Trade.elektrik);
      expect(byId['s'], Trade.santexnik);
      expect(byId['m'], Trade.suvoqchi); // malyar → suvoqchi (painter)
      expect(byId['o'], Trade.suvoqchi); // oboy → suvoqchi
      expect(byId['l'], Trade.kafelchi); // laminat → kafelchi
      expect(byId['b'], Trade.duradgor); // brigada → duradgor
    });

    test('an unknown category defaults to elektrik instead of crashing',
        () async {
      final masters = await _masters([_usta(id: 'x', category: 'mystery_trade')]);
      expect(masters.single.trade, Trade.elektrik);
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
