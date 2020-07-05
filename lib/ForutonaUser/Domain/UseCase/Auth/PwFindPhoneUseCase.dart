import 'package:flutter/cupertino.dart';
import 'package:forutonafront/ForutonaUser/Data/Value/PwChangeFromPhoneAuth.dart';
import 'package:forutonafront/ForutonaUser/Domain/Repository/PhoneAuthRepository.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/Auth/PwFindPhoneUseCaseInputPort.dart';
import 'package:forutonafront/ForutonaUser/Dto/PwChangeFromPhoneAuthReqDto.dart';

import 'PwFindPhoneUseCaseOutputPort.dart';

class PwFindPhoneUseCase implements PwFindPhoneUseCaseInputPort {
  @override
  String email;

  @override
  String emailPhoneAuthToken;

  @override
  String internationalizedPhoneNumber;

  @override
  String password;

  PhoneAuthRepository _phoneAuthRepository;

  PwFindPhoneUseCase({@required PhoneAuthRepository phoneAuthRepository})
      : _phoneAuthRepository = phoneAuthRepository;

  Future<void> phonePwChange({PwFindPhoneUseCaseOutputPort outputPort}) async {
    PwChangeFromPhoneAuthReqDto reqDto = PwChangeFromPhoneAuthReqDto();
    reqDto.emailPhoneAuthToken = emailPhoneAuthToken;
    reqDto.email = email;
    reqDto.password = password;
    reqDto.internationalizedPhoneNumber = internationalizedPhoneNumber;
    PwChangeFromPhoneAuth pwChangeFromPhoneAuthResDto =
        await _phoneAuthRepository.reqChangePwAuthPhone(reqDto);
    outputPort.onPhonePwChange(pwChangeFromPhoneAuthResDto);
  }
}
