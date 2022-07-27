import 'dart:typed_data';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationApi {
  static final notifications = FlutterLocalNotificationsPlugin();
  static final onNotifications = BehaviorSubject<String?>();

  static Future _notificationDetails(String? sound, Int32List? alarm) async {
    return NotificationDetails(
      android: AndroidNotificationDetails('noId', 'Task',
          channelDescription: 'Roozaneh Task notificaitons',
          playSound: true,
          enableVibration: true,
          autoCancel: false,
          sound: RawResourceAndroidNotificationSound(sound ?? 'sound1'),
          importance: Importance.high,
          additionalFlags: alarm,
          icon: 'ic_notification'),
      iOS: const IOSNotificationDetails(),
    );
  }

  static Future showScheduledNotification({
    int? id,
    String? notificationSound,
    String? title,
    String? body,
    String? payload,
    Int32List? repeatFlagFour,
    required DateTime scheduledDate,
  }) async =>
      notifications.zonedSchedule(
          id!,
          title,
          body,
          tz.TZDateTime.from(scheduledDate, tz.local),
          await _notificationDetails(notificationSound, repeatFlagFour),
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.wallClockTime,
          androidAllowWhileIdle: true,
          payload: payload);

  static Future init({bool initScheduled = false}) async {
    const iOS = IOSInitializationSettings();
    const android = AndroidInitializationSettings('@drawable/ic_notification');
    const settings = InitializationSettings(android: android, iOS: iOS);

    await notifications.initialize(
      settings,
      onSelectNotification: (payload) async {},
    );
  }
}
