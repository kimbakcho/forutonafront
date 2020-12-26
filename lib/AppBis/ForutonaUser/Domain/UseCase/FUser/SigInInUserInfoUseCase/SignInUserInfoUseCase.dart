import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/Entity/FUserInfo.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/Repository/FUserRepository.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/FUser/SigInInUserInfoUseCase/SignInUserInfoUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/FUserInfoResDto.dart';
import 'package:injectable/injectable.dart';

import 'SignInUserInfoUseCaseOutputPort.dart';
@LazySingleton(as: SignInUserInfoUseCaseInputPort)
class SignInUserInfoUseCase implements SignInUserInfoUseCaseInputPort {
  FUserInfoResDto _fUserInfo;
  FUserRepository _fUserRepository;
  bool isLogin = false;

  @override
  Stream<FUserInfoResDto> fUserInfoStream;

  StreamController _fUserInfoStreamController;
  SignInUserInfoUseCase({@required FUserRepository fUserRepository})
      : _fUserRepository = fUserRepository {
    _fUserInfoStreamController = StreamController<FUserInfoResDto>.broadcast();
    fUserInfoStream = _fUserInfoStreamController.stream;
  }


  @override
  FUserInfoResDto reqSignInUserInfoFromMemory(
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
    _fUserInfo = await _fUserRepository.findByMe();
    isLogin= true;
    _fUserInfoStreamController.add(_fUserInfo);
    if (outputPort != null) {
      outputPort.onSignInUserInfoFromMemory(_fUserInfo);
    }
  }

  @override
  void clearUserInfo() {
    _fUserInfo = null;
    isLogin= false;
    _fUserInfoStreamController.add(null);
  }

  void dispose() {
    _fUserInfoStreamController.close();
  }
}
