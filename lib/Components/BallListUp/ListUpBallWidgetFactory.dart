import 'package:flutter/material.dart';
import 'package:forutonafront/Components/BallStyle/BallWidget/IssueBallWidgetFactory.dart';
import 'package:forutonafront/AppBis/FBall/Domain/Value/FBallType.dart';
import 'package:forutonafront/Components/BallStyle/BallWidget/QuestBallWidgetFactory.dart';

import 'BallListMediator.dart';

class ListUpBallWidgetFactory {
  static Widget getBallWidget(
      int index, BallListMediator ballListMediator, BallStyle ballStyle,{BoxDecoration? boxDecoration}) {
    var item = ballListMediator.itemList[index];
    if(item != null) {
      if (item.ballType == FBallType.IssueBall) {
        return IssueBallWidgetFactory.getIssueBallWidget(
            index, ballListMediator, ballStyle,boxDecoration: boxDecoration);
      }else if (item.ballType == FBallType.QuestBall) {
        return QuestBallWidgetFactory.getIssueBallWidget(
            index, ballListMediator, ballStyle,boxDecoration: boxDecoration);
      } else {
        return Container(child: Text("지원하지 않는 볼 위젯"));
      }
    }else {
      return Container();
    }

  }
}

enum BallStyle { Style1, Style2,Style3 }
