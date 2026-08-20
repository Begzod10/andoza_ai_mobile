import 'package:riverpod/riverpod.dart';
import '../models/api/usta.dart';
import '../repositories/masters_repository.dart';
import 'catalog_provider.dart';

/// Trade categories per spec's exact color-per-trade mapping. No backend
/// `/masters` endpoint exists — mock data only for this rebuild pass,
/// consistent with the plan's guidance for Batch U/S.
enum Trade { elektrik, suvoqchi, kafelchi, santexnik, duradgor }

extension TradeInfo on Trade {
  String get label => switch (this) {
    Trade.elektrik => 'Elektrik',
    Trade.suvoqchi => 'Suvoqchi',
    Trade.kafelchi => 'Kafelchi',
    Trade.santexnik => 'Santexnik',
    Trade.duradgor => 'Duradgor',
  };

  String get emoji => switch (this) {
    Trade.elektrik => '⚡',
    Trade.suvoqchi => '🎨',
    Trade.kafelchi => '🧱',
    Trade.santexnik => '🔧',
    Trade.duradgor => '🪚',
  };

  int get colorValue => switch (this) {
    Trade.elektrik => 0xFFF59E0B,
    Trade.suvoqchi => 0xFF8B5CF6,
    Trade.kafelchi => 0xFF0EA5E9,
    Trade.santexnik => 0xFF10B981,
    Trade.duradgor => 0xFFB45309,
  };
}

class MockMaster {
  const MockMaster({
    required this.master,
    required this.trade,
    required this.areaName,
    required this.experienceYears,
    required this.isOnline,
    required this.isVerified,
  });

  final Master master;
  final Trade trade;

  /// Approximate area only — per spec's privacy rule, never an exact
  /// address.
  final String areaName;
  final int experienceYears;
  final bool isOnline;
  final bool isVerified;
}

/// Ustalar shown on the U1 map / U3 list, built from the real backend
/// `/ustalar` directory. Kept a synchronous [Provider] so the map/list
/// consumers stay unchanged; while the request is loading (or on error) it
/// yields an empty list rather than throwing.
final mockMastersProvider = Provider<List<MockMaster>>((ref) {
  return ref
      .watch(ustalarProvider(_allUstalarFilter))
      .maybeWhen(
        data: (list) => list.map(_toMockMaster).toList(),
        orElse: () => const <MockMaster>[],
      );
});

/// No category/district filter → the full craftsmen directory.
const UstaFilter _allUstalarFilter = (category: null, district: null);

/// Maps a backend [Usta] onto the UI's [MockMaster] shape. Fields the server
/// doesn't provide ([MockMaster.experienceYears], [MockMaster.isOnline]) are
/// derived or defaulted; a null `lat`/`lng` flows through to [Master] and is
/// guarded by the map consumer.
MockMaster _toMockMaster(Usta usta) {
  return MockMaster(
    master: Master(
      id: usta.id,
      name: usta.name,
      avatar: usta.avatarUrl,
      specialty: usta.category,
      rating: usta.rating,
      reviewCount: usta.jobsCount,
      latitude: usta.lat,
      longitude: usta.lng,
      distanceKm: null,
    ),
    trade: _tradeFromCategory(usta.category),
    areaName: usta.district ?? '',
    // No experience field on the backend — approximate from completed jobs
    // (~1 year per dozen), clamped to a sane range, falling back to 5.
    experienceYears: usta.jobsCount > 0
        ? (usta.jobsCount / 12).clamp(1, 25).round()
        : 5,
    // No presence signal on the backend yet — assume reachable.
    isOnline: true,
    isVerified: usta.verified,
  );
}

/// Maps a server `category` slug onto the UI [Trade] enum. The enum has fewer
/// members than the catalog, so several categories collapse onto the closest
/// visual trade. Unknown/unmapped values default to [Trade.elektrik] so the
/// pin still renders instead of crashing.
Trade _tradeFromCategory(String category) {
  switch (category.toLowerCase()) {
    case 'elektrik':
      return Trade.elektrik;
    case 'santexnik':
      return Trade.santexnik;
    case 'malyar':
      return Trade.suvoqchi;
    case 'oboy':
      return Trade.suvoqchi;
    case 'laminat':
      return Trade.kafelchi;
    case 'brigada':
      return Trade.duradgor;
    default:
      return Trade.elektrik;
  }
}
