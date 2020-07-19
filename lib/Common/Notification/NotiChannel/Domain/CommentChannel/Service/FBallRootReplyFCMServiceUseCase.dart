import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:forutonafront/Common/FileDownLoader/FileDownLoaderUseCaseInputPort.dart';
import 'package:forutonafront/Common/FlutterLocalNotificationPluginAdapter/FlutterLocalNotificationsPluginAdapter.dart';
import 'package:forutonafront/Common/Notification/NotiChannel/Domain/CommentChannel/CommentChannelBaseServiceUseCaseInputPort.dart';
import 'package:forutonafront/Common/Notification/NotiChannel/Dto/NotificationChannelDto.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/FUser/SigInInUserInfoUseCase/SignInUserInfoUseCaseInputPort.dart';

class FBallRootReplyFCMServiceUseCase
    implements CommentChannelBaseServiceUseCaseInputPort {
  final FlutterLocalNotificationsPluginAdapter
      _flutterLocalNotificationsPluginAdapter;
  final FileDownLoaderUseCaseInputPort _fileDownLoaderUseCaseInputPort;
  final SignInUserInfoUseCaseInputPort _signInUserInfoUseCaseInputPort;

  FBallRootReplyFCMServiceUseCase(
      {@required
          FlutterLocalNotificationsPluginAdapter
              flutterLocalNotificationsPluginAdapter,
      @required
          FileDownLoaderUseCaseInputPort fileDownLoaderUseCaseInputPort,
      @required
          SignInUserInfoUseCaseInputPort signInUserInfoUseCaseInputPort})
      : _flutterLocalNotificationsPluginAdapter =
            flutterLocalNotificationsPluginAdapter,
        _fileDownLoaderUseCaseInputPort = fileDownLoaderUseCaseInputPort,
        _signInUserInfoUseCaseInputPort = signInUserInfoUseCaseInputPort;

  @override
  reqNotification(Map<String, dynamic> message,
      NotificationChannelDto notificationChannelDto) async {
    var meInfo = _signInUserInfoUseCaseInputPort.reqSignInUserInfoFromMemory();

    var replyLargeIcon =
        await _fileDownLoaderUseCaseInputPort.downloadAndSaveFile(
            message["data"]["userProfileImageUrl"], 'replyLargeIcon');

    var meLargeIcon = await _fileDownLoaderUseCaseInputPort.downloadAndSaveFile(
        meInfo.profilePictureUrl, 'meLargeIcon');

    var me = Person(
      name: meInfo.nickName,
      key: meInfo.uid,
      icon: BitmapFilePathAndroidIcon(meLargeIcon),
    );

    var replyUser = Person(
      name: message["data"]["nickName"],
      key: message["data"]["replyUserUid"],
      icon: BitmapFilePathAndroidIcon(replyLargeIcon),
    );

    var messages = List<Message>();
    String replyText = message["data"]["replyText"];
    messages.add(Message(replyText, DateTime.now(), replyUser));

    var messagingStyle = MessagingStyleInformation(me,
        groupConversation: true,
        conversationTitle: '댓글',
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
            groupKey: notificationChannelDto.key,
            styleInformation: messagingStyle,
        );

    NotificationDetails firstNotificationPlatformSpecifics =
        NotificationDetails(firstNotificationAndroidSpecifics, null);


    await _flutterLocalNotificationsPluginAdapter.show(
        0, "Message Box Style", "Message Box Style", firstNotificationPlatformSpecifics);
  }
}
