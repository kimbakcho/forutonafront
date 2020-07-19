import 'package:forutonafront/Common/Notification/NotiChannel/NotificationChannelBaseInputPort.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';

abstract class BaseMessageUseCaseInputPort {
  Future<dynamic> message(Map<String, dynamic> message);
}

