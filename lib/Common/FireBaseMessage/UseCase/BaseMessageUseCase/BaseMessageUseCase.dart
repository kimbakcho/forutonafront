import 'package:enum_to_string/enum_to_string.dart';
import 'package:forutonafront/AppBis/Notification/Domain/NotificationUseCase/NotificationUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/Notification/Domain/NotificationUseCaseFactory.dart';
import 'package:forutonafront/AppBis/Notification/Value/NotificationServiceType.dart';
import 'package:injectable/injectable.dart';

import '../FCMMessageUseCaseInputPort.dart';

@Named("BaseMessageUseCase")
@LazySingleton(as: FCMMessageUseCaseInputPort)
class BaseMessageUseCase implements FCMMessageUseCaseInputPort {

  Future message(Map<String, dynamic> message) async {
    if (hasNotificationAction(message)) {
      if (message["data"].containsKey("serviceKey")) {
        _notificationAction(message);
      }
    }
  }

  void _notificationAction(Map<String, dynamic> message) {
    NotificationServiceType notificationServiceType = EnumToString.fromString(NotificationServiceType.values, message["data"]["serviceKey"])!;
    NotificationUseCaseInputPort notificationUseCaseInputPort = NotificationUseCaseFactory.create(notificationServiceType);
    notificationUseCaseInputPort.resNotification(message);
  }

  bool hasNotificationAction(Map<String, dynamic> message) {
    return message["data"].containsKey("isNotification") &&
        message["data"]["isNotification"] == "true";
  }
}
