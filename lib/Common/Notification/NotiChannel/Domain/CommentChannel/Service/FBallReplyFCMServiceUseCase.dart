import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:forutonafront/Common/AvatarIamgeMaker/AvatarImageMakerUseCase.dart';
import 'package:forutonafront/Common/FileDownLoader/FileDownLoaderUseCaseInputPort.dart';
import 'package:forutonafront/Common/FlutterLocalNotificationPluginAdapter/FlutterLocalNotificationsPluginAdapter.dart';
import 'package:forutonafront/Common/ImageCropUtil/ImageCropUtilInputPort.dart';
import 'package:forutonafront/Common/Notification/NotiChannel/Domain/CommentChannel/CommentChannelBaseServiceUseCaseInputPort.dart';
import 'package:forutonafront/Common/Notification/NotiChannel/Dto/NotificationChannelDto.dart';
import 'package:forutonafront/Common/Notification/NotiSelectAction/Dto/ActionPayloadDto.dart';
import 'package:forutonafront/Common/Notification/NotiSelectAction/Dto/ID001PayloadDto.dart';
import 'package:forutonafront/FireBaseMessage/PlayloadDto/FCMReplyDto.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/FUser/SigInInUserInfoUseCase/SignInUserInfoUseCaseInputPort.dart';

class FBallReplyFCMServiceUseCase
    implements CommentChannelBaseServiceUseCaseInputPort {
  final FlutterLocalNotificationsPluginAdapter
      _flutterLocalNotificationsPluginAdapter;
  final SignInUserInfoUseCaseInputPort _signInUserInfoUseCaseInputPort;
  final AvatarImageMakerUseCaseInputPort _avatarImageMakerUseCaseInputPort;

  FBallReplyFCMServiceUseCase(
      {@required
          FlutterLocalNotificationsPluginAdapter
              flutterLocalNotificationsPluginAdapter,
      @required
        AvatarImageMakerUseCaseInputPort avatarImageMakerUseCaseInputPort,
      @required
          SignInUserInfoUseCaseInputPort signInUserInfoUseCaseInputPort,
      })
      : _flutterLocalNotificationsPluginAdapter =
            flutterLocalNotificationsPluginAdapter,
        _signInUserInfoUseCaseInputPort = signInUserInfoUseCaseInputPort,
        _avatarImageMakerUseCaseInputPort= avatarImageMakerUseCaseInputPort;


  @override
  reqNotification(Map<String, dynamic> message,
      NotificationChannelDto notificationChannelDto) async {
    var fcmReplyDto =
        FCMReplyDto.fromJson(json.decode(message["data"]["payload"]));

    var meInfo = _signInUserInfoUseCaseInputPort.reqSignInUserInfoFromMemory();

    String replyLargeIcon = await _avatarImageMakerUseCaseInputPort.makeAvatarImageToFile(
        fcmReplyDto.userProfileImageUrl, "replyLargeIcon");

    String meLargeIcon =
        await _avatarImageMakerUseCaseInputPort.makeAvatarImageToFile(meInfo.profilePictureUrl, "meLargeIcon");

    var me = Person(
      name: meInfo.nickName,
      key: meInfo.uid,
      icon: BitmapFilePathAndroidIcon(meLargeIcon),
    );

    var replyUser = Person(
      name: fcmReplyDto.nickName,
      key: fcmReplyDto.replyUserUid,
      icon: BitmapFilePathAndroidIcon(replyLargeIcon),
    );

    var messages = List<Message>();
    String replyText = fcmReplyDto.replyText;
    messages.add(Message(replyText, DateTime.now(), replyUser));

    var messagingStyle = MessagingStyleInformation(me,
        groupConversation: true,
        conversationTitle:
            fcmReplyDto.replyTitleType == "COMMENT" ? "댓글" : "답글",
        htmlFormatContent: true,
        htmlFormatTitle: true,
        messages: messages);

    AndroidNotificationDetails firstNotificationAndroidSpecifics =
        AndroidNotificationDetails(
      notificationChannelDto.channelId,
      notificationChannelDto.channelName,
      notificationChannelDto.channelDescription,
      visibility: NotificationVisibility.Public,
      importance: Importance.Low,
      priority: Priority.Default,
      groupKey: "co.kr.forutonaforutona.comment_Group",
      largeIcon: FilePathAndroidBitmap(replyLargeIcon),
      styleInformation: messagingStyle,
    );

    NotificationDetails firstNotificationPlatformSpecifics =
        NotificationDetails(firstNotificationAndroidSpecifics, null);

    ActionPayloadDto actionPayloadDto = ActionPayloadDto();
    actionPayloadDto.commandKey = "PageMoveActionUseCase";
    actionPayloadDto.serviceKey = "ID001PageMoveAction";
    ID001PayloadDto id001payloadDto = ID001PayloadDto();
    id001payloadDto.ballUuid = fcmReplyDto.ballUuid;
    actionPayloadDto.payload = json.encode(id001payloadDto.toJson());

    await _flutterLocalNotificationsPluginAdapter.show(0, "Message Box Style",
        "Message Box Style", firstNotificationPlatformSpecifics,
        payload: json.encode(actionPayloadDto.toJson()));
  }


}
