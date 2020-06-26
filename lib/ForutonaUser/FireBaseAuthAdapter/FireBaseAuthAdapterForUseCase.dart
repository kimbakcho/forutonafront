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

  final FireBaseMessageAdapter _fireBaseMessageAdapter;

  final FireBaseMessageTokenUpdateUseCaseInputPort
      _fireBaseMessageTokenUpdateUseCaseInputPort;

  final FireBaseAuthBaseAdapter _fireBaseAuthBaseAdapter;

  FireBaseAuthAdapterForUseCaseImpl(
      {@required FireBaseMessageAdapter fireBaseMessageAdapter,
      @required FireBaseMessageTokenUpdateUseCaseInputPort fireBaseMessageTokenUpdateUseCaseInputPort,
      @required FireBaseAuthBaseAdapter fireBaseAuthBaseAdapter})
      : _fireBaseMessageAdapter = fireBaseMessageAdapter,
        _fireBaseMessageTokenUpdateUseCaseInputPort = fireBaseMessageTokenUpdateUseCaseInputPort,
        _fireBaseAuthBaseAdapter = fireBaseAuthBaseAdapter;

  startOnAuthStateChangedListen(){
    FirebaseAuth.instance.onAuthStateChanged.listen(_onAuthStateChange);
  }

  Future<String> getFireBaseIdToken() async {
   return await _fireBaseAuthBaseAdapter.getFireBaseIdToken();
  }

  Future<bool> isLogin() async {
    return await _fireBaseAuthBaseAdapter.isLogin();
  }

  Future<String> userUid() async {
    return await _fireBaseAuthBaseAdapter.userUid();
  }

  _onAuthStateChange(FirebaseUser user) async {
    if(await isLogin()){
      _fireBaseMessageTokenUpdateUseCaseInputPort.updateFireBaseMessageToken(
          user.uid, await _fireBaseMessageAdapter.getCurrentToken());
    }
  }
}
