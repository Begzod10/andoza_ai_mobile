import 'package:riverpod/riverpod.dart';
import '../models/api/usta.dart';
import '../repositories/masters_repository.dart';
import 'catalog_provider.dart';

/// Trade categories, one per backend `usta_category` value, plus [Trade.boshqa]
/// for anything the app hasn't been taught. NOTE: this is backend-wired —
/// [mockMastersProvider] maps the real `/ustalar` directory (via
/// [ustalarProvider]) onto the UI shape; the name is legacy, not mock data.
enum Trade {
  elektrik,
  /// Design engineer, not an installer: draws and stamps the electrical
  /// project from the written norms, before any cable is pulled.
  elektrikLoyihachi,
  santexnik,
  malyar,
  oboy,
  laminat,
  brigada,
  /// A category the backend has and this build doesn't. Rendered neutrally on
  /// purpose — see [_tradeFromCategory].
  boshqa,
}

extension TradeInfo on Trade {
  String get label => switch (this) {
    Trade.elektrik => 'Elektrik',
    Trade.elektrikLoyihachi => 'Elektrik loyihachi',
    Trade.santexnik => 'Santexnik',
    Trade.malyar => 'Malyar',
    Trade.oboy => 'Oboychi',
    Trade.laminat => 'Laminatchi',
    Trade.brigada => 'Brigada',
    Trade.boshqa => 'Boshqa usta',
  };

  String get emoji => switch (this) {
    Trade.elektrik => '⚡',
    Trade.elektrikLoyihachi => '📐',
    Trade.santexnik => '🔧',
    Trade.malyar => '🎨',
    Trade.oboy => '🧻',
    Trade.laminat => '🪵',
    Trade.brigada => '👷',
    Trade.boshqa => '🛠️',
  };

  int get colorValue => switch (this) {
    Trade.elektrik => 0xFFF59E0B,
    Trade.elektrikLoyihachi => 0xFF4F46E5,
    Trade.santexnik => 0xFF10B981,
    Trade.malyar => 0xFF8B5CF6,
    Trade.oboy => 0xFFEC4899,
    Trade.laminat => 0xFFB45309,
    Trade.brigada => 0xFF0EA5E9,
    // Deliberately the only grey pin: an unmapped category must look inert,
    // not like a real trade.
    Trade.boshqa => 0xFF6B7280,
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

/// The error that made [mockMastersProvider] empty, if any. [mockMastersProvider]
/// collapses loading AND error into an empty list, so a screen watching only it
/// can't tell "backend down" from "no craftsmen". Watch this alongside it to show
/// an error + retry instead of a misleading empty map/list; it's `null` while
/// loading and on success.
///
/// Follow-up (not done here — the U1 map / U3 list screens are outside this
/// change's ownership): have those screens watch this + [mastersLoadingProvider]
/// and render an error/retry view.
final mastersLoadErrorProvider = Provider<Object?>((ref) {
  return ref.watch(ustalarProvider(_allUstalarFilter)).error;
});

/// Whether the craftsmen directory is still loading, so the UI can distinguish
/// "loading" from "no results" — both of which leave [mockMastersProvider] empty.
final mastersLoadingProvider = Provider<bool>((ref) {
  return ref.watch(ustalarProvider(_allUstalarFilter)).isLoading;
});

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

/// Maps a server `category` slug onto the UI [Trade] enum, one-to-one with the
/// backend's `usta_category` values. Anything unrecognised — a category added
/// server-side that this build predates — becomes [Trade.boshqa]: a grey pin
/// with a neutral label that obviously isn't a real trade. A visibly
/// wrong-looking pin beats a plausible wrong one; the old default of
/// [Trade.elektrik] gave an unknown craftsman an electrician's name, icon and
/// colour, so the user had no way to tell they were calling the wrong trade.
Trade _tradeFromCategory(String category) {
  switch (category.toLowerCase()) {
    case 'elektrik':
      return Trade.elektrik;
    case 'elektrik_loyihachi':
      return Trade.elektrikLoyihachi;
    case 'santexnik':
      return Trade.santexnik;
    case 'malyar':
      return Trade.malyar;
    case 'oboy':
      return Trade.oboy;
    case 'laminat':
      return Trade.laminat;
    case 'brigada':
      return Trade.brigada;
    default:
      return Trade.boshqa;
  }
}
