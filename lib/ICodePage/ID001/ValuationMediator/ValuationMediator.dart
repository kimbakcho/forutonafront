import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:forutonafront/FBall/Domain/UseCase/BallLikeUseCase/BallLikeUseCaseInputPort.dart';
import 'package:forutonafront/FBall/Dto/FBallLikeResDto.dart';

abstract class ValuationMediatorComponent {
  updateValuation(FBallLikeResDto fBallLikeResDto);
}

abstract class ValuationMediator {
  registerComponent(ValuationMediatorComponent valuationMediatorComponent);
  Future<FBallLikeResDto> like(int point,String ballUuid);
  Future<FBallLikeResDto> disLike(int point,String ballUuid);
  Future<FBallLikeResDto> likeCancel(int point,String ballUuid);
  Future<FBallLikeResDto> disLikeCancel(int point,String ballUuid);
}

class ValuationMediatorImpl implements ValuationMediator{
  final BallLikeUseCaseInputPort _ballLikeUseCaseInputPort;

  List<ValuationMediatorComponent> components = [];

  ValuationMediatorImpl({@required BallLikeUseCaseInputPort ballLikeUseCaseInputPort})
  :_ballLikeUseCaseInputPort = ballLikeUseCaseInputPort;

  @override
  registerComponent(ValuationMediatorComponent valuationMediatorComponent) {
    components.add(valuationMediatorComponent);
  }

  allUpdateValuation(FBallLikeResDto fBallLikeResDto){
    components.forEach((element) {
      element.updateValuation(fBallLikeResDto);
    });
  }

  @override
  Future<FBallLikeResDto> like(int point,String ballUuid) async {
    var fBallLikeResDto = await _ballLikeUseCaseInputPort.ballLike(point, ballUuid);
    allUpdateValuation(fBallLikeResDto);
    return fBallLikeResDto;
  }

  @override
  Future<FBallLikeResDto> likeCancel(int point,String ballUuid) async {
    var fBallLikeResDto = await _ballLikeUseCaseInputPort.ballLikeCancel(point, ballUuid);
    allUpdateValuation(fBallLikeResDto);
    return fBallLikeResDto;
  }

  @override
  Future<FBallLikeResDto> disLike(int point, String ballUuid) async {
    var fBallLikeResDto = await _ballLikeUseCaseInputPort.ballDisLike(point, ballUuid);
    allUpdateValuation(fBallLikeResDto);
    return fBallLikeResDto;
  }

  @override
  Future<FBallLikeResDto> disLikeCancel(int point, String ballUuid) async {
    var fBallLikeResDto = await _ballLikeUseCaseInputPort.ballDisLikeCancel(point, ballUuid);
    allUpdateValuation(fBallLikeResDto);
    return fBallLikeResDto;
  }


}