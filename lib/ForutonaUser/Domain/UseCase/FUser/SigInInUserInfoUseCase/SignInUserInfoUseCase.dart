import 'package:flutter/cupertino.dart';
import 'package:forutonafront/ForutonaUser/Data/Entity/FUserInfo.dart';
import 'package:forutonafront/ForutonaUser/Domain/Repository/FUserRepository.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/FUser/SigInInUserInfoUseCase/SignInUserInfoUseCaseInputPort.dart';

import 'SignInUserInfoUseCaseOutputPort.dart';

class SignInUserInfoUseCase implements SignInUserInfoUseCaseInputPort {
  FUserInfo _fUserInfo;
  FUserRepository _fUserRepository;


  SignInUserInfoUseCase({@required FUserRepository fUserRepository})
      : _fUserRepository = fUserRepository;

  @override
  FUserInfo reqSignInUserInfoFromMemory(
      SignInUserInfoUseCaseOutputPort outputPort) {
    if(_fUserInfo == null){
      throw  Exception("Don't Have UserInfo in Memory use to saveSignInInfoInMemoryFromAPiServer");
    }
    outputPort.onSignInUserInfoFromMemory(_fUserInfo);
    return _fUserInfo;
  }

  @override
  Future<void> saveSignInInfoInMemoryFromAPiServer(String uid) async {
    _fUserInfo = await _fUserRepository.getForutonaGetMe(uid);
  }
}
