import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:tamir_uy_mobile_flutter/features/room_scan/models/captured_room.dart';
import 'package:tamir_uy_mobile_flutter/features/room_scan/room_scan_converter.dart';
import 'package:tamir_uy_mobile_flutter/features/room_scan/room_scan_service.dart';
import 'package:tamir_uy_mobile_flutter/geometry/room_geometry.dart';
import 'package:tamir_uy_mobile_flutter/l10n/app_localizations.dart';
import 'package:tamir_uy_mobile_flutter/models/api/api.dart';
import 'package:tamir_uy_mobile_flutter/models/room_plan.dart';
import 'package:tamir_uy_mobile_flutter/providers/design_persistence_provider.dart';
import 'package:tamir_uy_mobile_flutter/providers/estimate_api_provider.dart';
import 'package:tamir_uy_mobile_flutter/providers/room_persistence_provider.dart';
import 'package:tamir_uy_mobile_flutter/repositories/electrical_repository.dart';
import 'package:tamir_uy_mobile_flutter/repositories/estimate_repository.dart';
import 'package:tamir_uy_mobile_flutter/screens/scanning/room_scan_review_page.dart';
import 'package:tamir_uy_mobile_flutter/screens/scanning/room_scan_summary_sheet.dart';

import '../support/localized_pump.dart';

RoomPlan _plan() => RoomPlan.fromCorners(
      const [Vec2(0, 0), Vec2(4, 0), Vec2(4, 3), Vec2(0, 3)],
      ceilingHeightM: 2.8,
      source: RoomSource.lidar,
    );

Estimate _estimate() => Estimate(
      id: 'est-1',
      roomId: 'room-9',
      lines: [
        const EstimateLine(
          label: "Bo'yoq: Tikkurila Euro 3 Oq",
          formula: '45.4 m² × 2 qatlam ÷ 9.0 m²/litr = 11 litr',
          quantity: 11,
          unit: 'litr',
          unitPrice: 45000,
          totalUzs: 495000,
          category: 'boyoq',
        ),
        const EstimateLine(
          label: 'Elektr kabel',
          formula: '8 nuqta × 8.0 m × 1.15 = 74 m',
          quantity: 74,
          unit: 'm',
          unitPrice: 10000,
          totalUzs: 740000,
          isApproximate: true,
          category: 'elektr',
          warning: 'Nuqtalar soni taxminiy',
        ),
      ],
      totalUzs: 1235000,
      totalExactUzs: 495000,
      totalApproxUzs: 740000,
      totalMin: 1111500,
      totalMax: 1358500,
      createdAt: DateTime(2026, 9, 1),
      hasElectrical: true,
    );

ElectricalPlan _electrical() => ElectricalPlan(
      roomId: 'room-9',
      devices: const [
        ElectricalDeviceOut(
          id: 'd1',
          roomId: 'room-9',
          type: ElectricalDeviceType.socket,
          wallIndex: 0,
          x: 1,
          y: 0.3,
          count: 4,
        ),
        ElectricalDeviceOut(
          id: 'd2',
          roomId: 'room-9',
          type: ElectricalDeviceType.socket,
          wallIndex: 2,
          x: 1,
          y: 0.3,
          count: 2,
        ),
        ElectricalDeviceOut(
          id: 'd3',
          roomId: 'room-9',
          type: ElectricalDeviceType.switch_,
          wallIndex: 1,
          x: 0.2,
          y: 1.1,
          count: 2,
        ),
        ElectricalDeviceOut(
          id: 'd4',
          roomId: 'room-9',
          type: ElectricalDeviceType.panel,
          wallIndex: 3,
          x: 0.5,
          y: 1.6,
        ),
      ],
      wiringMeters: 62.5,
      updatedAt: DateTime(2026, 9, 1),
    );

/// Persists nothing but reports a server room id, so the review page's handoff
/// succeeds and the flow reaches the summary fetches.
class _FakePersistence extends RoomPersistenceNotifier {
  _FakePersistence(super.ref);

  @override
  Future<void> ensurePersisted({RoomCreate? override}) async {
    state = AsyncValue.data(
      PersistedRoom(
        clientRoomId: 'client-1',
        room: RoomOut(
          id: 'room-9',
          apartmentId: 'apt-1',
          name: 'Xona',
          updatedAt: DateTime(2026, 1, 1),
        ),
      ),
    );
  }
}

/// Uploads succeed here — this file is about what happens *after* them.
class _OkScanService implements RoomScanService {
  @override
  Future<ScanSupport> checkSupport() async => const ScanSupport(true, null);

  @override
  Future<ScanResult?> scan() async => null;

  @override
  Future<String?> scanObject() async => null;

  @override
  Future<Map<String, dynamic>> uploadObject(
          String roomId, int objectIndex, String usdzPath) async =>
      const {};

  @override
  Future<Map<String, dynamic>> upload(String roomId, ScanResult scan) async =>
      const {};

  @override
  Future<Map<String, dynamic>> uploadThumbnail(
          String roomId, Uint8List png) async =>
      const {};
}

class _FakeEstimateRepo implements EstimateRepository {
  _FakeEstimateRepo(this._result);

  final Estimate? _result;

  @override
  Future<Estimate> preview(String roomId) async {
    final r = _result;
    if (r == null) throw Exception('boom');
    return r;
  }

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _FakeElectricalRepo implements ElectricalRepository {
  _FakeElectricalRepo(this._result);

  final ElectricalPlan? _result;

  @override
  Future<ElectricalPlan> getPlan(String roomId) async {
    final r = _result;
    if (r == null) throw Exception('boom');
    return r;
  }

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

RoomScanReviewArgs _args() => RoomScanReviewArgs(
      draft: RoomScanDraft(plan: _plan(), objects: const []),
      scan: const ScanResult(
        room: CapturedRoom(),
        rawJson: '{}',
        usdzPath: '/tmp/scan.usdz',
        version: 'roomplan-1',
      ),
    );

/// Drives the review page's "Davom etish" through the whole post-save chain.
Future<GoRouter> _runContinue(
  WidgetTester tester, {
  Estimate? estimate,
  ElectricalPlan? electrical,
}) async {
  final router = GoRouter(
    initialLocation: '/review',
    routes: [
      GoRoute(
        path: '/review',
        builder: (_, _) => RoomScanReviewPage(args: _args()),
      ),
      GoRoute(
        path: '/studio/:roomId',
        builder: (_, state) =>
            Scaffold(body: Text('studio ${state.pathParameters['roomId']}')),
      ),
    ],
  );

  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        roomPersistenceProvider.overrideWith((r) => _FakePersistence(r)),
        roomScanServiceProvider.overrideWithValue(_OkScanService()),
        estimateRepositoryProvider
            .overrideWithValue(_FakeEstimateRepo(estimate)),
        electricalRepositoryProvider
            .overrideWithValue(_FakeElectricalRepo(electrical)),
      ],
      child: MaterialApp.router(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: const Locale('uz'),
        routerConfig: router,
      ),
    ),
  );
  await tester.pumpAndSettle();

  final continueButton = find.text('Davom etish');
  await tester.scrollUntilVisible(continueButton, 300);
  await tester.pumpAndSettle();
  // runAsync: the thumbnail step rasterises off-screen via `Picture.toImage`,
  // which only completes on the real event loop.
  await tester.runAsync(() async {
    await tester.tap(continueButton);
    await Future<void>.delayed(const Duration(milliseconds: 500));
  });
  // Not pumpAndSettle: while the summary sheet is up the review page below it
  // is still "busy", and its button spinner animates forever.
  for (var i = 0; i < 6; i++) {
    await tester.pump(const Duration(milliseconds: 200));
  }
  return router;
}

void main() {
  group('RoomScanSummaryContent', () {
    testWidgets('shows the total, the range and the exact/approximate split',
        (tester) async {
      await pumpLocalized(
        tester,
        Scaffold(
          body: RoomScanSummaryContent(
            plan: _plan(),
            estimate: _estimate(),
            electrical: _electrical(),
            onContinue: () {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text("1 235 000 so'm"), findsOneWidget);
      expect(
        find.text("Oraliq: 1 111 500 so'm — 1 358 500 so'm"),
        findsOneWidget,
      );
      expect(find.text("Aniq: 495 000 so'm"), findsOneWidget);
      expect(find.text("Taxminiy: 740 000 so'm"), findsOneWidget);
    });

    testWidgets('marks the approximate line and surfaces its warning',
        (tester) async {
      await pumpLocalized(
        tester,
        Scaffold(
          body: RoomScanSummaryContent(
            plan: _plan(),
            estimate: _estimate(),
            onContinue: () {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Exactly one badge: the paint line is priced exactly and must not carry
      // the same caveat as the guessed electrical run.
      expect(find.text('taxminiy'), findsOneWidget);
      expect(find.text('Nuqtalar soni taxminiy'), findsOneWidget);
      expect(find.text('Elektr kabel'), findsOneWidget);
    });

    testWidgets('aggregates electrical devices by type and shows the wiring',
        (tester) async {
      await pumpLocalized(
        tester,
        Scaffold(
          body: RoomScanSummaryContent(
            plan: _plan(),
            estimate: _estimate(),
            electrical: _electrical(),
            onContinue: () {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      // 4 + 2 sockets arrive as two rows and must read as one count.
      expect(find.text('6 rozetka'), findsOneWidget);
      expect(find.text('2 kalit'), findsOneWidget);
      expect(find.text('1 elektr qutisi'), findsOneWidget);
      expect(find.text('Kabel: 62.5 m'), findsOneWidget);
    });

    testWidgets('omits the electrical section when the plan is empty',
        (tester) async {
      await pumpLocalized(
        tester,
        Scaffold(
          body: RoomScanSummaryContent(
            plan: _plan(),
            estimate: _estimate(),
            onContinue: () {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Elektr rejasi'), findsNothing);
      expect(find.text("1 235 000 so'm"), findsOneWidget);
    });
  });

  group('post-scan flow', () {
    testWidgets('a saved scan shows the smeta before the studio opens',
        (tester) async {
      await _runContinue(
        tester,
        estimate: _estimate(),
        electrical: _electrical(),
      );

      expect(find.text('Xona saqlandi'), findsOneWidget);
      expect(find.text("1 235 000 so'm"), findsOneWidget);
      // Still on the review page underneath — the studio waits for the CTA.
      expect(find.text('studio room-9'), findsNothing);

      // runAsync again: `_continue` is suspended on the sheet's pop future in
      // the real async zone (it was started inside runAsync), so its tail —
      // the pushReplacement into the studio — only runs on the real event loop.
      await tester.runAsync(() async {
        await tester.tap(find.text("Studiyaga o'tish"));
        await Future<void>.delayed(const Duration(milliseconds: 500));
      });
      await tester.pumpAndSettle();
      expect(find.text('studio room-9'), findsOneWidget);
    });

    testWidgets('a failed estimate never traps the user short of the studio',
        (tester) async {
      await _runContinue(tester, electrical: null);

      expect(find.text('Xona saqlandi'), findsNothing);
      expect(find.text('studio room-9'), findsOneWidget);
      expect(find.textContaining("Smetani hisoblab bo'lmadi"), findsOneWidget);
    });
  });
}
