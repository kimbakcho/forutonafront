import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:forutonafront/Common/FlutterLocalNotificationPluginAdapter/FlutterLocalNotificationsPluginAdapter.dart';
import 'package:injectable/injectable.dart';

abstract class MessageChanelUseCaseInputPort {
  reqNotification();
}

@Injectable(as: MessageChanelUseCaseInputPort, env: Environment.prod)
class MessageChanelUseCase implements MessageChanelUseCaseInputPort {
  FlutterLocalNotificationsPluginAdapter
      _flutterLocalNotificationsPluginAdapter;
  String groupKey = 'com.android.example.WORK_EMAIL';
  String groupChannelId = 'grouped channel id';
  String groupChannelName = 'grouped channel name';
  String groupChannelDescription = 'grouped channel description';

  MessageChanelUseCase(
      {@required
          FlutterLocalNotificationsPluginAdapter
              flutterLocalNotificationsPluginAdapter})
      : _flutterLocalNotificationsPluginAdapter =
            flutterLocalNotificationsPluginAdapter;

  @override
  reqNotification() async {
    AndroidNotificationDetails firstNotificationAndroidSpecifics =
    AndroidNotificationDetails(
        groupChannelId, groupChannelName, groupChannelDescription,
        importance: Importance.Max,
        priority: Priority.High,
        groupKey: groupKey);
    NotificationDetails firstNotificationPlatformSpecifics =  NotificationDetails(firstNotificationAndroidSpecifics, null);
    await _flutterLocalNotificationsPluginAdapter.show(1, 'Alex Faarborg',
        'You will not believe...', firstNotificationPlatformSpecifics);
    //TODO 현제 테스트 코드만
  }
}
