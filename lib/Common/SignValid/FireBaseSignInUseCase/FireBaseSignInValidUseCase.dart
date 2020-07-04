import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:forutonafront/Common/SignValid/FireBaseValidErrorUtil.dart';
import 'package:forutonafront/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthAdapterForUseCase.dart';

abstract class FireBaseSignInValidUseCase {
  String signInErrorText();

  bool hasSignInError();

  Future<void> signInValidWithSignIn(String email, String pw);

}

class FireBaseSignInValidUseCaseImpl implements FireBaseSignInValidUseCase {
  bool _signInError = false;
  String _signInErrorText = "";

  FireBaseAuthAdapterForUseCase _fireBaseAuthAdapterForUseCase;

  FireBaseSignInValidUseCaseImpl(
      {@required FireBaseAuthAdapterForUseCase fireBaseAuthAdapterForUseCase})
      : _fireBaseAuthAdapterForUseCase = fireBaseAuthAdapterForUseCase;

  @override
  String signInErrorText() {
    return _signInErrorText;
  }

  @override
  bool hasSignInError() {
    return _signInError;
  }

  @override
  Future<void> signInValidWithSignIn(String email, String pw) async {
    _signInError = false;
    _signInErrorText = "";
    try {
      await _fireBaseAuthAdapterForUseCase
          .signInWithEmailAndPassword(email,pw);
    } on PlatformException catch (e) {
      FireBaseValidErrorUtil fireBaseValidErrorUtil =
          new FireBaseValidErrorUtil();
      _signInError = true;
      _signInErrorText = fireBaseValidErrorUtil.getErrorText(e);
      return;
    }
  }
}
