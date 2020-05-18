import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:forutonafront/Common/SignValid/FireBaseValidErrorUtil.dart';
import 'package:forutonafront/Common/SignValid/SingUp/SignUpValidService.dart';


import 'package:forutonafront/Common/SignValid/SingUpImpl/DefaultSignValidImpl.dart';

class IdDuplicationCheckSignValidImpl extends SignUpValidService with DefaultSignValidMix,IdDuplicationCheckSignValidMix{

}
mixin IdDuplicationCheckSignValidMix on SignUpValidService {
  bool _isFireBaseIdTextError = true;
  String _idFireBaseTextErrorText = "";

  hasEmailError(){
    if(_isFireBaseIdTextError){
      return _isFireBaseIdTextError;
    }
    return super.hasEmailError();
  }
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
      if(list.length>0){
        _isFireBaseIdTextError = true;
        _idFireBaseTextErrorText = "해당 아이디로 가입되어 있습니다.";
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
