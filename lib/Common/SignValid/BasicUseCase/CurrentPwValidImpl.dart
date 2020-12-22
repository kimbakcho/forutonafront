import 'package:flutter/cupertino.dart';
import 'package:forutonafront/Common/SignValid/FireBaseValidErrorUtil.dart';
import 'package:forutonafront/Common/SignValid/SignValid.dart';
import 'package:forutonafront/AppBis/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthAdapterForUseCase.dart';

class CurrentPwValidImpl implements SignValid {
  FireBaseAuthAdapterForUseCase _fireBaseAuthAdapterForUseCase;
  @override
  bool hasValidTry = false;

  bool _isTextError = false;
  String _errorText = "";

  CurrentPwValidImpl(
      {@required FireBaseAuthAdapterForUseCase fireBaseAuthAdapterForUseCase})
      : _fireBaseAuthAdapterForUseCase = fireBaseAuthAdapterForUseCase;

  @override
  String errorText() {
    return _errorText;
  }

  @override
  bool hasError() {
    return _isTextError;
  }

  @override
  Future<void> valid(String validText) async {
    hasValidTry =true;
    _isTextError = false;
    _errorText = "";
    try {
      await _fireBaseAuthAdapterForUseCase.signInWithEmailAndPassword(
          await _fireBaseAuthAdapterForUseCase.userEmail(), validText);
    } catch (ex) {
      _isTextError = true;
      _errorText = FireBaseValidErrorUtil().getErrorText(ex);
    }
  }


}
