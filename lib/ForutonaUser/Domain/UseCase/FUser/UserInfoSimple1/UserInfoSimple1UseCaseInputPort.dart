import 'package:flutter/material.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserInfoSimple1ResDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserReqDto.dart';

import 'UserInfoSimple1UseCaseOutputPort.dart';

abstract class UserInfoSimple1UseCaseInputPort {
  Future<FUserInfoSimple1ResDto> getBallMakerInfo({@required FUserReqDto makerUid,UserInfoSimple1UseCaseOutputPort outputPort});
}