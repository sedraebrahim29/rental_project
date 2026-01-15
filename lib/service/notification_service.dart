import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationsService {
  static final _firebaseMessaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    /// 1️⃣ صلاحيات Firebase
    await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    /// 2️⃣ تهيئة Local Notifications
    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );

    const initSettings = InitializationSettings(android: androidSettings);

    await _localNotifications.initialize(initSettings);

    /// 3️⃣ FCM Token
    final token = await _firebaseMessaging.getToken();
    log('FCM TOKEN: $token');

    /// 4️⃣ استماع للرسائل (Foreground)
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);
  }

  static Future<void> _handleForegroundMessage(RemoteMessage message) async {
    final notification = message.notification;
    if (notification == null) return;

    const androidDetails = AndroidNotificationDetails(
      'default_channel',
      'General Notifications',
      channelDescription: 'App notifications',
      importance: Importance.max,
      priority: Priority.high,
    );

    const notificationDetails = NotificationDetails(android: androidDetails);

    await _localNotifications.show(
      notification.hashCode,
      notification.title,
      notification.body,
      notificationDetails,
    );
  }
}
