import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tamir_uy_mobile_flutter/features/room_scan/models/captured_room.dart';
import 'package:tamir_uy_mobile_flutter/features/room_scan/room_scan_converter.dart';
import 'package:tamir_uy_mobile_flutter/features/room_scan/room_scan_service.dart';
import 'package:tamir_uy_mobile_flutter/l10n/app_localizations.dart';
import 'package:tamir_uy_mobile_flutter/screens/scanning/room_scan_review_page.dart';

import '../fixtures/scanned_room.dart';

RoomScanReviewArgs _args(CapturedRoom room) {
  final draft = RoomScanConverter.toRoomDraft(room);
  return RoomScanReviewArgs(
    draft: draft,
    scan: ScanResult(
      room: room,
      rawJson: '{}',
      usdzPath: '/tmp/scan.usdz',
      version: 'roomplan-1',
    ),
  );
}

Future<void> _pump(WidgetTester tester, CapturedRoom room) async {
  await tester.pumpWidget(
    ProviderScope(
      child: MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: const Locale('uz'),
        home: RoomScanReviewPage(args: _args(room)),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('the summary reports the detected walls, door, window and objects',
      (tester) async {
    await _pump(
      tester,
      CapturedRoom(
        walls: scanWalls(),
        doors: [scanDoor()],
        windows: [scanWindow()],
        objects: scanObjects(),
      ),
    );

    expect(find.text('Nimalar aniqlandi'), findsOneWidget);
    expect(find.text('5 Devor'), findsOneWidget);
    expect(find.text('1 Eshik'), findsOneWidget);
    expect(find.text('1 Deraza'), findsOneWidget);
    expect(find.text('16 Buyum'), findsOneWidget);
    // Both openings were found, so the rescan hint stays out of the way.
    expect(find.textContaining('Shisha va ochiq eshiklar'), findsNothing);
  });

  testWidgets('zero detected doors surfaces the glass/open-door rescan hint',
      (tester) async {
    // Matches the real scan of this room that came back with no doors at all.
    await _pump(
      tester,
      CapturedRoom(
        walls: scanWalls(),
        doors: const [],
        windows: [scanWindow()],
        objects: scanObjects(),
      ),
    );

    expect(find.text('0 Eshik'), findsOneWidget);
    expect(find.text('1 Deraza'), findsOneWidget);
    expect(find.textContaining('Shisha va ochiq eshiklar'), findsOneWidget);
    expect(find.textContaining('Yaqinroqdan, sekinroq'), findsOneWidget);
    // The rescan affordance the hint points at is on this screen.
    final rescan = find.text('Qayta skanerlash');
    await tester.scrollUntilVisible(rescan, 300);
    expect(rescan, findsOneWidget);
  });

  testWidgets('a low-confidence opening is flagged', (tester) async {
    await _pump(
      tester,
      CapturedRoom(
        walls: scanWalls(),
        doors: [scanDoor(confidence: ScanConfidence.low)],
        windows: [scanWindow()],
        objects: scanObjects(),
      ),
    );

    expect(find.textContaining('1 ta element past aniqlikda'), findsOneWidget);
  });
}
