import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:tamir_uy_mobile_flutter/providers/lidar_provider.dart';
import 'package:tamir_uy_mobile_flutter/providers/room_provider.dart';
import 'package:tamir_uy_mobile_flutter/screens/room_setup/dimensions_entry_screen.dart';
import 'package:tamir_uy_mobile_flutter/screens/room_setup/room_summary_screen.dart';
import 'package:tamir_uy_mobile_flutter/screens/scanning/lidar_scanning_screen.dart';
import 'package:tamir_uy_mobile_flutter/screens/scanning/photo_scanning_screen.dart';
import 'package:tamir_uy_mobile_flutter/services/lidar_service.dart';

/// A LiDAR service that reports availability and returns a fixed bounding box,
/// so the screen takes its real-device path (no emulator timer).
class _FakeLidar extends LidarService {
  @override
  Future<bool> isLidarAvailable() async => true;

  @override
  Future<Map<String, double>> scanRoom() async => {
        'width': 3.0,
        'length': 5.0,
        'height': 2.7,
        'pointCount': 0,
        'durationMs': 0,
      };
}

GoRouter _routerTo(Widget home, String nextPath) => GoRouter(
      routes: [
        GoRoute(path: '/', builder: (_, _) => home),
        GoRoute(
          path: nextPath,
          builder: (_, _) => const Scaffold(body: Text('NEXT')),
        ),
      ],
    );

Future<void> _enlarge(WidgetTester tester) async {
  await tester.binding.setSurfaceSize(const Size(1000, 2000));
  addTearDown(() => tester.binding.setSurfaceSize(null));
}

void main() {
  testWidgets('LiDAR real-scan path lands a rectangle plan from the bounding box',
      (tester) async {
    await _enlarge(tester);
    final container = ProviderContainer(
      overrides: [lidarServiceProvider.overrideWithValue(_FakeLidar())],
    );
    addTearDown(container.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp.router(
          routerConfig: _routerTo(
            const LiDARScanningScreen(),
            '/setup/wall-measurements',
          ),
        ),
      ),
    );
    // Run the post-frame _start() + its async scan/seed/navigate.
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 50));

    final plan = container.read(activeRoomPlanProvider);
    expect(plan, isNotNull);
    expect(plan!.isAxisAlignedRect, isTrue);
    expect(plan.boundingSize.width, closeTo(3.0, 1e-9));
    expect(plan.boundingSize.length, closeTo(5.0, 1e-9));
    expect(plan.ceilingHeightM, closeTo(2.7, 1e-9));
    expect(container.read(activeRoomProvider), isNotNull);
  });

  testWidgets('Photo 360° capture seeds a default rectangle plan',
      (tester) async {
    await _enlarge(tester);
    final container = ProviderContainer();
    addTearDown(container.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp.router(
          routerConfig: _routerTo(
            const PhotoScanningScreen(),
            '/setup/wall-measurements',
          ),
        ),
      ),
    );
    await tester.pump();

    // 8 captures completes the ring → seeds the plan + navigates.
    for (var i = 0; i < 8; i++) {
      await tester.tap(find.text('Suratga olish'));
      await tester.pump();
    }
    await tester.pump(const Duration(milliseconds: 50));

    final plan = container.read(activeRoomPlanProvider);
    expect(plan, isNotNull);
    expect(plan!.isAxisAlignedRect, isTrue);
    // Seeded defaults: width = wall B = 3.2, length = wall A = 4.5.
    expect(plan.boundingSize.width, closeTo(3.2, 1e-9));
    expect(plan.boundingSize.length, closeTo(4.5, 1e-9));
    expect(plan.ceilingHeightM, closeTo(2.8, 1e-9));
  });

  testWidgets(
      'Wall-measurements summary lands a rectangle plan; stats equal getters',
      (tester) async {
    await _enlarge(tester);
    final container = ProviderContainer();
    addTearDown(container.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp.router(
          routerConfig:
              _routerTo(const RoomSummaryScreen(), '/design/b1'),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // The summary stat cards read straight from the plan getters (defaults:
    // 3.2 × 4.5 → 14.4 m² floor, 15.4 m perimeter).
    expect(find.text('14.4 m²'), findsWidgets);
    expect(find.text('15.4 m'), findsOneWidget);

    await tester.tap(find.text('Davom etish'));
    await tester.pumpAndSettle();

    final plan = container.read(activeRoomPlanProvider);
    expect(plan, isNotNull);
    expect(plan!.isAxisAlignedRect, isTrue);
    expect(plan.boundingSize.width, closeTo(3.2, 1e-9));
    expect(plan.boundingSize.length, closeTo(4.5, 1e-9));
    expect(plan.areaM2, closeTo(14.4, 1e-9));
    final room = container.read(activeRoomProvider);
    expect(room, isNotNull);
    expect(room!.name, 'Mehmonxona ta\'miri');
  });

  testWidgets('Manual dimensions entry builds a rectangle plan from W/L/H',
      (tester) async {
    await _enlarge(tester);
    final container = ProviderContainer();
    addTearDown(container.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(home: DimensionsEntryScreen()),
      ),
    );
    await tester.pumpAndSettle();

    // Open the add-room sheet.
    await tester.tap(find.text('+ Xona qo\'shish'));
    await tester.pumpAndSettle();

    // Fields order: name, length, width, height.
    final fields = find.byType(TextField);
    await tester.enterText(fields.at(1), '6'); // Uzunlik (length)
    await tester.enterText(fields.at(2), '4'); // Kenglik (width)
    await tester.enterText(fields.at(3), '3'); // Balandlik (height)
    await tester.tap(find.text('Qo\'shish'));
    await tester.pumpAndSettle();

    final plan = container.read(activeRoomPlanProvider);
    expect(plan, isNotNull);
    expect(plan!.isAxisAlignedRect, isTrue);
    expect(plan.boundingSize.width, closeTo(4.0, 1e-9));
    expect(plan.boundingSize.length, closeTo(6.0, 1e-9));
    expect(plan.ceilingHeightM, closeTo(3.0, 1e-9));
  });
}
