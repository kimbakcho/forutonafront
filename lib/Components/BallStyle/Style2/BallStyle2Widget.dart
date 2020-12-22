import 'package:flutter/material.dart';
import 'package:forutonafront/Components/BallStyle/Style2/IssueBallWidgetStyle2.dart';
import 'package:forutonafront/AppBis/FBall/Domain/Value/FBallType.dart';
import 'package:forutonafront/AppBis/FBall/Dto/FBallResDto.dart';



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