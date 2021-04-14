import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';

abstract class FlutterLocalNotificationsPluginAdapter {
  init();

  show(int id, String title, String body, NotificationDetails notificationDetails,{String payload});

  Future<String> downloadAndSaveFile(String url, String fileName);
}
//최상단에 Define 할시에 Background 와 ForGround 객체가 같음 그래서 Stream 을 통해 CodeMain payLoad에서 데이터를 받음;
//Code Main 에 Stream을 Revice 받는 이유는 CodeMain의  BuildContext 로 Nagavitor을 실행 시켜 줘야 되서임.
final StreamController<String> selectNotificationSubjectStreamController = StreamController();

final Stream<String> selectNotificationSubject = selectNotificationSubjectStreamController.stream;

@LazySingleton(as: FlutterLocalNotificationsPluginAdapter)
class FlutterLocalNotificationsPluginAdapterImpl
    implements FlutterLocalNotificationsPluginAdapter {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  NotificationAppLaunchDetails notificationAppLaunchDetails;

  Future<void> init() async {
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
            selectNotificationSubjectStreamController.add(payload);
          }
        });
  }

  @override
  show(int id, String title, String body, NotificationDetails notificationDetails,{String payload}) async{
    if(payload != null){
      await flutterLocalNotificationsPlugin.show(id, title, body, notificationDetails,payload: payload);
    }else {
      await flutterLocalNotificationsPlugin.show(id, title, body, notificationDetails);
    }

  }

  Future<String> downloadAndSaveFile(String url, String fileName) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String filePath = '${directory.path}/$fileName';
    var dio = new Dio();
    var rs = await dio.get<List<int>>(url,options: Options(responseType: ResponseType.bytes));
    final File file = File(filePath);
    await file.writeAsBytes(rs.data);
    return filePath;
  }

}
