import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:forutonafront/Common/FlutterLocalNotificationPluginAdapter/FlutterLocalNotificationsPluginAdapter.dart';
import 'package:forutonafront/Common/Notification/NotiChannel/Domain/RadarBasicChannel/RadarBasicChannelUseCaeInputPort.dart';
import 'package:forutonafront/Common/Notification/NotiChannel/Dto/NotificationChannelDto.dart';
import 'package:forutonafront/Common/Notification/NotiSelectAction/Dto/ActionPayloadDto.dart';
import 'package:forutonafront/Common/Notification/NotiSelectAction/Dto/ID001PayloadDto.dart';
import 'package:forutonafront/FireBaseMessage/PlayloadDto/FCMFBallMakeDto.dart';

class IssueFBalIInsertFCMServiceUseCase
    implements RadarBasicChannelUseCaeInputPort {

  final FlutterLocalNotificationsPluginAdapter
  _flutterLocalNotificationsPluginAdapter;

  IssueFBalIInsertFCMServiceUseCase({
    @required FlutterLocalNotificationsPluginAdapter flutterLocalNotificationsPluginAdapter
  })
      :_flutterLocalNotificationsPluginAdapter = flutterLocalNotificationsPluginAdapter;

  @override
  reqNotification(Map<String, dynamic> message,
      NotificationChannelDto notificationChannelDto) async {
    var fcmBallMakeDto = FCMFBallMakeDto.fromJson(
        json.decode(message["data"]["payload"]));

    var ball = Person(
      name: fcmBallMakeDto.ballMakerNickName,
      key: fcmBallMakeDto.ballUuid,
      icon: FlutterBitmapAssetAndroidIcon("assets/MainImage/issue.png"),
    );


    var messages = List<Message>();
    String replyText = fcmBallMakeDto.ballTitle;
    messages.add(Message(replyText, DateTime.now(), ball));

    var messagingStyle = MessagingStyleInformation(ball,
        groupConversation: true,
        conversationTitle: "신규Ball 등장",
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
      largeIcon: DrawableResourceAndroidBitmap("issueballicon"),
      styleInformation: messagingStyle,
    );

    NotificationDetails firstNotificationPlatformSpecifics =
    NotificationDetails(firstNotificationAndroidSpecifics, null);

    ActionPayloadDto actionPayloadDto = ActionPayloadDto();
    actionPayloadDto.commandKey = "PageMoveActionUseCase";
    actionPayloadDto.serviceKey = "ID001PageMoveAction";
    ID001PayloadDto id001payloadDto = ID001PayloadDto();
    id001payloadDto.ballUuid = fcmBallMakeDto.ballUuid;
    actionPayloadDto.payload = json.encode(id001payloadDto.toJson());

    await _flutterLocalNotificationsPluginAdapter.show(0, "Message Box Style",
        "Message Box Style", firstNotificationPlatformSpecifics,
        payload: json.encode(actionPayloadDto.toJson()));
  }

}