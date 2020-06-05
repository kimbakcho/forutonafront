

import 'package:flutter/cupertino.dart';
import 'package:forutonafront/FBall/Dto/UserBall/UserToMakeBallReqDto.dart';
import 'package:forutonafront/FBall/Dto/UserBall/UserToMakeBallResDto.dart';

import 'UserMakeBallListUpUseCaseOutputPort.dart';

abstract class UserMakeBallListUpUseCaseInputPort {
  Future<List<UserToMakeBallResDto>> userMakeBallListUp({@required UserToMakeBallReqDto reqDto,UserMakeBallListUpUseCaseOutputPort outputPort});
}