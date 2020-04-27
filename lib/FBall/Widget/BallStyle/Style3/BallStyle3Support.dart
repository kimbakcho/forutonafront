import 'package:flutter/material.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/FBall/Dto/FBallType.dart';
import 'package:forutonafront/FBall/Widget/BallStyle/Style3/IssueBallWidgetStyle3.dart';

import 'QuestBallWidgetStyle3.dart';


class BallStyle3Support {
    static Widget selectBallWidget(FBallResDto resDto){
      if (resDto.ballType == FBallType.IssueBall) {
        return IssueBallWidgetStyle3(resDto);
      } else if (resDto.ballType == FBallType.QuestBall) {
        return QuestBallWidgetStyle3(resDto);
      } else {
        return Container(child: Text("don't know"));
      }
  }

}