import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:riverpod/riverpod.dart';

import '../../providers/auth_provider.dart';
import '../../services/api_client.dart';
import 'models/captured_room.dart';

/// Result of the native `isSupported` probe.
class ScanSupport {
  /// Whether RoomPlan can run on this device.
  final bool supported;

  /// Why not, when [supported] is false: `"no_lidar" | "ios_too_old" |
  /// "not_implemented" | "unsupported_platform"` or a raw error code. Null when
  /// [supported].
  final String? reason;

  const ScanSupport(this.supported, this.reason);
}

/// A completed RoomPlan capture handed back from the native side.
class ScanResult {
  /// The parsed room (walls/doors/windows/openings/objects).
  final CapturedRoom room;

  /// The exact JSON string the native side produced — forwarded verbatim to the
  /// backend as `room_json` so the server converter sees identical bytes.
  final String rawJson;

  /// Temp path to the exported parametric `.usdz`.
  final String usdzPath;

  /// Contract version, e.g. `"roomplan-1"`.
  final String version;

  const ScanResult({
    required this.room,
    required this.rawJson,
    required this.usdzPath,
    required this.version,
  });
}

/// Raised when a scan fails on the native side (busy, scan_failed, parse_failed…).
class RoomScanException implements Exception {
  final String code;
  final String message;
  const RoomScanException(this.code, this.message);

  @override
  String toString() => 'RoomScanException($code): $message';
}

/// Bridges the native RoomPlan module (`MethodChannel("andoza/roomscan")`) and
/// uploads the captured room to the backend. Pure-Dart-testable: the channel is
/// mocked via `TestDefaultBinaryMessengerBinding` in tests, and on non-iOS the
/// channel simply throws [MissingPluginException] → unsupported.
class RoomScanService {
  RoomScanService({required ApiClient apiClient}) : _api = apiClient;

  /// The single native channel. Public so tests can install a mock handler.
  static const MethodChannel channel = MethodChannel('andoza/roomscan');

  final ApiClient _api;
  static final Logger _logger = Logger();

  /// Probe device capability. Never throws — Android / older iOS / missing
  /// plugin all resolve to an unsupported [ScanSupport].
  Future<ScanSupport> checkSupport() async {
    try {
      final res = await channel.invokeMapMethod<String, dynamic>('isSupported');
      final supported = res?['supported'] == true;
      final reason = res?['reason'] as String?;
      _logger.i('roomscan isSupported → supported=$supported reason=$reason');
      return ScanSupport(supported, supported ? null : (reason ?? 'unsupported'));
    } on MissingPluginException {
      // No native handler (Android, or iOS build without the module).
      return const ScanSupport(false, 'not_implemented');
    } on PlatformException catch (e) {
      _logger.e('roomscan isSupported failed', error: e);
      return ScanSupport(false, e.code);
    }
  }

  /// Present the native RoomPlan scanner. Returns null when the user cancels;
  /// throws [RoomScanException] on a native error (`busy`, `scan_failed`, …).
  Future<ScanResult?> scan() async {
    try {
      final res = await channel.invokeMapMethod<String, dynamic>('scanRoom');
      if (res == null) {
        _logger.i('roomscan scanRoom → cancelled');
        return null;
      }
      final rawJson = res['json'] as String? ?? '';
      final usdzPath = res['usdzPath'] as String? ?? '';
      final version = res['version'] as String? ?? 'roomplan-1';
      final decoded = jsonDecode(rawJson);
      if (decoded is! Map<String, dynamic>) {
        throw const RoomScanException('parse_failed', 'Skan natijasi noto\'g\'ri');
      }
      final room = parseCapturedRoom(decoded);
      _logger.i('roomscan scanRoom → walls=${room.walls.length} '
          'objects=${room.objects.length} usdz=$usdzPath');
      return ScanResult(
        room: room,
        rawJson: rawJson,
        usdzPath: usdzPath,
        version: version,
      );
    } on PlatformException catch (e) {
      _logger.e('roomscan scanRoom failed', error: e);
      throw RoomScanException(e.code, e.message ?? 'Skanerlashda xatolik');
    }
  }

  /// Attach the scan artifacts (parametric JSON + `.usdz`) to an already-created
  /// room. The room itself is created first via the normal handoff, exactly like
  /// the manual flow; this only uploads the extras. Returns the room JSON the
  /// backend echoes back (Phase 4).
  Future<Map<String, dynamic>> upload(String roomId, ScanResult scan) async {
    final bytes = await File(scan.usdzPath).readAsBytes();
    _logger.i('roomscan upload → room=$roomId usdz=${bytes.length}B');
    return _api.uploadFile<Map<String, dynamic>>(
      '/rooms/$roomId/room-scan',
      bytes: bytes,
      filename: 'scan.usdz',
      fieldName: 'usdz',
      contentType: 'model/vnd.usdz+zip',
      fields: {'room_json': scan.rawJson},
      fromJson: (d) => (d as Map).cast<String, dynamic>(),
    );
  }
}

/// DI for [RoomScanService], wired to the shared authenticated [ApiClient].
final roomScanServiceProvider = Provider<RoomScanService>((ref) {
  return RoomScanService(apiClient: ref.watch(apiClientProvider));
});
