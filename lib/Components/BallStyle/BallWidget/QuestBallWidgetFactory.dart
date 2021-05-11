
import 'package:flutter/material.dart';
import 'package:forutonafront/Components/BallListUp/BallListMediator.dart';
import 'package:forutonafront/Components/BallListUp/ListUpBallWidgetFactory.dart';
import 'package:forutonafront/Components/BallStyle/BallWidget/QuestBallHaveImageWidget.dart';

class QuestBallWidgetFactory{
  static Widget getIssueBallWidget(
      int index, BallListMediator searchCollectMediator, BallStyle ballStyle,
      {BoxDecoration? boxDecoration}) {
    var item = searchCollectMediator.itemList[index];
    if(item != null ){
      return Container(
        child: QuestBallHaveImageWidget(
          index: index,
          ballListMediator: searchCollectMediator,
        )
      );
    }else {
      return Container();
    }

  }
}