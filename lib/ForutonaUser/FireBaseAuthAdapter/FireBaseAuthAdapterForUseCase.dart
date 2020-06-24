import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:forutonafront/FireBaseMessage/Adapter/FireBaseMessageAdapter.dart';
import 'package:forutonafront/FireBaseMessage/UseCase/FireBaseTokenUpdateUseCase/FireBaseMessageTokenUpdateUseCaseInputPort.dart';

import 'FireBaseAuthBaseAdapter.dart';

abstract class FireBaseAuthAdapterForUseCase
    extends FireBaseAuthBaseAdapter {
  void startOnAuthStateChangedListen();
}

class FireBaseAuthAdapterForUseCaseImpl
    implements FireBaseAuthAdapterForUseCase {

  final FireBaseMessageAdapter fireBaseMessageAdapter;

  final FireBaseMessageTokenUpdateUseCaseInputPort
      fireBaseMessageTokenUpdateUseCaseInputPort;

  final FireBaseAuthBaseAdapter fireBaseAuthBaseAdapter;

  FireBaseAuthAdapterForUseCaseImpl(
      {@required this.fireBaseAuthBaseAdapter,
      @required this.fireBaseMessageAdapter,
      @required this.fireBaseMessageTokenUpdateUseCaseInputPort})
      : assert(fireBaseAuthBaseAdapter != null),
        assert(fireBaseMessageAdapter != null),
        assert(fireBaseMessageTokenUpdateUseCaseInputPort != null);

  startOnAuthStateChangedListen(){
    FirebaseAuth.instance.onAuthStateChanged.listen(onAuthStateChange);
  }

  Future<String> getFireBaseIdToken() async {
   return await fireBaseAuthBaseAdapter.getFireBaseIdToken();
  }

  Future<bool> isLogin() async {
    return await fireBaseAuthBaseAdapter.isLogin();
  }

  Future<String> userUid() async {
    return await fireBaseAuthBaseAdapter.userUid();
  }

  onAuthStateChange(FirebaseUser user) async {
    if(await isLogin()){
      fireBaseMessageTokenUpdateUseCaseInputPort.updateFireBaseMessageToken(
          user.uid, await fireBaseMessageAdapter.getCurrentToken());
    }
  }
}
