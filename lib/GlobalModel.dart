import 'package:flutter/material.dart';
import 'package:forutonafront/ForutonaUser/Data/Repository/FUserRepositoryImpl.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserInfoResDto.dart';
import 'package:geolocator/geolocator.dart';

import 'ForutonaUser/Domain/Repository/FUserRepository.dart';
import 'ForutonaUser/Dto/FUserInfoJoinReqDto.dart';
import 'ForutonaUser/Dto/PwFindPhoneAuthReqDto.dart';
import 'ServiceLocator/ServiceLocator.dart';

class GlobalModel with ChangeNotifier {

  PwFindPhoneAuthReqDto pwFindPhoneAuthReqDto = PwFindPhoneAuthReqDto();
  FUserRepository _fUserRepository = new FUserRepositoryImpl(
      fireBaseAuthBaseAdapter: sl(), fUserRemoteDataSource: sl());
  Position currentAddress = Position();

  GlobalModel() {
    init();
  }

  init() async {

  }



  String userNickName() {
    return "TESTNICKNAME";
  }


}
