import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:forutonafront/FireBaseMessage/Adapter/FireBaseMessageAdapter.dart';
import 'package:forutonafront/FireBaseMessage/UseCase/FireBaseTokenUpdateUseCase/FireBaseMessageTokenUpdateUseCaseInputPort.dart';


abstract class FireBaseAuthBaseAdapter {
  Future<String> getFireBaseIdToken();
  Future<bool> isLogin();
  Future<String> userUid();
}

class FireBaseAuthBaseAdapterImpl implements FireBaseAuthBaseAdapter {
  final noneToken = "noneToken";

  Future<String> getFireBaseIdToken() async {
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    if (firebaseUser == null) {
      return noneToken;
    }
    var idTokenResult = await firebaseUser.getIdToken(refresh: true);
    return idTokenResult.token;
  }

  Future<bool> isLogin() async {
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    if (firebaseUser == null) {
      return false;
    } else {
      return true;
    }
  }

  Future<String> userUid() async {
    if (await isLogin()) {
      var firebaseUser = await FirebaseAuth.instance.currentUser();
      return firebaseUser.uid;
    } else {
      throw new FireBaseAdapterException("no Login statue");
    }
  }

}

class FireBaseAdapterException implements Exception {
  String errMsg;

  FireBaseAdapterException(this.errMsg);
}
