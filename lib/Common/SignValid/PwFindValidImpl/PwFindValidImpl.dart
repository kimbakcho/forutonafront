import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:forutonafront/Common/SignValid/PwFindValid/PwFindValidService.dart';
import 'package:forutonafront/Common/SignValid/SingUp/SignUpValidService.dart';
import 'package:forutonafront/Common/SignValid/SingUpImpl/DefaultSignValidImpl.dart';

import '../FireBaseValidErrorUtil.dart';

class PwFindValidImpl extends PwFindValidService with DefaultSignValidMix,DefaultPwFindValidMix {

}

mixin DefaultPwFindValidMix on SignUpValidService  {
  bool _isFireBaseIdTextError = true;
  String _idFireBaseTextErrorText = "";

  @override
  hasEmailError(){
    if(_isFireBaseIdTextError){
      return _isFireBaseIdTextError;
    }
    return super.hasEmailError();
  }
  @override
  emailErrorText(){
    if(_isFireBaseIdTextError){
      return _idFireBaseTextErrorText;
    }
    return super.emailErrorText();
  }


  @override
  Future<void> emailIdValid(String email) async {
    List<String> list;
    _isFireBaseIdTextError = false;
    _idFireBaseTextErrorText = "";
    try{
      list =
      await FirebaseAuth.instance.fetchSignInMethodsForEmail(email: email);
      if(list.length == 0){
        _isFireBaseIdTextError = true;
        _idFireBaseTextErrorText = "*입력하신 정보와 일치하는 계정이 없습니다.";
        return ;
      }
    }on PlatformException catch (e) {
      FireBaseValidErrorUtil error = FireBaseValidErrorUtil();
      _isFireBaseIdTextError = true;
      _idFireBaseTextErrorText = error.getErrorText(e);
      return ;
    }
    super.emailIdValid(email);
  }
}