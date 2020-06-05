import 'package:flutter/cupertino.dart';
import 'package:forutonafront/FBall/Dto/UserBall/UserToMakeBallReqDto.dart';
import 'package:forutonafront/FBall/Dto/UserBall/UserToMakeBallResDto.dart';
import 'package:forutonafront/FBall/Dto/UserBall/UserToPlayBallReqDto.dart';
import 'package:forutonafront/FBall/Dto/UserBall/UserToPlayBallResDto.dart';

abstract class UserPlayBallListUpUseCaseInputPort {
  Future<List<UserToPlayBallResDto>> userPlayBallListUp({@required UserToPlayBallReqDto reqDto});

}