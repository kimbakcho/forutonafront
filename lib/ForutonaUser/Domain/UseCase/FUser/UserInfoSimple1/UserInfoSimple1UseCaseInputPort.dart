import 'package:flutter/material.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserInfoSimple1ResDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserReqDto.dart';

import 'UserInfoSimple1UseCaseOutputPort.dart';

abstract class UserInfoSimple1UseCaseInputPort {
  Future<FUserInfoSimple1ResDto> getUserInfoSimple1({@required FUserReqDto reqDto,UserInfoSimple1UseCaseOutputPort outputPort});
}