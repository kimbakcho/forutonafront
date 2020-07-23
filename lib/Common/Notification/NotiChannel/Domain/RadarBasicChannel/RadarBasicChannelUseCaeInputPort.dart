import 'package:forutonafront/Common/Notification/NotiChannel/Dto/NotificationChannelDto.dart';

abstract class RadarBasicChannelUseCaeInputPort {
  reqNotification(Map<String, dynamic> message,NotificationChannelDto notificationChannelDto);
}
