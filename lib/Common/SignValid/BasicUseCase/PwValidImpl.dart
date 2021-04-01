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
      _errorText = "패스워드는 8~16자리로 설정해주세요.";
    } else if (currentPw.length > 16) {
      _isTextError = true;
      _errorText = "패스워드는 8~16자리로 설정해주세요.";
    } else if ((match1 + match2 + match3 + match4) < 3) {
      _isTextError = true;
      _errorText = "패스워드는 영어 대문자,소문자,숫자,\n특수문자 중 3 종류 이상 조합해 주세요.";
    } else {
      _isTextError = false;
      _errorText = "";
    }
  }

  @override
  String currentPw = "";



}