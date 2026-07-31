import 'package:flutter/services.dart';
import 'package:logger/logger.dart';

class LidarPoint {
  LidarPoint({
    required this.x,
    required this.y,
    required this.z,
    this.confidence = 1.0,
  });

  final double x;
  final double y;
  final double z;
  final double confidence;

  Map<String, dynamic> toMap() => {
        'x': x,
        'y': y,
        'z': z,
        'confidence': confidence,
      };
}

class LidarScan {
  LidarScan({
    required this.points,
    required this.timestamp,
    this.duration = const Duration(),
  });

  final List<LidarPoint> points;
  final DateTime timestamp;
  final Duration duration;

  int get pointCount => points.length;

  Map<String, dynamic> toMap() => {
        'pointCount': pointCount,
        'timestamp': timestamp.toIso8601String(),
        'duration': duration.inMilliseconds,
        'points': points.map((p) => p.toMap()).toList(),
      };
}

class LidarException implements Exception {
  LidarException(this.message, [this.code]);

  final String message;
  final String? code;

  @override
  String toString() => message;
}

class LidarService {
  static const platform = MethodChannel('com.tamir_uy/lidar');
  static final _logger = Logger();

  Future<bool> isLidarAvailable() async {
    try {
      final result = await platform.invokeMethod<bool>('isLidarAvailable');
      return result ?? false;
    } catch (e) {
      _logger.e('Error checking LiDAR availability', error: e);
      return false;
    }
  }

  Future<void> startScan() async {
    try {
      await platform.invokeMethod('startScan');
      _logger.i('LiDAR scan started');
    } on PlatformException catch (e) {
      throw LidarException(e.message ?? 'Failed to start scan', e.code);
    }
  }

  Future<void> stopScan() async {
    try {
      await platform.invokeMethod('stopScan');
      _logger.i('LiDAR scan stopped');
    } on PlatformException catch (e) {
      throw LidarException(e.message ?? 'Failed to stop scan', e.code);
    }
  }

  Future<LidarScan> getScanData() async {
    try {
      final result = await platform.invokeMethod<Map>('getScanData');
      if (result == null) {
        throw LidarException('No scan data available');
      }

      final points = (result['points'] as List?)
              ?.map((p) {
                final map = p as Map;
                return LidarPoint(
                  x: (map['x'] as num).toDouble(),
                  y: (map['y'] as num).toDouble(),
                  z: (map['z'] as num).toDouble(),
                  confidence: (map['confidence'] as num?)?.toDouble() ?? 1.0,
                );
              })
              .toList() ??
          [];

      return LidarScan(
        points: points,
        timestamp: DateTime.parse(result['timestamp'] as String),
        duration: Duration(
          milliseconds: (result['duration'] as int?) ?? 0,
        ),
      );
    } on PlatformException catch (e) {
      throw LidarException(e.message ?? 'Failed to get scan data', e.code);
    }
  }

  Future<Map<String, double>> getMeasurements() async {
    try {
      final result = await platform.invokeMethod<Map>('getMeasurements');
      if (result == null) {
        throw LidarException('No measurements available');
      }

      return {
        'width': (result['width'] as num?)?.toDouble() ?? 0,
        'length': (result['length'] as num?)?.toDouble() ?? 0,
        'height': (result['height'] as num?)?.toDouble() ?? 0,
      };
    } on PlatformException catch (e) {
      throw LidarException(e.message ?? 'Failed to get measurements', e.code);
    }
  }
}
