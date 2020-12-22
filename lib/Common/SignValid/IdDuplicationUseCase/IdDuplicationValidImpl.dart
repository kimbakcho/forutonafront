import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:forutonafront/Common/SignValid/FireBaseValidErrorUtil.dart';
import 'package:forutonafront/Common/SignValid/IdDuplicationUseCase/DuplicationErrorLogin.dart';
import 'package:forutonafront/Common/SignValid/SignValid.dart';
import 'package:forutonafront/AppBis/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthAdapterForUseCase.dart';

class IdDuplicationValidImpl implements SignValid {
  final SignValid _emailValid;
  final FireBaseAuthAdapterForUseCase _fireBaseAuthAdapterForUseCase;
  final DuplicationErrorLogin _duplicationErrorLogin;
  bool _isTextError = false;
  String _errorText = "";
  @override
  bool hasValidTry = false;

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
    hasValidTry = true;
    _isTextError = true;
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
    _isTextError = false;
    return _emailValid.valid(email);
  }
}


