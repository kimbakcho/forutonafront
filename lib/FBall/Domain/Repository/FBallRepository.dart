
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:forutonafront/FBall/Data/Entity/FBallListUpWrap.dart';
import 'package:forutonafront/FBall/Data/Entity/UserToMakeBallWrap.dart';
import 'package:forutonafront/FBall/Data/Value/FBallImageUpload.dart';
import 'package:forutonafront/FBall/Dto/BallFromMapAreaReqDto.dart';

import 'package:forutonafront/FBall/Dto/FBallListUpFromBallInfluencePowerReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallListUpFromSearchTitleReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallListUpFromTagNameReqDto.dart';
import 'package:forutonafront/FBall/Dto/UserBall/UserToMakeBallReqDto.dart';

abstract class FBallRepository {
  Future<FBallListUpWrap> listUpFromInfluencePower({@required FBallListUpFromBallInfluencePowerReqDto listUpReqDto});
  Future<UserToMakeBallWrap> getUserToMakerBalls({@required UserToMakeBallReqDto reqDto});
  Future<FBallListUpWrap> listUpFromSearchTitle({@required FBallListUpFromSearchTitleReqDto reqDto});
  Future<FBallListUpWrap> listUpFromTagName({@required FBallListUpFromTagNameReqDto reqDto});
  Future<FBallListUpWrap> ballListUpFromMapArea({@required BallFromMapAreaReqDto reqDto});
}
