import 'package:flutter/material.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/Repository/PhoneAuthRepository.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/PhoneAuthNumberReqDto.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/PhoneAuthNumberResDto.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/PhoneAuthReqDto.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/PhoneAuthResDto.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/PwFindPhoneAuthNumberReqDto.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/PwFindPhoneAuthNumberResDto.dart';
import 'package:forutonafront/Components/PhoneAuthComponent/PhoneAuthComponent.dart';
import 'package:injectable/injectable.dart';

abstract class PhoneAuthUseCaseInputPort {
  Future<PhoneAuthResDto> reqPhoneAuth(PhoneAuthReqDto reqDto,{PwAuthFromPhoneUseCaseOutputPort outputPort});
  Future<PhoneAuthNumberResDto> reqNumberAuthReq(PhoneAuthNumberReqDto reqDto, {PwAuthFromPhoneUseCaseOutputPort outputPort});

  Future<PwFindPhoneAuthNumberResDto> reqPwFindNumberAuth(PwFindPhoneAuthNumberReqDto reqDto);
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
  Future<PhoneAuthResDto> reqPhoneAuth(PhoneAuthReqDto reqDto,
      {PwAuthFromPhoneUseCaseOutputPort outputPort}) async {
    outputPort.onPhoneAuth(await _phoneAuthRepository.reqPhoneAuth(reqDto));
  }

  @override
  Future<PhoneAuthNumberResDto> reqNumberAuthReq(PhoneAuthNumberReqDto reqDto,
      {PwAuthFromPhoneUseCaseOutputPort outputPort}) async {
    var phoneAuthNumberResDto = await _phoneAuthRepository.reqNumberAuthReq(reqDto);
    outputPort.onNumberAuthReq(phoneAuthNumberResDto);
    return phoneAuthNumberResDto;
  }

  @override
  Future<PwFindPhoneAuthNumberResDto> reqPwFindNumberAuth(PwFindPhoneAuthNumberReqDto reqDto) async {
    var pwFindPhoneAuthNumberResDto = await _phoneAuthRepository.reqPwFindNumberAuth(reqDto);
    return pwFindPhoneAuthNumberResDto;
  }




}
