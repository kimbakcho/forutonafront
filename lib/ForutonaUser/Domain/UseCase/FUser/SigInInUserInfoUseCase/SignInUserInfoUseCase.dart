import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:forutonafront/ForutonaUser/Data/Entity/FUserInfo.dart';
import 'package:forutonafront/ForutonaUser/Domain/Repository/FUserRepository.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/FUser/SigInInUserInfoUseCase/SignInUserInfoUseCaseInputPort.dart';

import 'SignInUserInfoUseCaseOutputPort.dart';

class SignInUserInfoUseCase implements SignInUserInfoUseCaseInputPort {
  FUserInfo _fUserInfo;
  FUserRepository _fUserRepository;

  @override
  Stream<FUserInfo> fUserInfoStream;

  StreamController _fUserInfoStreamController;
  SignInUserInfoUseCase({@required FUserRepository fUserRepository})
      : _fUserRepository = fUserRepository {
    _fUserInfoStreamController = StreamController<FUserInfo>.broadcast();
    fUserInfoStream = _fUserInfoStreamController.stream;
  }


  @override
  FUserInfo reqSignInUserInfoFromMemory(
      {SignInUserInfoUseCaseOutputPort outputPort}) {
    if (_fUserInfo == null) {
      throw Exception(
          "Don't Have UserInfo in Memory use to saveSignInInfoInMemoryFromAPiServer");
    }
    if (outputPort != null) {
      outputPort.onSignInUserInfoFromMemory(_fUserInfo);
    }
    return _fUserInfo;
  }

  @override
  Future<void> saveSignInInfoInMemoryFromAPiServer(String uid,
      {SignInUserInfoUseCaseOutputPort outputPort}) async {
    _fUserInfo = await _fUserRepository.getForutonaGetMe(uid);
    _fUserInfoStreamController.add(_fUserInfo);
    if (outputPort != null) {
      outputPort.onSignInUserInfoFromMemory(_fUserInfo);
    }
  }

  @override
  void clearUserInfo() {
    _fUserInfo = null;
  }

  void dispose() {
    _fUserInfoStreamController.close();
  }
}
