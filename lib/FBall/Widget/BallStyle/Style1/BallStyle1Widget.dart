import 'package:flutter/cupertino.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/FBall/Dto/FBallType.dart';

import 'IssueBallWidgetStyle1.dart';

abstract class BallStyle1Widget extends Widget{
  FBallResDto getFBallResDto();

  factory BallStyle1Widget.create(FBallResDto resDto,Function(FBallResDto) onRequestReFreshBall){
    switch (resDto.ballType) {
      case FBallType.IssueBall: {
        return IssueBallWidgetStyle1(resDto,onRequestReFreshBall);
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