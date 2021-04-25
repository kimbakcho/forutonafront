import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/Repository/FUserRepository.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/FUser/SigInInUserInfoUseCase/SignInUserInfoUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/FUserInfoResDto.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  Future<FUserInfoResDto> saveSignInInfoInMemoryFromAPiServer(
      {SignInUserInfoUseCaseOutputPort outputPort}) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool("isLogin", true);
    _fUserInfo = await _fUserRepository.findByMe();
    isLogin = true;
    _fUserInfoStreamController.add(_fUserInfo);
    if (outputPort != null) {
      outputPort.onSignInUserInfoFromMemory(_fUserInfo);
    }
    return _fUserInfo;
  }

  bool checkMaliciousPopup() {
    try{
      var fUserInfoResDto = reqSignInUserInfoFromMemory();
      if (isLogin) {
        if (fUserInfoResDto.maliciousCount > 0 &&
            fUserInfoResDto.maliciousMessageCheck == false &&
            fUserInfoResDto.stopPeriod == null) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    }catch(ex) {
      return false;
    }

  }

  @override
  void clearUserInfo() async {
    _fUserInfo = null;
    isLogin = false;
    var sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool("isLogin", false);
    _fUserInfoStreamController.add(null);
  }

  void dispose() {
    _fUserInfoStreamController.close();
  }

  @override
  Future<bool> isLoginFromPreference() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    if(!sharedPreferences.getKeys().contains("isLogin")){
      return false;
    }
    bool result = sharedPreferences.getBool("isLogin");
    return result;
  }
}
