
import 'package:flutter/cupertino.dart';
import 'package:forutonafront/FBall/Dto/FBallListUpFromBallInfluencePowerReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';

abstract class FBallListUpFromInfluencePowerUseCaseInputPort {
  Future<List<FBallResDto>> ballListUpFromInfluencePower ({@required FBallListUpFromBallInfluencePowerReqDto searchReqDto,});

  Future<List<FBallResDto>> ballListUpFromLastKnowPosition({@required  FBallListUpFromBallInfluencePowerReqDto searchReqDto});
}