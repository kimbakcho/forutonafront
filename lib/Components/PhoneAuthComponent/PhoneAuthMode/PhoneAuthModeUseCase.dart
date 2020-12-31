import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/PhoneAuthUseCase/PhoneAuthUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/PhoneAuthNumberReqDto.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/PhoneAuthReqDto.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/PwFindPhoneAuthNumberReqDto.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/PwFindPhoneAuthNumberResDto.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/PwFindPhoneAuthReqDto.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/PwFindPhoneAuthResDto.dart';
import 'package:forutonafront/Common/Country/CountryItem.dart';
import 'package:forutonafront/Common/SignValid/PhonePwFindValidUseCase/PhoneFindValidUseCase.dart';
import 'package:forutonafront/Components/PhoneAuthComponent/PhoneAuthComponent.dart';
import 'package:sms_otp_auto_verify/sms_otp_auto_verify.dart';

enum PhoneAuthMode {
  SignIn,
  PhonePwFind
}

abstract class PhoneAuthModeUseCase {
  checkAuthCheckNumber();
  sendAuthSms();
}

class SignPhoneAuthModeUseCase implements PhoneAuthModeUseCase {

  final PhoneAuthUseCaseInputPort phoneAuthUseCaseInputPort;

  final PhoneAuthComponentController phoneAuthComponentController;

  SignPhoneAuthModeUseCase(this.phoneAuthUseCaseInputPort,this.phoneAuthComponentController);

  @override
  checkAuthCheckNumber() async {
    PhoneAuthNumberReqDto reqDto = PhoneAuthNumberReqDto();
    var countrySelectItem = phoneAuthComponentController.getCountrySelectItem();
    reqDto.internationalizedDialCode = countrySelectItem.dialCode;
    reqDto.phoneNumber = phoneAuthComponentController.getPhoneNumber();
    reqDto.isoCode = countrySelectItem.code;
    reqDto.authNumber = phoneAuthComponentController.getAuthNumber();
    var phoneAuthNumberResDto = await phoneAuthUseCaseInputPort.reqNumberAuthReq(reqDto);
    phoneAuthComponentController.resNumberAuthReq(phoneAuthNumberResDto);
  }

  @override
  sendAuthSms() async {
    var countrySelectItem = phoneAuthComponentController.getCountrySelectItem();
    PhoneAuthReqDto reqDto = PhoneAuthReqDto();
    reqDto.isoCode = countrySelectItem.code;
    reqDto.phoneNumber = phoneAuthComponentController.getPhoneNumber();
    reqDto.internationalizedDialCode = countrySelectItem.dialCode;
    phoneAuthComponentController.waitSmsRetrieved();
    var phoneAuthResDto = await phoneAuthUseCaseInputPort.reqPhoneAuth(reqDto);
    phoneAuthComponentController.resPhoneAuth(phoneAuthResDto);
  }



}


class PwFindAuthModeUseCase extends PhoneAuthModeUseCase {

  final PhoneAuthUseCaseInputPort phoneAuthUseCaseInputPort;

  final PhoneAuthComponentController phoneAuthComponentController;

  final PhoneFindValidUseCase phoneFindValidUseCase;

  final String email;

  PwFindAuthModeUseCase(this.phoneAuthUseCaseInputPort, this.phoneAuthComponentController,this.email, this.phoneFindValidUseCase);

  @override
  checkAuthCheckNumber() async {
    var countrySelectItem = phoneAuthComponentController.getCountrySelectItem();
    PwFindPhoneAuthNumberReqDto pwFindPhoneAuthNumberReqDto = PwFindPhoneAuthNumberReqDto();
    pwFindPhoneAuthNumberReqDto.isoCode = countrySelectItem.code;
    pwFindPhoneAuthNumberReqDto.phoneNumber = phoneAuthComponentController.getPhoneNumber();
    pwFindPhoneAuthNumberReqDto.internationalizedDialCode = countrySelectItem.dialCode;
    pwFindPhoneAuthNumberReqDto.email = email;
    pwFindPhoneAuthNumberReqDto.authNumber = phoneAuthComponentController.getAuthNumber();
    var pwFindPhoneAuthNumberResDto = await phoneFindValidUseCase.phoneAuthNumberValid(pwFindPhoneAuthNumberReqDto);
    phoneAuthComponentController.resNumberAuthReq(pwFindPhoneAuthNumberResDto);
  }

  @override
  sendAuthSms() async {
    var countrySelectItem = phoneAuthComponentController.getCountrySelectItem();
    PwFindPhoneAuthReqDto reqDto = PwFindPhoneAuthReqDto();
    reqDto.isoCode = countrySelectItem.code;
    reqDto.phoneNumber = phoneAuthComponentController.getPhoneNumber();
    reqDto.internationalizedDialCode = countrySelectItem.dialCode;
    reqDto.email = email;
    phoneAuthComponentController.waitSmsRetrieved();
    PwFindPhoneAuthResDto pwFindPhoneAuthResDto = await phoneFindValidUseCase.phoneEmailIdValidWithReqPhoneSmsAuth(reqDto);
    if(phoneFindValidUseCase.hasPhoneEmailError()){
      phoneAuthComponentController.setPhoneError(phoneFindValidUseCase.phoneEmailErrorText());
    }else {
      phoneAuthComponentController.phoneErrorClear();
      phoneAuthComponentController.resPhoneAuth(pwFindPhoneAuthResDto);
    }
  }



}