import 'package:flutter/material.dart';
import 'package:forutonafront/Components/BallStyle/BallWidget/IssueBallWidgetFactory.dart';
import 'package:forutonafront/FBall/Domain/Value/FBallType.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';

class ListUpBallWidgetFactory {
  static Widget getBallWidget(FBallResDto fBallResDto){
    if(fBallResDto.ballType == FBallType.IssueBall){
      return IssueBallWidgetFactory.getIssueBallWidget(fBallResDto);
    }else {
      return Container(child: Text("지원하지 않는 볼 위젯"));
    }
  }
}