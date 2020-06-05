
import 'package:flutter/cupertino.dart';
import 'package:forutonafront/FBall/Dto/FBallListUpReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';

abstract class FBallListUpUseCaseInputPort {
  Future<List<FBallResDto>> positionSearchListUpBall ({@required FBallListUpReqDto searchReqDto,});

  Future<List<FBallResDto>> lastKnowPositionSearchListUpBall({@required  FBallListUpReqDto searchReqDto});
}