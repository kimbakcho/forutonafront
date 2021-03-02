import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:forutonafront/AppBis/FBallValuation/Domain/UseCase/BallLikeUseCase/BallLikeUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/FBallValuation/Domain/UseCase/FBallValuationUseCase/FBallValuationUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/FBallValuation/Dto/FBallVoteReqDto.dart';
import 'package:forutonafront/AppBis/FBallValuation/Dto/FBallVoteResDto.dart';

import 'package:forutonafront/Page/ICodePage/ID001/Value/BallLikeState.dart';
import 'package:injectable/injectable.dart';

abstract class ValuationMediatorComponent {
  valuationReqNotification();

  String ballUuid;
}

abstract class ValuationMediator {
  registerComponent(ValuationMediatorComponent valuationMediatorComponent);

  unregisterComponent(ValuationMediatorComponent valuationMediatorComponent);

  Future<FBallVoteResDto> voteAction(FBallVoteReqDto fBallVoteReqDto);

  Future<FBallVoteResDto> getBallLikeState(String ballUuid, {String uid});

  int componentCount();

  int ballPower;

  int ballLikeCount;

  int ballDisLikeCount;

  int likeServiceUseUserCount;
}

class ValuationMediatorImpl implements ValuationMediator {
  final FBallValuationUseCaseInputPort _fBallValuationUseCaseInputPort;
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
      {@required FBallValuationUseCaseInputPort fBallValuationUseCaseInputPort})
      : _fBallValuationUseCaseInputPort = fBallValuationUseCaseInputPort;

  @override
  registerComponent(ValuationMediatorComponent valuationMediatorComponent) {
    components.add(valuationMediatorComponent);
  }

  allNotification() {
    components.forEach((element) {
      element.valuationReqNotification();
    });
  }

  Future<FBallVoteResDto> voteAction(FBallVoteReqDto fBallVoteReqDto) async {
    FBallVoteResDto fBallVoteResDto = await _fBallValuationUseCaseInputPort.ballVote(fBallVoteReqDto);
    return fBallVoteResDto;
  }

  @override
  int componentCount() {
    return components.length;
  }

  @override
  unregisterComponent(ValuationMediatorComponent valuationMediatorComponent) {
    components.remove(valuationMediatorComponent);
  }

  @override
  Future<FBallVoteResDto> getBallLikeState(String ballUuid, {String uid}) {}
}
