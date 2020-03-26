import 'package:flutter/material.dart';
import 'package:forutonafront/Auth/UserInfoMain.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserInfoDto.dart';

class GlobalModel with ChangeNotifier {

  FUserInfoDto _fUserInfoDto;

  FUserInfoDto get fUserInfoDto => _fUserInfoDto;

  set fUserInfoDto(FUserInfoDto value) {
    _fUserInfoDto = value;
  }


}