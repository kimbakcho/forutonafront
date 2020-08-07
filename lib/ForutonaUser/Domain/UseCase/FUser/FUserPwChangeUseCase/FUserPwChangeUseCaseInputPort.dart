import 'package:flutter/material.dart';
import 'package:forutonafront/ForutonaUser/Domain/Repository/FUserRepository.dart';

abstract class FUserPwChangeUseCaseInputPort {
  Future<void> pwChange(String pw);
}

class FUserPwChangeUseCase implements FUserPwChangeUseCaseInputPort {
  final FUserRepository _fUserRepository;

  FUserPwChangeUseCase({@required FUserRepository fUserRepository})
      : _fUserRepository = fUserRepository;

  @override
  Future<void> pwChange(String pw) async {
    return await _fUserRepository.pWChange(pw);
  }
}
