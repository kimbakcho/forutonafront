
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_local_notifications/src/notification_details.dart';
import 'package:injectable/injectable.dart';

import 'NotificationChannel.dart';

@Named("NotificationMyFluenceChannel")
@LazySingleton(as: NotificationChannel)
class NotificationMyFluenceChannel implements NotificationChannel {

  NotificationDetails platformChannelSpecifics;

  NotificationMyFluenceChannel(){
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
        '2', 'MyFluence', '내 영향력과 관련한 알림',
        importance: Importance.Default,
        priority: Priority.Default,
        onlyAlertOnce: false,
        showWhen: false,
        largeIcon: DrawableResourceAndroidBitmap("app_icon"));
    platformChannelSpecifics =
        NotificationDetails(androidPlatformChannelSpecifics,null);
  }

  @override
  NotificationDetails getChannel() {
    return platformChannelSpecifics;
  }


}