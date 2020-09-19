import 'package:flutter/material.dart';
import 'package:forutonafront/Components/BallStyle/BallWidget/IssueBallHaveImageWidget.dart';
import 'package:forutonafront/FBall/Domain/UseCase/BallDisPlayUseCase/IssueBallDisPlayUseCase.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';

import 'IssueBallNotHaveImageWidget.dart';

class IssueBallWidgetFactory {
  static Widget getIssueBallWidget(FBallResDto fBallResDto) {
    IssueBallDisPlayUseCase issueBallDisPlayUseCase =
        IssueBallDisPlayUseCase(fBallResDto: fBallResDto);
    if (issueBallDisPlayUseCase.isMainPicture()) {
      return IssueBallHaveImageWidget(fBallResDto: fBallResDto);
    } else {
      return IssueBallNotHaveImageWidget(fBallResDto: fBallResDto);
    }
  }
}
