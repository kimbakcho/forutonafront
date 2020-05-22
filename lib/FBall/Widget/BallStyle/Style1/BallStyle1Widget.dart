import 'package:flutter/cupertino.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/FBall/Dto/FBallType.dart';

import 'BallStyle1WidgetController.dart';
import 'IssueBallWidgetStyle1.dart';

abstract class BallStyle1Widget extends Widget{
  BallStyle1WidgetController getBallStyle1WidgetController();
  String getBallUuid();
  factory BallStyle1Widget.create(FBallType fBallType,BallStyle1WidgetController ballStyle1WidgetController){
    switch (fBallType) {
      case FBallType.IssueBall: {
        return IssueBallWidgetStyle1(ballStyle1WidgetController);
      }
      break;
      case FBallType.QuestBall:{
        return null;
      }
      break;
      default: {
        return null;
      }
      break;
    }
  }

}