import 'package:flutter/material.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/FBall/Dto/FBallType.dart';
import 'package:forutonafront/FBall/Dto/UserBall/UserBallResDto.dart';

import 'package:forutonafront/FBall/Widget/BallStyle/Style2/IssueBallWidgetStyle2.dart';


class BallStyle2Support {
    static Widget selectBallWidget(UserBallResDto resDto){
      if (resDto.fBallType == FBallType.IssueBall) {
        return IssueBallWidgetStyle2(resDto);
      } else if (resDto.fBallType == FBallType.QuestBall) {
        return Container(
          child: Text("Quest"),
        );
      } else {
        return Container(child: Text("don't know"));
      }
  }
}