
import 'dart:convert';

import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/FUser/SigInInUserInfoUseCase/SignInUserInfoUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/Notification/Domain/Channel/NotificationChannel.dart';
import 'package:forutonafront/Common/FireBaseMessage/PlayloadDto/FullChargePayLoadDto.dart';
import 'package:forutonafront/Common/FlutterLocalNotificationPluginAdapter/FlutterLocalNotificationsPluginAdapter.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:injectable/injectable.dart';

import 'NotificationUseCaseInputPort.dart';

@Named("FullTicketChargeUseCase")
@LazySingleton(as: NotificationUseCaseInputPort)
class FullTicketChargeUseCase implements NotificationUseCaseInputPort {

  final FlutterLocalNotificationsPluginAdapter flutterLocalNotificationsPluginAdapter;

  final SignInUserInfoUseCaseInputPort signInUserInfoUseCaseInputPort;

  FullTicketChargeUseCase(this.flutterLocalNotificationsPluginAdapter,this.signInUserInfoUseCaseInputPort);

  @override
  Future<void> resNotification(Map<String, dynamic> message) async {

    bool isLogin = await signInUserInfoUseCaseInputPort.isLoginFromPreference();
    if(!isLogin){
      return ;
    }
    NotificationChannel notificationChannel = sl.get<NotificationChannel>(instanceName: "NotificationMyFluenceChannel");

    NotificationDetails channel = notificationChannel.getChannel()!;
    String payload = message['data']['payload'];

    var convert = json.decoder.convert(payload);
    var fullChargePayLoadDto = FullChargePayLoadDto.fromJson(convert);
    flutterLocalNotificationsPluginAdapter.show(0, "영향력 충전완료", "${fullChargePayLoadDto.userNickName} 님의 영향력이 모두 충전되었습니다!", channel,payload: payload);

  }

  @override
  Future<void> selectAction(BuildContext context, String payload) async{
    print("show");
  }

}