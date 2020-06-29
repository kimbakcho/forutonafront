import 'package:flutter/cupertino.dart';
import 'package:forutonafront/ForutonaUser/Data/Value/PwChangeFromPhoneAuth.dart';
import 'package:forutonafront/ForutonaUser/Data/Value/PwFindPhoneAuth.dart';
import 'package:forutonafront/ForutonaUser/Data/Value/PwFindPhoneAuthNumber.dart';
import 'package:forutonafront/ForutonaUser/Domain/Repository/PhoneAuthRepository.dart';
import 'package:forutonafront/ForutonaUser/Dto/PwChangeFromPhoneAuthReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/PwChangeFromPhoneAuthResDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/PwFindPhoneAuthNumberReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/PwFindPhoneAuthNumberResDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/PwFindPhoneAuthReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/PwFindPhoneAuthResDto.dart';


abstract class PhoneFindValidUseCase {

  Future<void> phoneEmailIdValidWithReqPhoneSmsAuth(
      PwFindPhoneAuthReqDto pwFindPhoneAuthReqDto);

  bool hasPhoneEmailError();

  String phoneEmailErrorText();

  PwFindPhoneAuth getPhoneAuth();

  Future<void> phoneAuthNumberValid(
      PwFindPhoneAuthNumberReqDto pwFindPhoneAuthReqDto);

  bool hasPhoneAuthNumberError();

  String phoneAuthNumberErrorText();

  PwFindPhoneAuthNumber getPwFindPhoneAuthNumber();

  Future<void> phonePwChangeWithValid(PwChangeFromPhoneAuthReqDto reqDto);

  bool hasPhonePwChangeError();

  String phonePwChangeErrorText();
}

class PhoneFindValidUseCaseImpl extends PhoneFindValidUseCase {
  PwFindPhoneAuth _resPhoneAuth;
  bool _isPhoneEmailError = true;
  String _phoneEmailErrorText = "";
  PwFindPhoneAuthNumber _authNumber;
  bool _isPhoneAuthNumberError = true;
  String _phoneAuthNumberErrorText = "";
  bool _isPhonePwChangeError = true;
  String _phonePwChangeErrorText = "";

  PhoneAuthRepository _phoneAuthRepository;

  PhoneFindValidUseCaseImpl({@required PhoneAuthRepository phoneAuthRepository})
      : _phoneAuthRepository = phoneAuthRepository;

  @override
  Future<void> phoneEmailIdValidWithReqPhoneSmsAuth(
      PwFindPhoneAuthReqDto pwFindPhoneAuthReqDto) async {
    _isPhoneEmailError = false;
    _phoneEmailErrorText = "";

    this._resPhoneAuth =
        await _phoneAuthRepository.reqPwFindPhoneAuth(pwFindPhoneAuthReqDto);
    if (_resPhoneAuth.error) {
      _isPhoneEmailError = true;
      if (_resPhoneAuth.cause == "MissMatchEmailAndPhone") {
        _phoneEmailErrorText = "입력하신 정보와 일치하는 계정이 없습니다.\n"
            "휴대폰 번호를 변경하셨다면, 이메일 인증으로 패스워드를 찾아주세요.";
      }
      return;
    } else {
      return;
    }
  }

  @override
  Future<void> phoneAuthNumberValid(
      PwFindPhoneAuthNumberReqDto pwFindPhoneAuthReqDto) async {
    _isPhoneAuthNumberError = false;
    _phoneAuthNumberErrorText = "";

    this._authNumber =
        await _phoneAuthRepository.reqPwFindNumberAuth(pwFindPhoneAuthReqDto);
    if (_authNumber.errorFlag) {
      _isPhoneAuthNumberError = true;
      _phoneAuthNumberErrorText = _authNumber.errorCause;
    }
  }

  @override
  PwFindPhoneAuthNumber getPwFindPhoneAuthNumber() {
    return _authNumber;
  }

  @override
  bool hasPhoneAuthNumberError() {
    return _isPhoneAuthNumberError;
  }

  @override
  String phoneAuthNumberErrorText() {
    return _phoneAuthNumberErrorText;
  }

  @override
  PwFindPhoneAuth getPhoneAuth() {
    return _resPhoneAuth;
  }

  @override
  bool hasPhoneEmailError() {
    return _isPhoneEmailError;
  }

  @override
  String phoneEmailErrorText() {
    return _phoneEmailErrorText;
  }

  Future<void> phonePwChangeWithValid(
      PwChangeFromPhoneAuthReqDto reqDto) async {
    _isPhonePwChangeError = false;
    _phonePwChangeErrorText = "";
    PwChangeFromPhoneAuth pwChangeFromPhoneAuthResDto =
        await _phoneAuthRepository.reqChangePwAuthPhone(reqDto);
    if (pwChangeFromPhoneAuthResDto.errorFlag) {
      _isPhonePwChangeError = true;
      _phonePwChangeErrorText = pwChangeFromPhoneAuthResDto.cause;
    }
  }

  bool hasPhonePwChangeError() {
    return _isPhonePwChangeError;
  }

  String phonePwChangeErrorText() {
    return _phonePwChangeErrorText;
  }
}
