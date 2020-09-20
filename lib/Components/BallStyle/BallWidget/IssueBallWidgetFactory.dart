import 'package:flutter/material.dart';
import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart';
import 'package:forutonafront/Components/BallListUp/BallListMediator.dart';
import 'package:forutonafront/Components/BallStyle/BallWidget/IssueBallHaveImageWidget.dart';
import 'package:forutonafront/FBall/Domain/UseCase/BallDisPlayUseCase/IssueBallDisPlayUseCase.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';

import 'IssueBallNotHaveImageWidget.dart';

class IssueBallWidgetFactory {
  static Widget getIssueBallWidget(int index,BallListMediator ballListMediator) {
    IssueBallDisPlayUseCase issueBallDisPlayUseCase =
        IssueBallDisPlayUseCase(fBallResDto: ballListMediator.ballList[index],geoLocatorAdapter: sl());
    if (issueBallDisPlayUseCase.isMainPicture()) {
      return IssueBallHaveImageWidget(index: index,ballListMediator: ballListMediator);
    } else {
      return IssueBallNotHaveImageWidget(index: index,ballListMediator: ballListMediator);
    }
  }
}
