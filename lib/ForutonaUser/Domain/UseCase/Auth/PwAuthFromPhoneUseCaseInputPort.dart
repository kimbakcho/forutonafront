import 'package:forutonafront/ForutonaUser/Data/Value/PhoneAuth.dart';
import 'package:forutonafront/ForutonaUser/Dto/PhoneAuthNumberReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/PhoneAuthReqDto.dart';


import 'PwAuthFromPhoneUseCaseOutputPort.dart';

abstract class PwAuthFromPhoneUseCaseInputPort {
  Future<void> reqPhoneAuth(PhoneAuthReqDto reqDto,{PwAuthFromPhoneUseCaseOutputPort outputPort});

  Future<void> reqNumberAuthReq(PhoneAuthNumberReqDto reqDto, {PwAuthFromPhoneUseCaseOutputPort outputPort});
}