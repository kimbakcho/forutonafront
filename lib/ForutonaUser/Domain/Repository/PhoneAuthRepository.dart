import 'package:forutonafront/Common/FDio.dart';
import 'package:forutonafront/ForutonaUser/Data/Value/PhoneAuth.dart';
import 'package:forutonafront/ForutonaUser/Data/Value/PhoneAuthNumber.dart';
import 'package:forutonafront/ForutonaUser/Data/Value/PwChangeFromPhoneAuth.dart';
import 'package:forutonafront/ForutonaUser/Data/Value/PwFindPhoneAuth.dart';
import 'package:forutonafront/ForutonaUser/Data/Value/PwFindPhoneAuthNumber.dart';
import 'package:forutonafront/ForutonaUser/Dto/PhoneAuthReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/PhoneAuthResDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/PhoneAuthNumberReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/PhoneAuthNumberResDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/PwChangeFromPhoneAuthReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/PwChangeFromPhoneAuthResDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/PwFindPhoneAuthNumberReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/PwFindPhoneAuthNumberResDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/PwFindPhoneAuthReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/PwFindPhoneAuthResDto.dart';

abstract class PhoneAuthRepository {

  Future<PhoneAuth> reqPhoneAuth(PhoneAuthReqDto reqDto);

  Future<PwFindPhoneAuth> reqPwFindPhoneAuth(PwFindPhoneAuthReqDto reqDto);

  Future<PhoneAuthNumber> reqNumberAuthReq(PhoneAuthNumberReqDto reqDto);

  Future<PwFindPhoneAuthNumber> reqPwFindNumberAuth(PwFindPhoneAuthNumberReqDto reqDto);

  Future<PwChangeFromPhoneAuth> reqChangePwAuthPhone(PwChangeFromPhoneAuthReqDto reqDto);

}