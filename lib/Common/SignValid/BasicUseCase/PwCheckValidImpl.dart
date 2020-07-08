
import 'package:forutonafront/Common/SignValid/SignValid.dart';

import 'PwValidImpl.dart';

class PwCheckValidImpl implements SignValid{
  bool _isTextError = false;
  String _errorText = "";
  PwValid _originPwValid;
  @override
  bool hasValidTry = false;

  PwCheckValidImpl(this._originPwValid);

  @override
  String errorText() {
    return _errorText;
  }

  @override
  bool hasError() {
    return _isTextError;
  }

  @override
  Future<void> valid(String checkPw) async {
    hasValidTry = true;
    _isTextError = true;
    _errorText = "";
    if (checkPw.length == 0) {
      _isTextError = false;
      _errorText = "";
      return;
    }
    if (checkPw != _originPwValid.currentPw) {
      _isTextError = true;
      _errorText = "패스워드가 일치 하지 않습니다";
    } else {
      _isTextError = false;
      _errorText = "";
    }
    return;
  }



}