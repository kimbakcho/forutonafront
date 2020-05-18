import 'package:forutonafront/Common/SignValid/SingUp/SignUpValidService.dart';
import 'package:forutonafront/ForutonaUser/Repository/FUserRepository.dart';

class DefaultSignValidImpl extends SignUpValidService with DefaultSignValidMix {


}
mixin DefaultSignValidMix on SignUpValidService {
  bool _isIdTextError = true;
  String _idTextErrorText = "";
  bool _pwTextError = true;
  String _pwTextErrorText = "";
  bool _pwCheckError = true;
  String _pwCheckErrorText = "";
  bool _nickNameError = true;
  String _nickNameErrorText = "";

  @override
  String emailErrorText() {
    return _idTextErrorText;
  }

  @override
  bool hasEmailError() {
    return _isIdTextError;
  }

  @override
  Future<void> emailIdValid(String email) async {
    _isIdTextError = false;
    _idTextErrorText = "";
    if (!_isEmailTypeValid(email)) {
      _isIdTextError = true;
      _idTextErrorText = "*이메일 형식이 맞지 않습니다.";
    } else {
      _isIdTextError = false;
      _idTextErrorText = "";
    }
  }

  @override
  String pwErrorText() {
    return _pwTextErrorText;
  }

  @override
  bool hasPwError() {
    return _pwTextError;
  }

  @override
  void pwValid(String pw) {
    _pwTextError = false;
    _pwTextErrorText = "";
    String value = pw;
    RegExp regExp1 = new RegExp(r'^(?=.*?[A-Z])');
    RegExp regExp2 = new RegExp(r'^(?=.*?[a-z])');
    RegExp regExp3 = new RegExp(r'^(?=.*?[0-9])');
    RegExp regExp4 = new RegExp(r'^(?=.*?[!@#\$&*~])');
    int match1 = regExp1.hasMatch(value) ? 1 : 0;
    int match2 = regExp2.hasMatch(value) ? 1 : 0;
    int match3 = regExp3.hasMatch(value) ? 1 : 0;
    int match4 = regExp4.hasMatch(value) ? 1 : 0;
    if (value.length < 8) {
      _pwTextError = true;
      _pwTextErrorText = "패스워드가 8자리 이하 입니다.";
    } else if (value.length > 16) {
      _pwTextError = true;
      _pwTextErrorText = "패스워드가 16자리 이상 입니다.";
    } else if ((match1 + match2 + match3 + match4) < 3) {
      _pwTextError = true;
      _pwTextErrorText = "영문, 소문자, 대문자, 특수문자 중 3개 이상 조합";
    } else {
      _pwTextError = false;
      _pwTextErrorText =  "";
    }
  }

  @override
  bool hasPwCheckError() {
    return _pwCheckError;
  }

  @override
  String pwCheckErrorText() {
    return _pwCheckErrorText;
  }

  @override
  void pwCheckValid(String pw,String pwCheck) {
    _pwCheckError = false;
    _pwCheckErrorText = "";
    if(pwCheck.length < 8){
      _pwCheckError = true;
      _pwCheckErrorText = "";
      return ;
    }
    if (pw != pwCheck) {
      _pwCheckError = true;
      _pwCheckErrorText = "패스워드가 일치 하지 않습니다";
    } else {
      _pwCheckError = false;
      _pwCheckErrorText = "";
    }
    return ;
  }

  @override
  Future<void> nickNameValid(String nickName) async {
    _nickNameError = false;
    _nickNameErrorText = "";
    if (nickName.length <=2 ) {
      _nickNameError = true;
      _nickNameErrorText = "닉네임은 최소 2글자 이상이어야 합니다.";
      return ;
    }
    RegExp regExp1 = new RegExp(r'^(?=.*?[!@#\$&*~\s])');
    if (regExp1.hasMatch(nickName)) {
      _nickNameError = true;
      _nickNameErrorText = "띄어쓰기와 특수문자는 닉네임에 사용할 수 없습니다.";
      return ;
    }
    FUserRepository _fUserRepository = new FUserRepository();
    var nickNameDuplicationCheckResDto = await _fUserRepository
        .checkNickNameDuplication(nickName);
    if (nickNameDuplicationCheckResDto.haveNickName) {
      _nickNameError = true;
      _nickNameErrorText = "이미 있는 닉네임입니다.";
    } else {
      _nickNameError = false;
      _nickNameErrorText = "";
    }
  }
  @override
  bool hasNickNameError() {
    return _nickNameError;
  }

  @override
  String nickNameErrorText() {
    return _nickNameErrorText;
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
