import 'package:flutter/material.dart';
import 'package:forutonafront/FBall/Domain/Value/FBallType.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/FBall/Presentation/Widget/BallStyle/Style2/IssueBallWidgetStyle2.dart';



abstract class BallStyle2Widget extends Widget {
  factory BallStyle2Widget.create({@required FBallResDto fBallResDto}){
    switch (fBallResDto.ballType) {
      case FBallType.IssueBall: {
        return IssueBallWidgetStyle2(fBallResDto: fBallResDto);
      }
      default: {
        return null;
      }
      break;
    }
  }
}