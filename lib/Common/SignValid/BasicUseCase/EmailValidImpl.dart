import 'package:forutonafront/Common/SignValid/SignValid.dart';

class EmailValidImpl implements SignValid{
  bool _isTextError = false;
  String _errorText = "";

  @override
  String errorText() {
    return _errorText;
  }

  @override
  bool hasError() {
    return _isTextError;
  }

  @override
  Future<void> valid(String email,{String optionValidText}) async {
     _isTextError = false;
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
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(emailId))
      return false;
    else
      return true;
  }


}