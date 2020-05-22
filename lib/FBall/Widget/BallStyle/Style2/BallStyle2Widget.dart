import 'package:flutter/material.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/FBall/Dto/FBallType.dart';
import 'package:forutonafront/FBall/Dto/UserBall/UserBallResDto.dart';
import 'package:forutonafront/FBall/Widget/BallStyle/Style2/BallStyle2WidgetController.dart';

import 'package:forutonafront/FBall/Widget/BallStyle/Style2/IssueBallWidgetStyle2.dart';


abstract class BallStyle2Widget extends Widget {
  BallStyle2WidgetController getBallStyle2WidgetController();
  String getBallUuid();
  factory BallStyle2Widget.create(FBallType fBallType,BallStyle2WidgetController ballStyle2WidgetController){
    switch (fBallType) {
      case FBallType.IssueBall: {
        return IssueBallWidgetStyle2(ballStyle2WidgetController);
      }
      default: {
        return null;
      }
      break;
    }
  }
}