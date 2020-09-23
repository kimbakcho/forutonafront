
import 'package:flutter/cupertino.dart';
import 'package:forutonafront/Common/Notification/NotiChannel/Domain/CommentChannel/CommentChannelBaseServiceUseCaseInputPort.dart';
import 'package:forutonafront/Common/Notification/NotiChannel/Dto/NotificationChannelDto.dart';
import 'package:forutonafront/Common/Notification/NotiChannel/NotificationChannelBaseInputPort.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:injectable/injectable.dart';
@named
@Injectable(as: NotificationChannelBaseInputPort)
class CommentChannelUseCase implements NotificationChannelBaseInputPort {
  String groupChannelId = 'co.kr.forutonaforutona.comment';
  String groupChannelName = 'Comment_Group';
  String groupChannelDescription = '내가만든Ball 에댓글이날리거나, 내가작성한댓글에답글이달렸을때알림을받습니다';
  NotificationChannelDto _notificationChannelDto;

  @override
  reqNotification(Map<String, dynamic> message) async {
    if (hasServiceNotification(message)) {
      _commentServiceAction(message);
    }
  }

  CommentChannelUseCase() {
    _notificationChannelDto = NotificationChannelDto(
        channelId: groupChannelId,
        channelName: groupChannelName,
        channelDescription: groupChannelDescription);
  }

  bool hasServiceNotification(Map<String, dynamic> message) =>
      message["data"].containsKey("serviceKey");

  void _commentServiceAction(Map<String, dynamic> message) {
    CommentChannelBaseServiceUseCaseInputPort
    commentChannelBaseServiceUseCaseInputPort = sl.get(
        instanceName: "CommentChannelBaseServiceUseCaseInputPortFactory",
        param1: message["data"]["serviceKey"]);

    commentChannelBaseServiceUseCaseInputPort.reqNotification(message,_notificationChannelDto);
  }
}
