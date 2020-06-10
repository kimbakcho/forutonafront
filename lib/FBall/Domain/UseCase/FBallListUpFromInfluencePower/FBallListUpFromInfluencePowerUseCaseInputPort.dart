
import 'package:flutter/cupertino.dart';
import 'package:forutonafront/FBall/Dto/FBallListUpFromBallInfluencePowerReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:geolocator/geolocator.dart';

abstract class FBallListUpFromInfluencePowerUseCaseInputPort {
  Future<void> reqBallListUpFromInfluencePower ({@required Position searchReqDto,});
  nextPage();
  pageReset();
  bool hasMoreListUpBall({int nowBallCount});
}