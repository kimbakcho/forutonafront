import 'package:flutter/material.dart';
import 'package:forutonafront/ForutonaUser/Domain/Repository/PhoneAuthRepository.dart';
import 'package:forutonafront/ForutonaUser/Dto/PhoneAuthNumberReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/PhoneAuthNumberResDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/PhoneAuthReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/PhoneAuthResDto.dart';

abstract class PhoneAuthUseCaseInputPort {
  Future<void> reqPhoneAuth(PhoneAuthReqDto reqDto,{PwAuthFromPhoneUseCaseOutputPort outputPort});
  Future<void> reqNumberAuthReq(PhoneAuthNumberReqDto reqDto, {PwAuthFromPhoneUseCaseOutputPort outputPort});
}

abstract class PwAuthFromPhoneUseCaseOutputPort {
  void onPhoneAuth(PhoneAuthResDto resDto);

  void onNumberAuthReq(PhoneAuthNumberResDto phoneAuthNumberResDto);
}

class PhoneAuthUseCase implements PhoneAuthUseCaseInputPort {
  PhoneAuthRepository _phoneAuthRepository;

  PhoneAuthUseCase({@required PhoneAuthRepository phoneAuthRepository})
      : _phoneAuthRepository = phoneAuthRepository;

  @override
  Future<void> reqPhoneAuth(PhoneAuthReqDto reqDto,
      {PwAuthFromPhoneUseCaseOutputPort outputPort}) async {
    outputPort.onPhoneAuth(await _phoneAuthRepository.reqPhoneAuth(reqDto));
  }

  @override
  Future<void> reqNumberAuthReq(PhoneAuthNumberReqDto reqDto,
      {PwAuthFromPhoneUseCaseOutputPort outputPort}) async {
    outputPort.onNumberAuthReq(await _phoneAuthRepository.reqNumberAuthReq(reqDto));
  }

}
