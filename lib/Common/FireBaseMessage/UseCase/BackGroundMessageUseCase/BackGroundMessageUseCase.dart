import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/cupertino.dart';
import 'package:forutonafront/AppBis/Notification/Domain/NotificationUseCase/NotificationUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/Notification/Domain/NotificationUseCaseFactory.dart';
import 'package:forutonafront/AppBis/Notification/Value/NotificationServiceType.dart';
import 'package:forutonafront/Common/FireBaseMessage/UseCase/BaseMessageUseCase/BaseMessageUseCase.dart';
import 'package:injectable/injectable.dart';

import '../FCMMessageUseCaseInputPort.dart';

@Named("BackGroundMessageUseCase")
@LazySingleton(as: FCMMessageUseCaseInputPort)
class BackGroundMessageUseCase implements FCMMessageUseCaseInputPort {

  @override
  Future<dynamic> message(Map<String, dynamic> message) async {
    NotificationServiceType notificationServiceType = EnumToString.fromString(NotificationServiceType.values, message["data"]["serviceKey"])!;
    NotificationUseCaseInputPort notificationUseCaseInputPort = NotificationUseCaseFactory.create(notificationServiceType);
    notificationUseCaseInputPort.resNotification(message);
  }

}
