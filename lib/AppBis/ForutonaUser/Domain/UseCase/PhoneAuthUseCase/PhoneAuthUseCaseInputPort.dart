import 'package:flutter/material.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/Repository/PhoneAuthRepository.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/PhoneAuthNumberReqDto.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/PhoneAuthNumberResDto.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/PhoneAuthReqDto.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/PhoneAuthResDto.dart';
import 'package:injectable/injectable.dart';

abstract class PhoneAuthUseCaseInputPort {
  Future<void> reqPhoneAuth(PhoneAuthReqDto reqDto,{PwAuthFromPhoneUseCaseOutputPort outputPort});
  Future<void> reqNumberAuthReq(PhoneAuthNumberReqDto reqDto, {PwAuthFromPhoneUseCaseOutputPort outputPort});
}

abstract class PwAuthFromPhoneUseCaseOutputPort {
  void onPhoneAuth(PhoneAuthResDto resDto);

  void onNumberAuthReq(PhoneAuthNumberResDto phoneAuthNumberResDto);
}
@LazySingleton(as: PhoneAuthUseCaseInputPort)
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
