import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:forutonafront/FireBaseMessage/UseCase/BaseMessageUseCase/BaseMessageUseCaseInputPort.dart';
import 'package:forutonafront/FireBaseMessage/UseCase/FireBaseTokenUpdateUseCase/FireBaseMessageTokenUpdateUseCaseInputPort.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/FUser/SigInInUserInfoUseCase/SignInUserInfoUseCaseInputPort.dart';
import 'package:forutonafront/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthAdapterForUseCase.dart';
import 'package:forutonafront/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthBaseAdapter.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart' as di;

//FirebaseMessage BackGround 에 등록되는 메소드는 는 반드시 Top Level 메소드 여야 한다.
//메소드 이름을  onFirebaseBackgroundMessage 으로 시작하면 안된다
//만약 이름을 위와 같이 하면 There was an exception when getting callback handle from Dart side 에러가 뜬다..
Future<dynamic> firebaseBackgroundMessage(Map<String, dynamic> message) async {
  FireBaseAuthAdapterForUseCase fireBaseAuthAdapterForUseCase;
  try {
    fireBaseAuthAdapterForUseCase = sl();
  } catch (ex) {
    print("backgroundService ServiceLocator init");
    di.init();
    fireBaseAuthAdapterForUseCase =
        await loginUserInfoDataSaveForMemory(fireBaseAuthAdapterForUseCase);
  } finally {
    if (await fireBaseAuthAdapterForUseCase.isLogin()) {
      BaseMessageUseCaseInputPort backGroundMessageUseCase =
          sl.get(instanceName: "BackGroundMessageUseCase");
      backGroundMessageUseCase.message(message);
    }
  }
}

Future<FireBaseAuthAdapterForUseCase> loginUserInfoDataSaveForMemory(
    FireBaseAuthAdapterForUseCase fireBaseAuthAdapterForUseCase) async {
  fireBaseAuthAdapterForUseCase = sl();
  fireBaseAuthAdapterForUseCase.startOnAuthStateChangedListen();
  if (await fireBaseAuthAdapterForUseCase.isLogin()) {
    SignInUserInfoUseCaseInputPort signInUserInfoUseCaseInputPort = sl();
    await signInUserInfoUseCaseInputPort.saveSignInInfoInMemoryFromAPiServer(
        await fireBaseAuthAdapterForUseCase.userUid());
  }
  return fireBaseAuthAdapterForUseCase;
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

  final FireBaseMessageTokenUpdateUseCaseInputPort
      _fireBaseMessageTokenUpdateUseCaseInputPort;

  final FireBaseAuthBaseAdapter _fireBaseAuthBaseAdapter;

  FireBaseMessageAdapterImpl(
      {@required
          FireBaseMessageTokenUpdateUseCaseInputPort
              fireBaseMessageTokenUpdateUseCaseInputPort,
      @required
          FireBaseAuthBaseAdapter fireBaseAuthBaseAdapter})
      : _fireBaseMessageTokenUpdateUseCaseInputPort =
            fireBaseMessageTokenUpdateUseCaseInputPort,
        _fireBaseAuthBaseAdapter = fireBaseAuthBaseAdapter {
    _firebaseMessaging = FirebaseMessaging();
    _firebaseMessaging.onTokenRefresh.listen(_onTokenRefresh);
  }

  configure(
      {MessageHandler onMessage,
      MessageHandler onLaunch,
      MessageHandler onResume}) {
    _firebaseMessaging.configure(
        onBackgroundMessage: firebaseBackgroundMessage,
        onResume: onResume,
        onLaunch: onLaunch,
        onMessage: onMessage);
  }

  void _onTokenRefresh(String token) async {
    if (await _fireBaseAuthBaseAdapter.isLogin()) {
      _fireBaseMessageTokenUpdateUseCaseInputPort.updateFireBaseMessageToken(
          await _fireBaseAuthBaseAdapter.userUid(), token);
    }
  }

  @override
  Future<String> getCurrentToken() async {
    return await _firebaseMessaging.getToken();
  }
}
