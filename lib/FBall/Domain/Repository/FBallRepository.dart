import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:forutonafront/Common/Page/Dto/PageWrap.dart';
import 'package:forutonafront/Common/PageableDto/Pageable.dart';
import 'package:forutonafront/FBall/Domain/Value/FBallImageUpload.dart';
import 'package:forutonafront/FBall/Dto/BallFromMapAreaReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallInsertReqDto/FBallInsertReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallListUpFromBallInfluencePowerReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallListUpFromSearchTitleReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallListUpFromTagNameReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/FBall/Dto/FBallUpdateReqDto/FBallUpdateReqDto.dart';

abstract class FBallRepository {
  Future<PageWrap<FBallResDto>> listUpFromInfluencePower(
      {@required FBallListUpFromBallInfluencePowerReqDto listUpReqDto,
      @required Pageable pageable});

  Future<PageWrap<FBallResDto>> searchUserToMakerBalls(
      {@required String makerUid, @required Pageable pageable});

  Future<PageWrap<FBallResDto>> listUpFromSearchTitle(
      {@required FBallListUpFromSearchTitleReqDto reqDto,@required Pageable pageable});

  Future<PageWrap<FBallResDto>> listUpFromTagName(
      {@required FBallListUpFromTagNameReqDto reqDto,
      @required Pageable pageable});

  Future<PageWrap<FBallResDto>> ballListUpFromMapArea(
      {@required BallFromMapAreaReqDto reqDto, @required Pageable pageable});

  Future<String> deleteBall(String ballUuid);

  Future<FBallResDto> insertBall(FBallInsertReqDto reqDto);

  Future<FBallResDto> selectBall(String ballUuid);

  Future<FBallResDto> updateBall(FBallUpdateReqDto reqDto);

  Future<int> ballHit(String ballUuid);

  Future<FBallImageUpload> ballImageUpload({@required List<Uint8List> images});


}
