import 'package:forutonafront/Common/SignValid/SignValid.dart';

abstract class PwValid extends SignValid {
  String currentPw;
}

class PwValidImpl implements PwValid {

  bool _isTextError = false;
  String _errorText = "";


  @override
  bool hasValidTry = false;

  @override
  String errorText() {

    return _errorText;
  }

  @override
  bool hasError() {
    return _isTextError;
  }


  @override
  Future<void> valid(String pw) async{
    hasValidTry= true;
    _isTextError = true;
    currentPw = pw;
    _errorText = "";
    RegExp regExp1 = new RegExp(r'^(?=.*?[A-Z])');
    RegExp regExp2 = new RegExp(r'^(?=.*?[a-z])');
    RegExp regExp3 = new RegExp(r'^(?=.*?[0-9])');
    RegExp regExp4 = new RegExp(r'^(?=.*?[!@#\$&*~])');
    int match1 = regExp1.hasMatch(currentPw) ? 1 : 0;
    int match2 = regExp2.hasMatch(currentPw) ? 1 : 0;
    int match3 = regExp3.hasMatch(currentPw) ? 1 : 0;
    int match4 = regExp4.hasMatch(currentPw) ? 1 : 0;
    if (currentPw.length < 8) {
      _isTextError = true;
      _errorText = "패스워드가 8자리 이하 입니다.";
    } else if (currentPw.length > 16) {
      _isTextError = true;
      _errorText = "패스워드가 16자리 이상 입니다.";
    } else if ((match1 + match2 + match3 + match4) < 3) {
      _isTextError = true;
      _errorText = "영문, 소문자, 대문자, 특수문자 중 3개 이상 조합";
    } else {
      _isTextError = false;
      _errorText = "";
    }
  }

  @override
  String currentPw = "";



}