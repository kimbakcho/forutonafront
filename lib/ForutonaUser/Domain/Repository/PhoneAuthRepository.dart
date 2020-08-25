import 'package:forutonafront/ForutonaUser/Dto/PhoneAuthNumberResDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/PhoneAuthReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/PhoneAuthNumberReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/PhoneAuthResDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/PwChangeFromPhoneAuthReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/PwChangeFromPhoneAuthResDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/PwFindPhoneAuthNumberReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/PwFindPhoneAuthNumberResDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/PwFindPhoneAuthReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/PwFindPhoneAuthResDto.dart';


abstract class PhoneAuthRepository {

  Future<PhoneAuthResDto> reqPhoneAuth(PhoneAuthReqDto reqDto);

  Future<PwFindPhoneAuthResDto> reqPwFindPhoneAuth(PwFindPhoneAuthReqDto reqDto);

  Future<PhoneAuthNumberResDto> reqNumberAuthReq(PhoneAuthNumberReqDto reqDto);

  Future<PwFindPhoneAuthNumberResDto> reqPwFindNumberAuth(PwFindPhoneAuthNumberReqDto reqDto);

  Future<PwChangeFromPhoneAuthResDto> reqChangePwAuthPhone(PwChangeFromPhoneAuthReqDto reqDto);

}