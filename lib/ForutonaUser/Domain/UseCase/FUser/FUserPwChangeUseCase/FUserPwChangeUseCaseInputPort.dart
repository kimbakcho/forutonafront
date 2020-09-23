import 'package:flutter/material.dart';
import 'package:forutonafront/ForutonaUser/Domain/Repository/FUserRepository.dart';
import 'package:injectable/injectable.dart';

abstract class FUserPwChangeUseCaseInputPort {
  Future<void> pwChange(String pw);
}

@Injectable(as: FUserPwChangeUseCaseInputPort)
class FUserPwChangeUseCase implements FUserPwChangeUseCaseInputPort {
  final FUserRepository _fUserRepository;

  FUserPwChangeUseCase({@required FUserRepository fUserRepository})
      : _fUserRepository = fUserRepository;

  @override
  Future<void> pwChange(String pw) async {
    return await _fUserRepository.pWChange(pw);
  }
}
