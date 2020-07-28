
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:forutonafront/Common/Page/Dto/PageWrap.dart';
import 'package:forutonafront/FBall/Data/Entity/FBall.dart';
import 'package:forutonafront/FBall/Data/Entity/FBallListUpWrap.dart';
import 'package:forutonafront/FBall/Data/Entity/UserToMakeBallWrap.dart';
import 'package:forutonafront/FBall/Data/Value/FBallImageUpload.dart';
import 'package:forutonafront/FBall/Dto/BallFromMapAreaReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallInsertReqDto/FBallInsertReqDto.dart';

import 'package:forutonafront/FBall/Dto/FBallListUpFromBallInfluencePowerReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallListUpFromSearchTitleReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallListUpFromTagNameReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/FBall/Dto/FBallUpdateReqDto/FBallUpdateReqDto.dart';
import 'package:forutonafront/FBall/Dto/UserBall/UserToMakeBallReqDto.dart';


abstract class FBallRepository {
  Future<PageWrap<FBallResDto>> listUpFromInfluencePower(FBallListUpFromBallInfluencePowerReqDto listUpReqDto);
  Future<UserToMakeBallWrap> getUserToMakerBalls({@required UserToMakeBallReqDto reqDto});
  Future<FBallListUpWrap> listUpFromSearchTitle({@required FBallListUpFromSearchTitleReqDto reqDto});
  Future<FBallListUpWrap> listUpFromTagName({@required FBallListUpFromTagNameReqDto reqDto});
  Future<FBallListUpWrap> ballListUpFromMapArea({@required BallFromMapAreaReqDto reqDto});
  Future<int> deleteBall(String ballUuid);
  Future<FBall> insertBall(FBallInsertReqDto reqDto);
  Future<FBall> selectBall(String ballUuid);
  Future<int> updateBall(FBallUpdateReqDto reqDto);
  Future<int> ballHit(FBallReqDto reqDto);
  Future<FBallImageUpload> ballImageUpload({@required List<Uint8List> images});
}
