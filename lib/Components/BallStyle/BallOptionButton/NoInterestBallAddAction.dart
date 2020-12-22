import 'package:flutter/material.dart';
import 'package:forutonafront/Components/BallListUp/BallListMediator.dart';
import 'package:forutonafront/AppBis/FBall/Domain/UseCase/NoInterestBallUseCase/NoInterestBallUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/FBall/Dto/FBallResDto.dart';

import 'BallOptionButtonAction.dart';

class NoInterestBallAddAction extends BallOptionButtonAction {
  final NoInterestBallUseCaseInputPort noInterestBallUseCaseInputPort;
  final BallListMediator ballListMediator;
  final FBallResDto fBallResDto;
  NoInterestBallAddAction(
      {@required this.noInterestBallUseCaseInputPort,
        @required this.fBallResDto,
        @required this.ballListMediator});

  @override
  Future<void> execute() async {
    await noInterestBallUseCaseInputPort.save(fBallResDto.ballUuid);
    await ballListMediator.hideBall(fBallResDto.ballUuid);
  }
}
