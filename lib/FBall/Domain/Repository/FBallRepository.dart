
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
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/FBall/Dto/FBallUpdateReqDto/FBallUpdateReqDto.dart';
import 'package:forutonafront/FBall/Dto/UserBall/UserToMakeBallReqDto.dart';


abstract class FBallRepository {
  Future<PageWrap<FBallResDto>> listUpFromInfluencePower({@required FBallListUpFromBallInfluencePowerReqDto listUpReqDto});
  Future<PageWrap<FBallResDto>> getUserToMakerBalls({@required UserToMakeBallReqDto reqDto});
  Future<PageWrap<FBallResDto>> listUpFromSearchTitle({@required FBallListUpFromSearchTitleReqDto reqDto});
  Future<PageWrap<FBallResDto>> listUpFromTagName({@required FBallListUpFromTagNameReqDto reqDto});
  Future<PageWrap<FBallResDto>> ballListUpFromMapArea({@required BallFromMapAreaReqDto reqDto});
  Future<int> deleteBall(String ballUuid);
  Future<FBallResDto> insertBall(FBallInsertReqDto reqDto);
  Future<FBall> selectBall(String ballUuid);
  Future<int> updateBall(FBallUpdateReqDto reqDto);
  Future<int> ballHit(String ballUuid);
  Future<FBallImageUpload> ballImageUpload({@required List<Uint8List> images});
}
