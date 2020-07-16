import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:injectable/injectable.dart';

abstract class FlutterLocalNotificationsPluginAdapter {
  init();

  show(int id, String title, String body, NotificationDetails notificationDetails);
}

@Injectable(as: FlutterLocalNotificationsPluginAdapter, env: Environment.prod)
class FlutterLocalNotificationsPluginAdapterImpl
    implements FlutterLocalNotificationsPluginAdapter {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  NotificationAppLaunchDetails notificationAppLaunchDetails;


  Future<void> init() async {
    debugPrint("FlutterLocalNotificationsPluginAdapterImpl Init");
    notificationAppLaunchDetails =
        await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    var initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = IOSInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false,
        onDidReceiveLocalNotification:
            (int id, String title, String body, String payload) async {
        });
    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid,initializationSettingsIOS);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String payload) async {
          if (payload != null) {
            debugPrint('notification payload: ' + payload);
          }
        });
  }

  @override
  show(int id, String title, String body, NotificationDetails notificationDetails) async{
    await flutterLocalNotificationsPlugin.show(id, title, body, notificationDetails);
  }



}
