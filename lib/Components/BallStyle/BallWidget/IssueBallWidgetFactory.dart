import 'package:flutter/material.dart';
import 'package:forutonafront/Components/BallListUp/BallListMediator.dart';
import 'package:forutonafront/Components/BallStyle/BallWidget/IssueBallHaveImageWidget.dart';
import 'package:forutonafront/FBall/Domain/UseCase/BallDisPlayUseCase/IssueBallDisPlayUseCase.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';

import 'IssueBallHaveImageWidget.dart';
import 'IssueBallNotHaveImageWidget.dart';
import 'IssueBallReduceSizeWidget.dart';

class IssueBallWidgetFactory {
  static Widget getIssueBallWidget(
      int index, BallListMediator ballListMediator, Axis axis) {
    IssueBallDisPlayUseCase issueBallDisPlayUseCase = IssueBallDisPlayUseCase(
        fBallResDto: ballListMediator.ballList[index], geoLocatorAdapter: sl());
    if (axis == Axis.vertical) {
      if (issueBallDisPlayUseCase.isMainPicture()) {
        return IssueBallHaveImageWidget(
            index: index,
            ballListMediator: ballListMediator,
            ballOptionWidgetFactory: sl());
      } else {
        return IssueBallNotHaveImageWidget(
            index: index,
            ballListMediator: ballListMediator,
            ballOptionWidgetFactory: sl());
      }
    } else {
      return IssueBallReduceSizeWidget(
          issueBallDisPlayUseCase: issueBallDisPlayUseCase,
          ballListMediator: ballListMediator,
          index: index);
    }
  }
}
