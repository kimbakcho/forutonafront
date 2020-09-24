import 'package:flutter/cupertino.dart';
import 'package:forutonafront/FBall/Domain/UseCase/NoInterestBallUseCase/NoInterestBallUseCaseInputPort.dart';
import 'package:injectable/injectable.dart';


abstract class BallOptionButtonAction {
  Future<void> execute();
}

