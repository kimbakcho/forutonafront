import 'package:forutonafront/Common/Notification/NotiChannel/NotificationChannelBaseInputPort.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';

import 'BaseMessageUseCaseInputPort.dart';

class BaseMessageUseCase implements BaseMessageUseCaseInputPort {
  @override
  Future message(Map<String, dynamic> message) {
    if (hasNotificationAction(message)) {
      if (message["data"].containsKey("commandKey")) {
        _notificationAction(message);
      }
    }
  }

  void _notificationAction(Map<String, dynamic> message) {
    NotificationChannelBaseInputPort notificationChannelBaseInputPort =
        sl.get<NotificationChannelBaseInputPort>(
            instanceName: "NotificationChannelBaseInputPortFactory",
            param1:  message["data"]["commandKey"]);
    notificationChannelBaseInputPort.reqNotification(message);
  }

  bool hasNotificationAction(Map<String, dynamic> message) {
    return message["data"].containsKey("isNotification") &&
        message["data"]["isNotification"] == "true";
  }
}
