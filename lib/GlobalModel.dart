import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:forutonafront/ForutonaUser/Dto/FUserInfoResDto.dart';
import 'package:forutonafront/ForutonaUser/Repository/FUserRepository.dart';
import 'package:mutex/mutex.dart';

import 'ForutonaUser/Dto/FUserInfoJoinReqDto.dart';
import 'ForutonaUser/Dto/PwFindPhoneAuthReqDto.dart';

class GlobalModel with ChangeNotifier {

  FUserInfoResDto fUserInfoDto;
  FUserInfoJoinReqDto fUserInfoJoinReqDto = FUserInfoJoinReqDto();
  PwFindPhoneAuthReqDto pwFindPhoneAuthReqDto = PwFindPhoneAuthReqDto();
  FUserRepository _fUserRepository = new FUserRepository();
  Mutex geoRequestMutex = new Mutex();

  GlobalModel(){
    init();
  }
  init() async {
    await setFUserInfoDto();
  }

  Future<void> setFUserInfoDto() async {
    fUserInfoDto = await _fUserRepository.getForutonaGetMe();
  }

}