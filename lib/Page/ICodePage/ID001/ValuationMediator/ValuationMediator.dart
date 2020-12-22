import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:forutonafront/AppBis/FBallValuation/Domain/UseCase/BallLikeUseCase/BallLikeUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/FBallValuation/Dto/FBallLikeResDto.dart';


import 'package:forutonafront/Page/ICodePage/ID001/Value/BallLikeState.dart';
import 'package:injectable/injectable.dart';

abstract class ValuationMediatorComponent {
  reqNotification();

  String ballUuid;
}

abstract class ValuationMediator {
  registerComponent(ValuationMediatorComponent valuationMediatorComponent);

  unregisterComponent(ValuationMediatorComponent valuationMediatorComponent);

  likeAction(ValuationMediatorComponent component);

  disLikeAction(ValuationMediatorComponent component);

  Future<FBallLikeResDto> getBallLikeState(String ballUuid,{String uid});

  updateValuation(FBallLikeResDto fBallLikeResDto);

  int componentCount();

  BallLikeState ballLikeState;

  int ballPower;
  int ballLikeCount;
  int ballDisLikeCount ;
  int likeServiceUseUserCount;
}
@Injectable(as: ValuationMediator)
class ValuationMediatorImpl implements ValuationMediator {
  final BallLikeUseCaseInputPort _ballLikeUseCaseInputPort;
  @override
  BallLikeState ballLikeState = BallLikeState.None;
  @override
  int ballDisLikeCount = 0;
  @override
  int ballLikeCount = 0;
  @override
  int ballPower = 0;
  @override
  int likeServiceUseUserCount = 0;

  List<ValuationMediatorComponent> components = [];

  ValuationMediatorImpl(
      {@required BallLikeUseCaseInputPort ballLikeUseCaseInputPort})
      : _ballLikeUseCaseInputPort = ballLikeUseCaseInputPort;

  @override
  registerComponent(ValuationMediatorComponent valuationMediatorComponent) {
    components.add(valuationMediatorComponent);
  }

  allNotification() {
    components.forEach((element) {
      element.reqNotification();
    });
  }

  likeAction(ValuationMediatorComponent component) async {
    if (ballLikeState == BallLikeState.Up) {
      ballLikeState = BallLikeState.None;
      allNotification();
      await likeCancel(1, component.ballUuid);
    } else if (ballLikeState == BallLikeState.Down) {
      ballLikeState = BallLikeState.Up;
      allNotification();
      await disLikeCancel(
        1,
        component.ballUuid,
      );
      await like(
        1,
        component.ballUuid,
      );
    } else {
      ballLikeState = BallLikeState.Up;
      allNotification();
      await like(1, component.ballUuid);
    }
  }

  disLikeAction(ValuationMediatorComponent component) async {
    if (ballLikeState == BallLikeState.Up) {
      ballLikeState = BallLikeState.Down;
      allNotification();
      await likeCancel(1, component.ballUuid);
      await disLike(1, component.ballUuid);
    } else if (ballLikeState == BallLikeState.Down) {
      ballLikeState = BallLikeState.None;
      allNotification();
      await disLikeCancel(1, component.ballUuid);
    } else {
      ballLikeState = BallLikeState.Down;
      allNotification();
      await disLike(1, component.ballUuid);
    }
  }

  Future<FBallLikeResDto> like(
    int point,
    String ballUuid,
  ) async {
    var fBallLikeResDto =
        await _ballLikeUseCaseInputPort.ballLike(point, ballUuid);
    updateValuation(fBallLikeResDto);
    return fBallLikeResDto;
  }

  Future<FBallLikeResDto> likeCancel(int point, String ballUuid) async {
    var fBallLikeResDto =
        await _ballLikeUseCaseInputPort.ballLikeCancel(point, ballUuid);
    updateValuation(fBallLikeResDto);
    return fBallLikeResDto;
  }

  Future<FBallLikeResDto> disLike(
    int point,
    String ballUuid,
  ) async {
    var fBallLikeResDto =
        await _ballLikeUseCaseInputPort.ballDisLike(point, ballUuid);
    updateValuation(fBallLikeResDto);
    return fBallLikeResDto;
  }

  Future<FBallLikeResDto> disLikeCancel(int point, String ballUuid) async {
    var fBallLikeResDto =
        await _ballLikeUseCaseInputPort.ballDisLikeCancel(point, ballUuid);
    updateValuation(fBallLikeResDto);
    return fBallLikeResDto;
  }

  updateValuation(FBallLikeResDto fBallLikeResDto) {
    ballPower = fBallLikeResDto.ballPower;
    ballLikeCount = fBallLikeResDto.ballLike;
    ballDisLikeCount = fBallLikeResDto.ballDislike;
    likeServiceUseUserCount = fBallLikeResDto.likeServiceUseUserCount;
    allNotification();
  }

  @override
  Future<FBallLikeResDto> getBallLikeState(String ballUuid, {String uid}) async {
      FBallLikeResDto fBallLikeResDto = await _ballLikeUseCaseInputPort.getBallLikeState(ballUuid, uid);
      if(fBallLikeResDto.fballValuationResDto.ballLike>0) {
        ballLikeState = BallLikeState.Up;
      }else if(fBallLikeResDto.fballValuationResDto.ballDislike>0){
        ballLikeState = BallLikeState.Down;
      }else {
        ballLikeState = BallLikeState.None;
      }
      return fBallLikeResDto;
  }

  @override
  int componentCount() {
    return components.length;
  }

  @override
  unregisterComponent(ValuationMediatorComponent valuationMediatorComponent) {
    components.remove(valuationMediatorComponent);
  }

}
