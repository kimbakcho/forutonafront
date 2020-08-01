import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:forutonafront/ForutonaUser/Domain/Entity/FUserInfo.dart';
import 'package:forutonafront/ForutonaUser/Domain/Repository/FUserRepository.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/FUser/SigInInUserInfoUseCase/SignInUserInfoUseCaseInputPort.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserInfoResDto.dart';

import 'SignInUserInfoUseCaseOutputPort.dart';

class SignInUserInfoUseCase implements SignInUserInfoUseCaseInputPort {
  FUserInfo _fUserInfo;
  FUserRepository _fUserRepository;

  @override
  Stream<FUserInfoResDto> fUserInfoStream;

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
      outputPort.onSignInUserInfoFromMemory(FUserInfoResDto.fromFUserInfo(_fUserInfo));
    }
    return _fUserInfo;
  }

  @override
  Future<void> saveSignInInfoInMemoryFromAPiServer(String uid,
      {SignInUserInfoUseCaseOutputPort outputPort}) async {
    FUserInfoResDto findByMe = await _fUserRepository.findByMe();
    _fUserInfo =  FUserInfo.fromFUserInfoResDto(findByMe);
    _fUserInfoStreamController.add(findByMe);
    if (outputPort != null) {
      outputPort.onSignInUserInfoFromMemory(findByMe);
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
