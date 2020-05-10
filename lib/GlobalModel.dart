import 'package:flutter/material.dart';

import 'package:forutonafront/ForutonaUser/Dto/FUserInfoResDto.dart';

import 'ForutonaUser/Dto/FUserInfoJoinReqDto.dart';
import 'ForutonaUser/Dto/PwFindPhoneAuthReqDto.dart';

class GlobalModel with ChangeNotifier {

  FUserInfoResDto fUserInfoDto;
  FUserInfoJoinReqDto fUserInfoJoinReqDto = FUserInfoJoinReqDto();
  PwFindPhoneAuthReqDto pwFindPhoneAuthReqDto = PwFindPhoneAuthReqDto();
}