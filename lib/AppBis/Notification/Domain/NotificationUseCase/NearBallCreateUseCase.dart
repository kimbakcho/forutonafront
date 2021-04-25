import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:forutonafront/AppBis/FBall/Domain/Value/FBallType.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/FUser/SigInInUserInfoUseCase/SignInUserInfoUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/Notification/Domain/Channel/NotificationChannel.dart';
import 'package:forutonafront/Common/FireBaseMessage/Adapter/FireBaseMessageAdapter.dart';
import 'package:forutonafront/Common/FireBaseMessage/PlayloadDto/FCMFBallMakeDto.dart';
import 'package:forutonafront/Common/FlutterLocalNotificationPluginAdapter/FlutterLocalNotificationsPluginAdapter.dart';
import 'package:forutonafront/Page/ICodePage/ID01/ID01MainPage.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:injectable/injectable.dart';

import 'NotificationUseCaseInputPort.dart';

@Named("NearBallCreateUseCase")
@LazySingleton(as: NotificationUseCaseInputPort)
class NearBallCreateUseCase implements NotificationUseCaseInputPort{

  final FlutterLocalNotificationsPluginAdapter flutterLocalNotificationsPluginAdapter;

  final SignInUserInfoUseCaseInputPort signInUserInfoUseCaseInputPort;

  NearBallCreateUseCase(this.flutterLocalNotificationsPluginAdapter,this.signInUserInfoUseCaseInputPort);

  @override
  Future<void> resNotification(Map<String, dynamic> message) async {

    NotificationChannel notificationChannel = sl.get<NotificationChannel>(instanceName: "NotificationRadarChannel");
    NotificationDetails channel = notificationChannel.getChannel();
    var payload = json.encode(message['data']) ;
    flutterLocalNotificationsPluginAdapter.show(0, "새로운 Ball", "내 근처에서 새로운 Ball이 설치되었습니다!", channel,payload: payload);
  }

  @override
  Future<void> selectAction(BuildContext context, String payload) async {
    var decodePayload = json.decoder.convert(payload);
    var fcmfBallMakeDto = FCMFBallMakeDto.fromJson(decodePayload);
    if(fcmfBallMakeDto.fBallType == FBallType.IssueBall){
      Navigator.of(context).push(MaterialPageRoute(builder: (_){
        return ID01MainPage(ballUuid: fcmfBallMakeDto.ballUuid);
      }));
    }
  }

}