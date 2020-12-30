import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/PhoneAuthUseCase/PhoneAuthUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/PhoneAuthReqDto.dart';
import 'package:forutonafront/Common/Country/CountryItem.dart';
import 'package:sms_otp_auto_verify/sms_otp_auto_verify.dart';

abstract class PhoneAuthMode {
  Function(String) addListenWriteAuthCode;
  sendAuthSms(CountryItem countryItem);
  checkAuthCheckNumber();
  waitSmsRetrieved() async {
    var authCode = await SmsRetrieved.startListeningSms();
    var indexOf = authCode.indexOf("인증번호:");
    var indexOf2 = authCode.indexOf("]", indexOf);
    var authNumber = authCode.substring(indexOf + 5, indexOf2);
    addListenWriteAuthCode(authNumber);
  }
}

class SignPhoneAuthMode extends PhoneAuthMode {

  final PhoneAuthUseCaseInputPort phoneAuthUseCaseInputPort;

  SignPhoneAuthMode(this.phoneAuthUseCaseInputPort);

  @override
  checkAuthCheckNumber() {

  }

  @override
  sendAuthSms(CountryItem countryItem,String phoneNumber) async {
    PhoneAuthReqDto reqDto = PhoneAuthReqDto();
    reqDto.isoCode = countryItem.code;
    reqDto.phoneNumber = phoneNumber;
    reqDto.internationalizedDialCode = countryItem.dialCode;
    waitSmsRetrieved();
    await phoneAuthUseCaseInputPort.reqPhoneAuth(reqDto, outputPort: this);
  }

}
