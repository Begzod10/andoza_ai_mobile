import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tamir_uy_mobile_flutter/features/ar_scan/ar_scan_service.dart';
import 'package:tamir_uy_mobile_flutter/geometry/room_geometry.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final messenger = TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;
  final calls = <MethodCall>[];

  void mock(Future<Object?>? Function(MethodCall) handler) {
    messenger.setMockMethodCallHandler(ArScanService.channel, (call) {
      calls.add(call);
      return handler(call);
    });
  }

  setUp(calls.clear);
  tearDown(() => messenger.setMockMethodCallHandler(ArScanService.channel, null));

  test('reports support from the native side', () async {
    mock((_) async => {'supported': true, 'reason': 'ok'});
    final s = await ArScanService().checkSupport();
    expect(s.supported, isTrue);
    expect(s.reason, 'ok');
  });

  test('maps arcore_not_installed to install prompt', () async {
    mock((_) async => {'supported': false, 'reason': 'arcore_not_installed'});
    final s = await ArScanService().checkSupport();
    expect(s.supported, isFalse);
    expect(s.reason, 'arcore_not_installed');
  });

  test('missing plugin means unsupported', () async {
    final s = await ArScanService().checkSupport();
    expect(s.supported, isFalse);
    expect(s.reason, 'not_implemented');
  });

  test('returns the parsed scan', () async {
    mock((_) async => {
          'corners': [[0.0, 0.0], [4.0, 0.0], [4.0, 3.0], [0.0, 3.0]],
          'height': 2.74,
          'heightMeasured': true,
          'closed': false,
          'trackingLossCount': 1,
          'durationSec': 80,
        });
    final raw = await ArScanService().scanFloorPlan(const {});
    expect(raw, isNotNull);
    expect(raw!.corners, hasLength(4));
    expect(raw.corners[2], const Vec2(4, 3));
    expect(raw.height, 2.74);
    expect(raw.trackingLossCount, 1);
  });

  test('null means the user cancelled', () async {
    mock((_) async => null);
    expect(await ArScanService().scanFloorPlan(const {}), isNull);
  });

  test('native error becomes ArScanException with its code', () async {
    mock((_) async => throw PlatformException(code: 'tracking_lost', message: 'lost'));
    await expectLater(
      ArScanService().scanFloorPlan(const {}),
      throwsA(isA<ArScanException>().having((e) => e.code, 'code', 'tracking_lost')),
    );
  });

  test('passes the localized strings through', () async {
    mock((_) async => null);
    await ArScanService().scanFloorPlan(const {'arScanAddCorner': "Burchak qo'shish"});
    expect(calls.single.method, 'scanFloorPlan');
    expect((calls.single.arguments as Map)['strings'], {'arScanAddCorner': "Burchak qo'shish"});
  });
}
