import 'package:flutter/material.dart';
import 'package:forutonafront/FBall/Domain/Value/FBallType.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/FBall/Presentation/Widget/BallStyle/Style3/IssueBallWidgetStyle3.dart';

abstract class BallStyle3Widget extends Widget  {
    factory BallStyle3Widget.create({@required FBallResDto ballResDto}){
      switch (ballResDto.ballType) {
        case FBallType.IssueBall: {
          return IssueBallWidgetStyle3(fBallResDto: ballResDto);
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