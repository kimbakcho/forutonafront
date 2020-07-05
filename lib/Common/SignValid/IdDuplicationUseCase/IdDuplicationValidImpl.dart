import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:forutonafront/Common/SignValid/FireBaseValidErrorUtil.dart';
import 'package:forutonafront/Common/SignValid/IdDuplicationUseCase/DuplicationErrorLogin.dart';
import 'package:forutonafront/Common/SignValid/SignValid.dart';
import 'package:forutonafront/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthAdapterForUseCase.dart';

class IdDuplicationValidImpl implements SignValid {
  final SignValid _emailValid;
  final FireBaseAuthAdapterForUseCase _fireBaseAuthAdapterForUseCase;
  final DuplicationErrorLogin _duplicationErrorLogin;
  bool _isTextError = false;
  String _errorText = "";

  IdDuplicationValidImpl(
      {@required SignValid emailValid,
      @required FireBaseAuthAdapterForUseCase fireBaseAuthAdapterForUseCase,
      @required DuplicationErrorLogin duplicationErrorLogin
      })
      : _emailValid = emailValid,
        _fireBaseAuthAdapterForUseCase = fireBaseAuthAdapterForUseCase,
        _duplicationErrorLogin = duplicationErrorLogin;

  @override
  String errorText() {
    if(_isTextError){
      return _errorText;
    }
    if(_emailValid.hasError()){
      return _emailValid.errorText();
    }
    return _errorText;
  }

  @override
  bool hasError() {
    return _isTextError || _emailValid.hasError();
  }

  @override
  Future<void> valid(String email) async {
    List<String> list;
    _isTextError = false;
    _errorText = "";
    try {
      list = await _fireBaseAuthAdapterForUseCase
          .fetchSignInMethodsForEmail(email);
      if (!_duplicationErrorLogin.valid(list.length)) {
        _isTextError = true;
        _errorText = _duplicationErrorLogin.errorMessage;
        return;
      }
    } on PlatformException catch (e) {
      FireBaseValidErrorUtil error = FireBaseValidErrorUtil();
      _isTextError = true;
      _errorText = error.getErrorText(e);
      return;
    }
    return _emailValid.valid(email);
  }
}


