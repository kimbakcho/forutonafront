import 'package:flutter/cupertino.dart';
import 'package:forutonafront/ForutonaUser/Domain/Repository/FUserRepository.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/FUser/UserInfoUpdateUseCase/UserInfoUpdateUseCaeInputPort.dart';
import 'package:forutonafront/ForutonaUser/Dto/FuserAccountUpdateReqdto.dart';

class UserInfoUpdateUseCase implements UserInfoUpdateUseCaeInputPort {
  FUserRepository _fUserRepository;

  UserInfoUpdateUseCase({@required FUserRepository fUserRepository})
      : _fUserRepository = fUserRepository;

  @override
  Future<int> updateAccountUserInfo(FuserAccountUpdateReqdto reqDto) async {
    return await _fUserRepository.updateAccountUserInfo(reqDto);
  }

}
