import 'package:forutonafront/Common/SignValid/SingUp/SignUpValidService.dart';
import 'package:forutonafront/ForutonaUser/Dto/PwChangeFromPhoneAuthReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/PwFindPhoneAuthNumberReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/PwFindPhoneAuthNumberResDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/PwFindPhoneAuthReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/PwFindPhoneAuthResDto.dart';


abstract class PhoneFindValidService extends SignUpValidService {
  Future<void> phoneEmailIdValid(PwFindPhoneAuthReqDto pwFindPhoneAuthReqDto);
  bool hasPhoneEmailError();
  String phoneEmailErrorText();
  PwFindPhoneAuthResDto getPhoneAuth();
  Future<void> phoneAuthNumberValid(PwFindPhoneAuthNumberReqDto pwFindPhoneAuthReqDto);
  bool hasPhoneAuthNumberError();
  String phoneAuthNumberErrorText();
  PwFindPhoneAuthNumberResDto getPwFindPhoneAuthNumberResDto();
  Future<void> phonePwChangeWithValid(PwChangeFromPhoneAuthReqDto reqDto);
  bool hasPhonePwChangeError();
  String phonePwChangeErrorText();

}