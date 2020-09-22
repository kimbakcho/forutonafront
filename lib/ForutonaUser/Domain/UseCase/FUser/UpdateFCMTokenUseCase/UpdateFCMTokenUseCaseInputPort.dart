import 'package:flutter/material.dart';
import 'package:forutonafront/ForutonaUser/Domain/Repository/FUserRepository.dart';
import 'package:injectable/injectable.dart';

abstract class UpdateFCMTokenUseCaseInputPort {
  Future<void> updateFCMToken(String token);
}
@Injectable(as: UpdateFCMTokenUseCaseInputPort)
class UpdateFCMTokenUseCase implements UpdateFCMTokenUseCaseInputPort{

  final FUserRepository _fUserRepository;

  UpdateFCMTokenUseCase({@required FUserRepository fUserRepository})
      : _fUserRepository = fUserRepository;

  @override
  Future<void> updateFCMToken(String token) async {
    return await _fUserRepository.updateFireBaseMessageToken(token);
  }

}