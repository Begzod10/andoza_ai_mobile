import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

import 'arcore_plan.dart';

class ArScanSupport {
  const ArScanSupport(this.supported, this.reason);
  final bool supported;

  /// `ok` | `arcore_not_installed` | `unsupported_device` | `camera_denied` |
  /// `check_failed` (inconclusive, retry) | `not_implemented` (no native handler, e.g. iOS).
  final String reason;
}

class ArScanException implements Exception {
  const ArScanException(this.code, this.message);
  final String code;
  final String message;
  @override
  String toString() => 'ArScanException($code): $message';
}

/// Dart side of the Android ARCore floor-plan scanner
/// (`MethodChannel("andoza/arscan")`, see `arscan/ArScanChannel.kt`).
class ArScanService {
  static const MethodChannel channel = MethodChannel('andoza/arscan');
  static final Logger _logger = Logger();

  /// Never throws: anything but a clear "yes" is unsupported, with a reason.
  Future<ArScanSupport> checkSupport() async {
    try {
      final res = await channel.invokeMapMethod<String, dynamic>('checkSupport');
      return ArScanSupport(res?['supported'] == true, res?['reason'] as String? ?? 'unsupported_device');
    } on MissingPluginException {
      return const ArScanSupport(false, 'not_implemented');
    } on PlatformException catch (e) {
      _logger.e('arscan checkSupport failed', error: e);
      return ArScanSupport(false, e.code);
    }
  }

  /// Opens the native scanner with its on-screen copy in [strings].
  /// `null` = the user backed out.
  Future<ArScanRaw?> scanFloorPlan(Map<String, String> strings) async {
    try {
      final res = await channel.invokeMapMethod<String, dynamic>('scanFloorPlan', {'strings': strings});
      return res == null ? null : ArScanRaw.fromMap(res);
    } on PlatformException catch (e) {
      _logger.e('arscan scanFloorPlan failed', error: e);
      throw ArScanException(e.code, e.message ?? e.code);
    }
  }

  /// The app's system settings page (to grant the camera after a refusal).
  Future<void> openAppSettings() async {
    try {
      await channel.invokeMethod<void>('openAppSettings');
    } on MissingPluginException {
      // Not on Android — nothing to open.
    }
  }
}

final arScanServiceProvider = Provider<ArScanService>((ref) => ArScanService());
