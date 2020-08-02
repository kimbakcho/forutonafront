import 'package:flutter/cupertino.dart';
import 'package:forutonafront/FBall/Domain/Value/FBallType.dart';

import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'IssueBallWidgetStyle1.dart';

abstract class BallStyle1Widget extends Widget{
  factory BallStyle1Widget.create({@required FBallResDto fBallResDto}){
    switch (fBallResDto.ballType) {
      case FBallType.IssueBall: {
        return IssueBallWidgetStyle1(fBallResDto: fBallResDto);
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