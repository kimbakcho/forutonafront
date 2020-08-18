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
      outputPort.onSignInUserInfoFromMemory(FUserInfoResDto.fromFUserInfo(_fUserInfo));
    }
    return FUserInfoResDto.fromFUserInfo(_fUserInfo);
  }

  @override
  Future<void> saveSignInInfoInMemoryFromAPiServer(String uid,
      {SignInUserInfoUseCaseOutputPort outputPort}) async {
    _fUserInfo = await _fUserRepository.findByMe();
    FUserInfoResDto fUserInfoResDto = FUserInfoResDto.fromFUserInfo(_fUserInfo);
    _fUserInfoStreamController.add(fUserInfoResDto);
    if (outputPort != null) {
      outputPort.onSignInUserInfoFromMemory(fUserInfoResDto);
    }
  }

  @override
  void clearUserInfo() {
    _fUserInfo = null;
    _fUserInfoStreamController.add(null);
  }

  void dispose() {
    _fUserInfoStreamController.close();
  }
}
