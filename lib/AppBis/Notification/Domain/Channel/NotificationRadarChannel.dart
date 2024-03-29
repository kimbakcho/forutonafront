import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:injectable/injectable.dart';

import 'NotificationChannel.dart';

@Named("NotificationRadarChannel")
@LazySingleton(as: NotificationChannel)
class NotificationRadarChannel implements NotificationChannel {
  NotificationDetails? platformChannelSpecifics;

  NotificationRadarChannel() {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
            '0', 'Rader', '내 주변 Ball에 대한 알림',
            importance: Importance.max,
            priority: Priority.high,
            onlyAlertOnce: true,
            showWhen: false,
            largeIcon: DrawableResourceAndroidBitmap("app_icon"));
    platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics,iOS: null,macOS: null);
  }

  @override
  NotificationDetails? getChannel() {
    return platformChannelSpecifics;
  }
}
