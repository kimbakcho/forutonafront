
import 'package:flutter/cupertino.dart';
import 'package:forutonafront/AppBis/Notification/Value/NotificationServiceType.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:injectable/injectable.dart';

import 'Channel/NotificationChannel.dart';
import 'NotificationUseCase/NearBallCreateUseCase.dart';
import 'NotificationUseCase/NotificationUseCaseInputPort.dart';


class NotificationUseCaseFactory {
  static NotificationUseCaseInputPort create(NotificationServiceType notificationServiceType){
    if(notificationServiceType == NotificationServiceType.NearBallCreate){
      return sl.get<NotificationUseCaseInputPort>(instanceName: "NearBallCreateUseCase");
    } else if(notificationServiceType == NotificationServiceType.FBallReply){
      return sl.get<NotificationUseCaseInputPort>(instanceName: "NotificationFBallReplyUseCase");
    } else if(notificationServiceType == NotificationServiceType.FullTicketCharge){
      return sl.get<NotificationUseCaseInputPort>(instanceName: "FullTicketChargeUseCase");
    }else  {
      throw FlutterError("Not support NotificationServiceType");
    }

  }
}