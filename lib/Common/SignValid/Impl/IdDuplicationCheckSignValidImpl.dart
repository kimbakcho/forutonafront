import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:forutonafront/Common/SignValid/Impl/DefaultSignValidImpl.dart';
import 'package:forutonafront/Common/SignValid/SignVaildService.dart';

class IdDuplicationCheckSignValidImpl extends SignValidService with DefaultSignValidMix,IdDuplicationCheckSignValidMix{

}
mixin IdDuplicationCheckSignValidMix on SignValidService {
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
      if(e.code == "ERROR_INVALID_EMAIL"){
        _isFireBaseIdTextError = true;
        _idFireBaseTextErrorText = "*이메일 형식이 맞지 않습니다.";
      } else if(e.code == "error"){
        if(e.message == "Given String is empty or null"){
          _isFireBaseIdTextError = true;
          _idFireBaseTextErrorText = "*이메일 형식이 맞지 않습니다.";
        }else {
          _isFireBaseIdTextError = true;
          _idFireBaseTextErrorText = e.message;
        }
      } else {
        _isFireBaseIdTextError = true;
        _idFireBaseTextErrorText = e.message;
      }
      return ;
    }
    super.emailIdValid(email);
  }
}
