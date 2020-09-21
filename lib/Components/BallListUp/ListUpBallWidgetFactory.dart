import 'package:flutter/material.dart';
import 'package:forutonafront/Components/BallStyle/BallWidget/IssueBallWidgetFactory.dart';
import 'package:forutonafront/FBall/Domain/Value/FBallType.dart';

import 'BallListMediator.dart';

class ListUpBallWidgetFactory {
  static Widget getBallWidget(int index,BallListMediator ballListMediator){
    if(ballListMediator.ballList[index].ballType == FBallType.IssueBall){
      return IssueBallWidgetFactory.getIssueBallWidget(index,ballListMediator);
    }else {
      return Container(child: Text("지원하지 않는 볼 위젯"));
    }
  }
}