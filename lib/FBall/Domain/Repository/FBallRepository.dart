
import 'package:flutter/cupertino.dart';
import 'package:forutonafront/FBall/Data/Entity/FBallListUpWrap.dart';
import 'package:forutonafront/FBall/Data/Entity/UserToMakeBallWrap.dart';

import 'package:forutonafront/FBall/Dto/FBallListUpReqDto.dart';
import 'package:forutonafront/FBall/Dto/UserBall/UserToMakeBallReqDto.dart';

abstract class FBallRepository {
  Future<FBallListUpWrap> listUpFromPosition({@required FBallListUpReqDto listUpReqDto});
  Future<UserToMakeBallWrap> getUserToMakerBalls({@required UserToMakeBallReqDto reqDto});

}
