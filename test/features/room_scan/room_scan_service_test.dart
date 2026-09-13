import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tamir_uy_mobile_flutter/features/room_scan/room_scan_service.dart';
import 'package:tamir_uy_mobile_flutter/services/api_client.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final messenger =
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;
  late RoomScanService service;

  void mock(Future<Object?>? Function(MethodCall) handler) {
    messenger.setMockMethodCallHandler(RoomScanService.channel, handler);
  }

  setUp(() => service = RoomScanService(apiClient: ApiClient(baseUrl: 'http://test')));
  tearDown(() => messenger.setMockMethodCallHandler(RoomScanService.channel, null));

  group('checkSupport', () {
    test('reports supported', () async {
      mock((call) async {
        expect(call.method, 'isSupported');
        return <String, dynamic>{'supported': true, 'reason': null};
      });
      final s = await service.checkSupport();
      expect(s.supported, isTrue);
      expect(s.reason, isNull);
    });

    test('reports unsupported with a reason', () async {
      mock((call) async => <String, dynamic>{'supported': false, 'reason': 'no_lidar'});
      final s = await service.checkSupport();
      expect(s.supported, isFalse);
      expect(s.reason, 'no_lidar');
    });

    test('no native handler (Android) → not_implemented, never throws', () async {
      // No mock handler installed → MissingPluginException path.
      final s = await service.checkSupport();
      expect(s.supported, isFalse);
      expect(s.reason, 'not_implemented');
    });
  });

  group('scan', () {
    final sampleJson = jsonEncode(<String, dynamic>{
      'walls': <dynamic>[],
      'doors': <dynamic>[],
      'windows': <dynamic>[],
      'openings': <dynamic>[],
      'objects': <dynamic>[],
    });

    test('returns a parsed ScanResult', () async {
      mock((call) async {
        expect(call.method, 'scanRoom');
        return <String, dynamic>{
          'json': sampleJson,
          'usdzPath': '/tmp/scan.usdz',
          'version': 'roomplan-1',
        };
      });
      final r = await service.scan();
      expect(r, isNotNull);
      expect(r!.usdzPath, '/tmp/scan.usdz');
      expect(r.version, 'roomplan-1');
      expect(r.room.walls, isEmpty);
    });

    test('cancel → null', () async {
      mock((call) async => null);
      expect(await service.scan(), isNull);
    });

    test('busy → RoomScanException(busy)', () async {
      mock((call) async =>
          throw PlatformException(code: 'busy', message: 'already scanning'));
      await expectLater(
        service.scan(),
        throwsA(isA<RoomScanException>().having((e) => e.code, 'code', 'busy')),
      );
    });

    test('scan_failed → RoomScanException(scan_failed)', () async {
      mock((call) async => throw PlatformException(code: 'scan_failed'));
      await expectLater(
        service.scan(),
        throwsA(isA<RoomScanException>()
            .having((e) => e.code, 'code', 'scan_failed')),
      );
    });
  });
}
