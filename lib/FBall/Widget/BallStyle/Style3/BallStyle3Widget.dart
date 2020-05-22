import 'package:flutter/material.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/FBall/Dto/FBallType.dart';
import 'package:forutonafront/FBall/Widget/BallStyle/Style3/IssueBallWidgetStyle3.dart';

import 'BallStyle3WidgetController.dart';
import 'QuestBallWidgetStyle3.dart';


abstract class BallStyle3Widget extends Widget  {
  BallStyle3WidgetController getBallStyle3WidgetController();
  String getBallUuid();
    factory BallStyle3Widget.create(FBallType fBallType,BallStyle3WidgetController ballStyle3WidgetController){
      switch (fBallType) {
        case FBallType.IssueBall: {
          return IssueBallWidgetStyle3(ballStyle3WidgetController);
        }
        break;
        case FBallType.QuestBall:{
          return QuestBallWidgetStyle3(ballStyle3WidgetController);
        }
        break;
        default: {
          return null;
        }
        break;
      }
    }
}