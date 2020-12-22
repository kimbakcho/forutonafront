import 'package:flutter/cupertino.dart';
import 'package:forutonafront/AppBis/FBall/Domain/Value/FBallType.dart';


import 'Widget/IssueBallStyle1MarkerWidget.dart';
import 'Widget/QuestBallStyle1MarkerWidget.dart';

class MarkerStyle1Util {
  static Widget ballWidgetSelect(FBallType ballType,bool isSelect){
    if(ballType == FBallType.IssueBall){
      if(isSelect){
        return IssueBallStyle1MarkerWidget.selectBall();
      }else {
        return IssueBallStyle1MarkerWidget.unSelectBall();
      }
    }else if(ballType == FBallType.QuestBall){
      if(isSelect){
        return QuestBallStyle1MarkerWidget.selectBall();
      }else {
        return QuestBallStyle1MarkerWidget.unSelectBall();
      }
    }else {
      return Container(child: Text("d"),);
    }
  }
}