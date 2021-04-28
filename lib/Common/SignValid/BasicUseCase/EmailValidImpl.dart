import 'package:forutonafront/Common/SignValid/SignValid.dart';

class EmailValidImpl implements SignValid {
  bool _isTextError = false;
  String _errorText = "";

  @override
  bool? hasValidTry = false;

  @override
  String errorText() {
    return _errorText;
  }

  @override
  bool hasError() {
    return _isTextError;
  }

  @override
  Future<void> valid(String email, {String? optionValidText}) async {
    hasValidTry = true;
    _isTextError = true;
    _errorText = "";
    if (!_isEmailTypeValid(email)) {
      _isTextError = true;
      _errorText = "*이메일 형식이 맞지 않습니다.";
    } else {
      _isTextError = false;
      _errorText = "";
    }
  }

  bool _isEmailTypeValid(String emailId) {
    RegExp regex = new RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    if (!regex.hasMatch(emailId))
      return false;
    else
      return true;
  }
}
