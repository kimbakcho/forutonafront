import 'package:flutter/material.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/FBall/Dto/FBallType.dart';

import 'IssueBallWidgetStyle1.dart';

class BallStyle1Support {
    static Widget selectBallWidget(FBallResDto resDto){
    switch (resDto.ballType) {
      case FBallType.IssueBall: {
        return IssueBallWidgetStyle1(resDto);
      }
      break;
      case FBallType.QuestBall:{
        return Container(child: Text("QuestBall"),);
      }
      break;
      default: {
        return Container(child: Text("don't know"),);
      }
      break;
    }
  }

}