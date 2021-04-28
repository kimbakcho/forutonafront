import 'package:flutter/material.dart';
import 'package:forutonafront/Components/BallStyle/BallWidget/IssueBallWidgetFactory.dart';
import 'package:forutonafront/AppBis/FBall/Domain/Value/FBallType.dart';

import 'BallListMediator.dart';

class ListUpBallWidgetFactory {
  static Widget getBallWidget(
      int index, BallListMediator ballListMediator, BallStyle ballStyle,{BoxDecoration? boxDecoration}) {
    if (ballListMediator.itemList![index].ballType == FBallType.IssueBall) {
      return IssueBallWidgetFactory.getIssueBallWidget(
          index, ballListMediator, ballStyle,boxDecoration: boxDecoration);
    } else {
      return Container(child: Text("지원하지 않는 볼 위젯"));
    }
  }
}

enum BallStyle { Style1, Style2,Style3 }
