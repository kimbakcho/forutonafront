import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:forutonafront/FireBaseMessage/UseCase/BaseMessageUseCase/BaseMessageUseCaseInputPort.dart';
import 'package:forutonafront/FireBaseMessage/UseCase/FireBaseTokenUpdateUseCase/FireBaseMessageTokenUpdateUseCase.dart';
import 'package:forutonafront/FireBaseMessage/UseCase/FireBaseTokenUpdateUseCase/FireBaseMessageTokenUpdateUseCaseInputPort.dart';
import 'package:forutonafront/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthBaseAdapter.dart';
import 'package:forutonafront/ServiceLocator.dart';

//FirebaseMessage BackGround 에 등록되는 메소드는 는 반드시 Top Level 메소드 여야 한다.
Future<dynamic> onFirebaseBackgroundMessage(var message) async {
  BaseMessageUseCaseInputPort backGroundMessageUseCase =
      sl.get(instanceName: "BackGroundMessageUseCase");
  backGroundMessageUseCase.message(message);
}

abstract class FireBaseMessageAdapter {
  configure(
      {MessageHandler onMessage,
      MessageHandler onLaunch,
      MessageHandler onResume});

  Future<String> getCurrentToken();
}

class FireBaseMessageAdapterImpl implements FireBaseMessageAdapter {
  FirebaseMessaging _firebaseMessaging;

  FireBaseMessageTokenUpdateUseCaseInputPort fireBaseMessageTokenUpdateUseCaseInputPort;

  FireBaseAuthBaseAdapter fireBaseAuthBaseAdapter;

  FireBaseMessageAdapterImpl(
      {@required this.fireBaseMessageTokenUpdateUseCaseInputPort,
      @required this.fireBaseAuthBaseAdapter})
      : assert(fireBaseMessageTokenUpdateUseCaseInputPort != null),
        assert(fireBaseAuthBaseAdapter != null) {
    _firebaseMessaging = FirebaseMessaging();
    _firebaseMessaging.onTokenRefresh.listen(onTokenRefresh);
  }

  configure(
      {MessageHandler onMessage,
      MessageHandler onLaunch,
      MessageHandler onResume}) {
    _firebaseMessaging.configure(
        onBackgroundMessage: onFirebaseBackgroundMessage,
        onResume: onResume,
        onLaunch: onLaunch,
        onMessage: onMessage);
  }

  void onTokenRefresh(String token) async {
    if (await fireBaseAuthBaseAdapter.isLogin()) {
      fireBaseMessageTokenUpdateUseCaseInputPort.updateFireBaseMessageToken(
          await fireBaseAuthBaseAdapter.userUid(), token);
    }
  }

  @override
  Future<String> getCurrentToken() async {
    return await _firebaseMessaging.getToken();
  }
}
