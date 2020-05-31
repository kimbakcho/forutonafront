
import 'package:flutter/cupertino.dart';
import 'package:forutonafront/Core/error/Failure.dart';
import 'package:forutonafront/FBall/Dto/FBallListUpReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallListUpWrapDto.dart';

abstract class FBallUseCaseInputPort {
  Future<FBallListUpWrapDto> positionSearchListUpBall ({@required FBallListUpReqDto searchReqDto});
}