import 'package:riverpod/riverpod.dart';
import '../repositories/masters_repository.dart';

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

final mockMastersProvider = Provider<List<MockMaster>>((ref) {
  return [
    MockMaster(
      master: const Master(
        id: 'akmal',
        name: 'Akmal Yusupov',
        specialty: 'Elektrik',
        rating: 4.8,
        reviewCount: 127,
        latitude: 41.2995,
        longitude: 69.2401,
        distanceKm: 2.1,
      ),
      trade: Trade.elektrik,
      areaName: 'Chilonzor',
      experienceYears: 8,
      isOnline: true,
      isVerified: true,
    ),
    MockMaster(
      master: const Master(
        id: 'dilnoza',
        name: 'Dilnoza Rashidova',
        specialty: 'Suvoqchi',
        rating: 4.6,
        reviewCount: 84,
        latitude: 41.3111,
        longitude: 69.2797,
        distanceKm: 3.4,
      ),
      trade: Trade.suvoqchi,
      areaName: 'Yunusobod',
      experienceYears: 5,
      isOnline: true,
      isVerified: true,
    ),
    MockMaster(
      master: const Master(
        id: 'sherzod',
        name: 'Sherzod Nazarov',
        specialty: 'Kafelchi',
        rating: 4.9,
        reviewCount: 203,
        latitude: 41.2856,
        longitude: 69.2034,
        distanceKm: 1.6,
      ),
      trade: Trade.kafelchi,
      areaName: 'Sergeli',
      experienceYears: 12,
      isOnline: false,
      isVerified: true,
    ),
    MockMaster(
      master: const Master(
        id: 'ravshan',
        name: 'Ravshan Tursunov',
        specialty: 'Santexnik',
        rating: 4.5,
        reviewCount: 61,
        latitude: 41.3264,
        longitude: 69.2298,
        distanceKm: 4.2,
      ),
      trade: Trade.santexnik,
      areaName: 'Mirzo Ulug\'bek',
      experienceYears: 6,
      isOnline: true,
      isVerified: false,
    ),
    MockMaster(
      master: const Master(
        id: 'botir',
        name: 'Botir Ergashev',
        specialty: 'Duradgor',
        rating: 4.7,
        reviewCount: 95,
        latitude: 41.2775,
        longitude: 69.2843,
        distanceKm: 5.0,
      ),
      trade: Trade.duradgor,
      areaName: 'Shayxontohur',
      experienceYears: 10,
      isOnline: false,
      isVerified: true,
    ),
  ];
});
