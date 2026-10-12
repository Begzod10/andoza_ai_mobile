import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'push_router.dart';

/// Android channel the backend sends to (and the manifest's default).
const pushChannelId = 'andoza_updates';

/// User-visible channel name.
const pushChannelName = 'Andoza yangiliklari';

/// Shows pushes that arrive while the app is open (the OS only shows them
/// itself when the app is in the background). Never asks for the
/// notification permission.
class LocalNotifications {
  LocalNotifications([FlutterLocalNotificationsPlugin? plugin])
    : _plugin = plugin ?? FlutterLocalNotificationsPlugin();

  final FlutterLocalNotificationsPlugin _plugin;
  var _nextId = 0;

  static const _android = AndroidNotificationDetails(
    pushChannelId,
    pushChannelName,
    icon: '@drawable/ic_notification',
    importance: Importance.high,
    priority: Priority.high,
  );

  Future<void> init({required void Function(String? payload) onTap}) async {
    await _plugin.initialize(
      settings: const InitializationSettings(
        android: AndroidInitializationSettings('@drawable/ic_notification'),
        iOS: DarwinInitializationSettings(
          requestAlertPermission: false,
          requestSoundPermission: false,
          requestBadgePermission: false,
        ),
      ),
      onDidReceiveNotificationResponse: (r) => onTap(r.payload),
    );
    await _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(
          const AndroidNotificationChannel(
            pushChannelId,
            pushChannelName,
            importance: Importance.high,
          ),
        );
  }

  /// The payload of the local notification that launched the app, if any.
  Future<String?> launchPayload() async {
    final details = await _plugin.getNotificationAppLaunchDetails();
    if (details == null || !details.didNotificationLaunchApp) return null;
    return details.notificationResponse?.payload;
  }

  Future<void> showForeground(RemoteMessage message) async {
    final n = message.notification;
    if (n == null) return;
    try {
      await _plugin.show(
        id: _nextId++,
        title: n.title,
        body: n.body,
        notificationDetails: const NotificationDetails(
          android: _android,
          iOS: DarwinNotificationDetails(),
        ),
        payload: safePushRoute(message.data),
      );
    } catch (e) {
      debugPrint('Show notification failed: $e');
    }
  }
}
