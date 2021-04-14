import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:forutonafront/AppBis/FBall/Domain/Value/FBallType.dart';
import 'package:forutonafront/Common/FireBaseMessage/PlayloadDto/FCMReplyDto.dart';
import 'package:forutonafront/Common/FlutterLocalNotificationPluginAdapter/FlutterLocalNotificationsPluginAdapter.dart';
import 'package:forutonafront/Page/ICodePage/ID01/ID01MainPage.dart';
import 'package:injectable/injectable.dart';

import 'NotificationUseCaseInputPort.dart';

@Named("NotificationFBallReplyUseCase")
@LazySingleton(as: NotificationUseCaseInputPort)
class NotificationFBallReplyUseCase implements NotificationUseCaseInputPort {
  final FlutterLocalNotificationsPluginAdapter
      flutterLocalNotificationsPluginAdapter;

  NotificationFBallReplyUseCase(this.flutterLocalNotificationsPluginAdapter);

  @override
  Future<void> resNotification(Map<String, dynamic> message) async {
    String payload = message['data']['payload'];

    var convert = json.decoder.convert(payload);

    var fcmReplyDto = FCMReplyDto.fromJson(convert);

    AndroidBitmap largeIcon = null;

    if(fcmReplyDto.userProfileImageUrl != null && fcmReplyDto.userProfileImageUrl.isNotEmpty){
      String imageFilePath = await this
          .flutterLocalNotificationsPluginAdapter
          .downloadAndSaveFile(
          fcmReplyDto.userProfileImageUrl, "tempReplyNotiImage.png");
      largeIcon = FilePathAndroidBitmap(imageFilePath);
    }else {
      largeIcon = DrawableResourceAndroidBitmap("app_icon");
    }

    AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('1', 'Comment', '댓글 답글에 관한 알림',
            importance: Importance.Max,
            priority: Priority.High,
            onlyAlertOnce: true,
            showWhen: false,
            largeIcon: largeIcon);

    NotificationDetails platformChannelSpecifics =
        NotificationDetails(androidPlatformChannelSpecifics, null);

    var sendPayload = json.encode(message['data']);

    String title = "";

    if(fcmReplyDto.replyTitleType == "COMMENT"){
      title = "댓글";
    }else {
      title = "답글";
    }
    flutterLocalNotificationsPluginAdapter.show(1, title, "${fcmReplyDto.nickName}  ${fcmReplyDto.replyText}", platformChannelSpecifics ,payload: sendPayload);
  }

  @override
  Future<void> selectAction(BuildContext context, String payload)  async {
    var decodePayload = json.decoder.convert(payload);
    var fcmReplyDto = FCMReplyDto.fromJson(decodePayload);
    if(fcmReplyDto.fBallType == FBallType.IssueBall){
      Navigator.of(context).push(MaterialPageRoute(builder: (_){
        return ID01MainPage(ballUuid: fcmReplyDto.ballUuid);
      }));
    }
  }
}
