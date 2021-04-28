import 'package:flutter/cupertino.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/Repository/PhoneAuthRepository.dart';

import 'package:forutonafront/AppBis/ForutonaUser/Dto/PwFindPhoneAuthNumberReqDto.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/PwFindPhoneAuthNumberResDto.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/PwFindPhoneAuthReqDto.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/PwFindPhoneAuthResDto.dart';
import 'package:injectable/injectable.dart';

abstract class PhoneFindValidUseCase {

  Future<PwFindPhoneAuthResDto?> phoneEmailIdValidWithReqPhoneSmsAuth(
      PwFindPhoneAuthReqDto pwFindPhoneAuthReqDto);

  bool hasPhoneEmailError();

  String phoneEmailErrorText();

  PwFindPhoneAuthResDto? getPhoneAuth();

  Future<PwFindPhoneAuthNumberResDto?> phoneAuthNumberValid(
      PwFindPhoneAuthNumberReqDto pwFindPhoneAuthReqDto);

  bool hasPhoneAuthNumberError();

  String phoneAuthNumberErrorText();

  PwFindPhoneAuthNumberResDto? getPwFindPhoneAuthNumber();

}
@Injectable(as: PhoneFindValidUseCase)
class PhoneFindValidUseCaseImpl extends PhoneFindValidUseCase {
  PwFindPhoneAuthResDto? _resPhoneAuth;
  bool _isPhoneEmailError = true;
  String _phoneEmailErrorText = "";
  PwFindPhoneAuthNumberResDto? _authNumber;
  bool _isPhoneAuthNumberError = true;
  String _phoneAuthNumberErrorText = "";


  PhoneAuthRepository _phoneAuthRepository;

  PhoneFindValidUseCaseImpl({required PhoneAuthRepository phoneAuthRepository})
      : _phoneAuthRepository = phoneAuthRepository;

  @override
  Future<PwFindPhoneAuthResDto?> phoneEmailIdValidWithReqPhoneSmsAuth(
      PwFindPhoneAuthReqDto pwFindPhoneAuthReqDto) async {
    _isPhoneEmailError = false;
    _phoneEmailErrorText = "";

    this._resPhoneAuth =
        await _phoneAuthRepository.reqPwFindPhoneAuth(pwFindPhoneAuthReqDto);
    if (_resPhoneAuth!.error!) {
      _isPhoneEmailError = true;
      if (_resPhoneAuth!.cause == "MissMatchEmailAndPhone") {
        _phoneEmailErrorText = "아이디에 저장된 휴대폰 번호와 일치하지 않습니다. \n번호 변경시, 이메일 인증으로 비밀번호를 변경 해주세요.";
      }
    }
    return _resPhoneAuth;
  }

  @override
  Future<PwFindPhoneAuthNumberResDto?> phoneAuthNumberValid(
      PwFindPhoneAuthNumberReqDto pwFindPhoneAuthReqDto) async {
    _isPhoneAuthNumberError = false;
    _phoneAuthNumberErrorText = "";

    this._authNumber =
        await _phoneAuthRepository.reqPwFindNumberAuth(pwFindPhoneAuthReqDto);
    if (_authNumber!.errorFlag!) {
      _isPhoneAuthNumberError = true;
      _phoneAuthNumberErrorText = _authNumber!.errorCause!;
    }
    return this._authNumber;
  }

  @override
  PwFindPhoneAuthNumberResDto? getPwFindPhoneAuthNumber() {
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
  PwFindPhoneAuthResDto? getPhoneAuth() {
    return _resPhoneAuth ;
  }

  @override
  bool hasPhoneEmailError() {
    return _isPhoneEmailError;
  }

  @override
  String phoneEmailErrorText() {
    return _phoneEmailErrorText;
  }

}
