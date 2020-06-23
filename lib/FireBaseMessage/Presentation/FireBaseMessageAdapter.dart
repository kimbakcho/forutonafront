import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:forutonafront/FireBaseMessage/UseCase/BaseMessageUseCase/BaseMessageUseCaseInputPort.dart';
import 'package:forutonafront/FireBaseMessage/UseCase/FireBaseTokenReFreshUseCase/FireBaseTokenReFreshUseCaseInputPort.dart';
import 'package:forutonafront/ServiceLocator.dart';

//FirebaseMessage BackGround 에 등록되는 메소드는 는 반드시 Top Level 메소드 여야 한다.
Future<dynamic> onFirebaseBackgroundMessage(var message) async{
  BaseMessageUseCaseInputPort backGroundMessageUseCase = sl.get(instanceName: "BackGroundMessageUseCase");
  backGroundMessageUseCase.message(message);
}

class FireBaseMessageAdapter {
  FirebaseMessaging _firebaseMessaging;

  FireBaseMessageAdapter() {
    _firebaseMessaging = FirebaseMessaging();
  }

  configure(
      {MessageHandler onMessage,
      MessageHandler onLaunch,
      MessageHandler onResume}) {
    _firebaseMessaging.configure(
        onBackgroundMessage: onFirebaseBackgroundMessage,
        onResume: onResume,
        onLaunch:onLaunch,
        onMessage: onMessage);
  }
  setRefreshTokenUseCase(FireBaseTokenReFreshUseCaseInputPort fireBaseTokenReFreshUseCaseInputPort){
    _firebaseMessaging.onTokenRefresh.listen((token) {
      fireBaseTokenReFreshUseCaseInputPort.updateReFreshToken(token);
    });
  }

  reqRefreshToken(){
    _firebaseMessaging.getToken();
  }

}
