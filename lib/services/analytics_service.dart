import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/room_plan.dart';

abstract class AnalyticsSink {
  Future<void> logEvent(String name, [Map<String, Object>? params]);

  /// Sets the user id for analytics and crashlytics (null clears it).
  Future<void> setUserId(String? id);
}

/// Forwards to Firebase; a silent no-op when Firebase isn't initialised.
class FirebaseAnalyticsSink implements AnalyticsSink {
  @override
  Future<void> logEvent(String name, [Map<String, Object>? params]) async {
    if (Firebase.apps.isEmpty) return;
    try {
      await FirebaseAnalytics.instance.logEvent(name: name, parameters: params);
    } catch (e) {
      debugPrint('Analytics logEvent failed: $e');
    }
  }

  @override
  Future<void> setUserId(String? id) async {
    if (Firebase.apps.isEmpty) return;
    try {
      await FirebaseAnalytics.instance.setUserId(id: id);
      await FirebaseCrashlytics.instance.setUserIdentifier(id ?? '');
    } catch (e) {
      debugPrint('Analytics setUserId failed: $e');
    }
  }
}

class AnalyticsService {
  AnalyticsService(this._sink);
  final AnalyticsSink _sink;

  /// [method]: 'password' | 'google'.
  Future<void> login(String method) =>
      _sink.logEvent('login', {'method': method});

  Future<void> roomCreated(RoomSource source) =>
      _sink.logEvent('room_created', {'method': source.name});

  /// [kind]: 'lidar' | 'arcore'.
  Future<void> scanFinished(String kind) =>
      _sink.logEvent('scan_finished', {'kind': kind});

  Future<void> estimateViewed() => _sink.logEvent('estimate_viewed');

  Future<void> orderPlaced(int lines) =>
      _sink.logEvent('order_placed', {'lines': lines});

  Future<void> leadSent() => _sink.logEvent('lead_sent');
}

final analyticsSinkProvider = Provider<AnalyticsSink>(
  (ref) => FirebaseAnalyticsSink(),
);

final analyticsProvider = Provider<AnalyticsService>(
  (ref) => AnalyticsService(ref.watch(analyticsSinkProvider)),
);
