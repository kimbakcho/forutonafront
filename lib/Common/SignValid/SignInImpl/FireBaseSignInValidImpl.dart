import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:forutonafront/Common/SignValid/FireBaseValidErrorUtil.dart';
import 'package:forutonafront/Common/SignValid/SignIn/SignInValidWithSignInService.dart';

class FireBaseSignInValidImpl implements SignInValidWithSignInService{
  bool _signInError = false;
  String _signInErrorText = "";


  @override
  String signInErrorText() {
    return _signInErrorText;
  }

  @override
  bool hasSignInError() {
    return _signInError;
  }

  @override
  Future<void> signInValidWithSignIn(String email,String pw) async {
    _signInError = false;
    _signInErrorText = "";
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: pw);
    }on PlatformException catch (e) {
      FireBaseValidErrorUtil fireBaseValidErrorUtil = new FireBaseValidErrorUtil();
      _signInError = true;
      _signInErrorText = fireBaseValidErrorUtil.getErrorText(e);
      return ;
    }
  }



}