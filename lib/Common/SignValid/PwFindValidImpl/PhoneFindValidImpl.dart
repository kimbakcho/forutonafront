import 'package:forutonafront/Common/SignValid/PwFindValid/PhoneFindValidService.dart';
import 'package:forutonafront/Common/SignValid/SingUpImpl/DefaultSignValidUseCase.dart';
import 'package:forutonafront/ForutonaUser/Dto/PwChangeFromPhoneAuthReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/PwChangeFromPhoneAuthResDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/PwFindPhoneAuthNumberReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/PwFindPhoneAuthNumberResDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/PwFindPhoneAuthReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/PwFindPhoneAuthResDto.dart';
import 'package:forutonafront/ForutonaUser/Repository/PhoneAuthRepository.dart';
import 'PwFindValidImpl.dart';

class PhoneFindValidImpl extends PhoneFindValidService with DefaultSignValidUseCaseMix,DefaultPwFindValidMix,PhoneFindValidMix{


}
mixin PhoneFindValidMix on PhoneFindValidService {
  PwFindPhoneAuthResDto _resPhoneAuth;
  bool _isPhoneEmailError = true;
  String _phoneEmailErrorText = "";
  PwFindPhoneAuthNumberResDto _authNumberResDto;
  bool _isPhoneAuthNumberError = true;
  String _phoneAuthNumberErrorText = "";
  bool _isPhonePwChangeError = true;
  String _phonePwChangeErrorText = "";

  @override
  Future<void> phoneEmailIdValidWithReqPhoneSmsAuth(PwFindPhoneAuthReqDto pwFindPhoneAuthReqDto) async {
    _isPhoneEmailError = false;
    _phoneEmailErrorText = "";
    PhoneAuthRepository _phoneAuthRepository = new PhoneAuthRepository();
    this._resPhoneAuth = await _phoneAuthRepository.reqPwFindPhoneAuth(pwFindPhoneAuthReqDto);
    if(_resPhoneAuth.error) {
      _isPhoneEmailError = true;
      if (_resPhoneAuth.cause == "MissMatchEmailAndPhone") {
        _phoneEmailErrorText = "입력하신 정보와 일치하는 계정이 없습니다.\n"
            "휴대폰 번호를 변경하셨다면, 이메일 인증으로 패스워드를 찾아주세요.";
      }
      return ;
    }else {
      return ;
    }
  }
  @override
  Future<void> phoneAuthNumberValid(PwFindPhoneAuthNumberReqDto pwFindPhoneAuthReqDto)async {
     _isPhoneAuthNumberError = false;
     _phoneAuthNumberErrorText = "";
     PhoneAuthRepository _phoneAuthRepository = new PhoneAuthRepository();
     this._authNumberResDto = await _phoneAuthRepository.reqPwFindNumberAuth(pwFindPhoneAuthReqDto);
     if(_authNumberResDto.errorFlag){
       _isPhoneAuthNumberError = true;
       _phoneAuthNumberErrorText = _authNumberResDto.errorCause;
     }
  }
  @override
  PwFindPhoneAuthNumberResDto getPwFindPhoneAuthNumberResDto(){
    return _authNumberResDto;
  }

  @override
  bool hasPhoneAuthNumberError(){
    return _isPhoneAuthNumberError;
  }
  @override
  String phoneAuthNumberErrorText(){
    return _phoneAuthNumberErrorText;
  }

  @override
  PwFindPhoneAuthResDto getPhoneAuth(){
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

  Future<void> phonePwChangeWithValid(PwChangeFromPhoneAuthReqDto reqDto) async {
    _isPhonePwChangeError = false;
    _phonePwChangeErrorText = "";
    PhoneAuthRepository _phoneAuthRepository = PhoneAuthRepository();
    PwChangeFromPhoneAuthResDto pwChangeFromPhoneAuthResDto =   await _phoneAuthRepository.reqChangePwAuthPhone(reqDto);
    if(pwChangeFromPhoneAuthResDto.errorFlag){
      _isPhonePwChangeError = true;
      _phonePwChangeErrorText = pwChangeFromPhoneAuthResDto.cause;
    }
  }

  bool hasPhonePwChangeError(){
    return _isPhonePwChangeError;
  }
  String phonePwChangeErrorText(){
    return _phonePwChangeErrorText;
  }

}