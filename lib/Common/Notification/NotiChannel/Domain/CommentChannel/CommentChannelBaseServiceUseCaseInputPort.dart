import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:forutonafront/Common/Notification/NotiChannel/Dto/NotificationChannelDto.dart';

abstract class CommentChannelBaseServiceUseCaseInputPort {
  reqNotification(Map<String, dynamic> message,NotificationChannelDto notificationChannelDto);
}
