import 'package:flutter/material.dart';
import 'package:forutonafront/ForutonaUser/Domain/Repository/FUserRepository.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/FUser/UserPasswordChangeUseCase/UserPasswordChangeUseCaseInputPort.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserInfoPwChangeReqDto.dart';

class UserPasswordChangeUseCase implements UserPasswordChangeUseCaseInputPort {
  FUserRepository _fUserRepository;

  UserPasswordChangeUseCase({@required FUserRepository fUserRepository})
      : _fUserRepository = fUserRepository;

  @override
  Future<int> pwChange(FUserInfoPwChangeReqDto reqDto) async {
    return await _fUserRepository.pWChange(reqDto);
  }
}
