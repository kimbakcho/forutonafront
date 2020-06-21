
import 'package:flutter/cupertino.dart';
import 'package:forutonafront/FBall/Domain/UseCase/FBallListUpFromInfluencePower/FBallListUpFromInfluencePowerUseCaseOutputPort.dart';
import 'package:forutonafront/FBall/Dto/FBallListUpFromBallInfluencePowerReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:geolocator/geolocator.dart';

abstract class FBallListUpFromInfluencePowerUseCaseInputPort {
  Future<void> reqBallListUpFromInfluencePower (Position searchReqDto,FBallListUpFromInfluencePowerUseCaseOutputPort outputPort);
  nextPage();
  pageReset();
  bool hasMoreListUpBall(int nowBallCount);
}