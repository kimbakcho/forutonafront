import 'package:flutter/cupertino.dart';
import 'package:forutonafront/ForutonaUser/Domain/Repository/PhoneAuthRepository.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/Auth/PwAuthFromPhoneUseCaseOutputPort.dart';
import 'package:forutonafront/ForutonaUser/Dto/PhoneAuthNumberReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/PhoneAuthNumberResDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/PhoneAuthReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/PhoneAuthResDto.dart';

import 'PwAuthFromPhoneUseCaseInputPort.dart';

class PwAuthFromPhoneUseCase implements PwAuthFromPhoneUseCaseInputPort {
  PhoneAuthRepository _phoneAuthRepository;

  PwAuthFromPhoneUseCase({@required PhoneAuthRepository phoneAuthRepository})
      : _phoneAuthRepository = phoneAuthRepository;

  @override
  Future<void> reqPhoneAuth(PhoneAuthReqDto reqDto,
      {PwAuthFromPhoneUseCaseOutputPort outputPort}) async {
    outputPort.onPhoneAuth(PhoneAuthResDto.fromPhoneAuth(
        await _phoneAuthRepository.reqPhoneAuth(reqDto)));
  }

  @override
  Future<void> reqNumberAuthReq(PhoneAuthNumberReqDto reqDto,
      {PwAuthFromPhoneUseCaseOutputPort outputPort}) async {
    outputPort.onNumberAuthReq(PhoneAuthNumberResDto.fromPhoneAuthNumber(
        await _phoneAuthRepository.reqNumberAuthReq(reqDto)));
  }
}
