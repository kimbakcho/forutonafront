
import 'package:forutonafront/Common/Notification/NotiChannel/Dto/NotificationChannelDto.dart';

abstract class CommentChannelBaseServiceUseCaseInputPort {
  reqNotification(Map<String, dynamic> message,NotificationChannelDto notificationChannelDto);
}
