
import 'package:flutter/material.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/Repository/PhoneAuthRepository.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/PwChangeFromPhoneAuthReqDto.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/PwChangeFromPhoneAuthResDto.dart';
import 'package:injectable/injectable.dart';

abstract class PwFindPhoneUseCaseInputPort {
  Future<PwChangeFromPhoneAuthResDto> phonePwChange(PwChangeFromPhoneAuthReqDto reqDto);
}

@LazySingleton(as: PwFindPhoneUseCaseInputPort)
class PwFindPhoneUseCase implements PwFindPhoneUseCaseInputPort {

  PhoneAuthRepository _phoneAuthRepository;

  PwFindPhoneUseCase({required PhoneAuthRepository phoneAuthRepository})
      : _phoneAuthRepository = phoneAuthRepository;

  Future<PwChangeFromPhoneAuthResDto> phonePwChange(PwChangeFromPhoneAuthReqDto reqDto) async {
    PwChangeFromPhoneAuthResDto pwChangeFromPhoneAuthResDto =
    await _phoneAuthRepository.reqChangePwAuthPhone(reqDto);
    return pwChangeFromPhoneAuthResDto;
  }
}
