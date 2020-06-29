import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:forutonafront/Common/SignValid/FireBaseValidErrorUtil.dart';
import 'package:forutonafront/Common/SignValid/SignValid.dart';
import 'package:forutonafront/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthAdapterForUseCase.dart';

class IdDuplicationValidImpl implements SignValid {

  SignValid _emailValid;
  FireBaseAuthAdapterForUseCase _fireBaseAuthAdapterForUseCase;
  bool _isTextError = false;
  String _duplicationMessage;
  String _errorText = "";

  IdDuplicationValidImpl({@required SignValid emailValid,
    @required FireBaseAuthAdapterForUseCase fireBaseAuthAdapterForUseCase,@required duplicationMessage})
      :_emailValid = emailValid,_fireBaseAuthAdapterForUseCase = fireBaseAuthAdapterForUseCase,_duplicationMessage=duplicationMessage;

  @override
  String errorText() {
    return _errorText;
  }

  @override
  bool hasError() {
    return _isTextError;
  }

  @override
  Future<void> valid(String email) async {
    List<String> list;
    _isTextError = false;
    _errorText = "";
    try{
      list =
          await _fireBaseAuthAdapterForUseCase.fetchSignInMethodsForEmail(email);
      if(list.length>0){
        _isTextError = true;
        _errorText = "해당 아이디로 가입되어 있습니다.";
        return ;
      }
    } on PlatformException catch (e) {
      FireBaseValidErrorUtil error = FireBaseValidErrorUtil();
      _isTextError = true;
      _errorText = error.getErrorText(e);
      return ;
    }
    return _emailValid.valid(email);
  }


}