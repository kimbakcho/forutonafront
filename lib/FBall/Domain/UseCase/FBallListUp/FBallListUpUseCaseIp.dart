
import 'package:flutter/cupertino.dart';
import 'package:forutonafront/FBall/Dto/FBallListUpReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';

abstract class FBallListUpUseCaseIp {
  Future<List<FBallResDto>> positionSearchListUpBall ({@required FBallListUpReqDto searchReqDto,});

  Future<List<FBallResDto>> lastKnowPositionSearchListUpBall({@required  FBallListUpReqDto searchReqDto});
}