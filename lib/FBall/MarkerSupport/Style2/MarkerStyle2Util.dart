import 'package:flutter/material.dart';
import 'package:forutonafront/FBall/Dto/FBallType.dart';
import 'package:forutonafront/FBall/MarkerSupport/Style2/Widget/IssueBallStyle2MarkerWidget.dart';
import 'package:forutonafront/FBall/MarkerSupport/Style2/Widget/QuestBallStyle2MarkerWidget.dart';

class MarkerStyle1Uti2 {
  static Widget ballWidgetSelect(FBallType ballType){
    if(ballType == FBallType.IssueBall){
      return IssueBallStyle2MarkerWidget.selectBall();
    }else if(ballType == FBallType.QuestBall){
      return QuestBallStyle2MarkerWidget.selectBall();
    }else {
      return Container(child: Text("d"),);
    }
  }
}