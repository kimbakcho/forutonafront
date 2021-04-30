import 'package:flutter/material.dart';
import 'package:forutonafront/Components/BallListUp/BallListMediator.dart';
import 'package:forutonafront/Components/BallListUp/ListUpBallWidgetFactory.dart';
import 'package:forutonafront/Components/BallStyle/BallWidget/IssueBallHaveImageWidget.dart';
import 'package:forutonafront/AppBis/FBall/Domain/UseCase/BallDisPlayUseCase/IssueBallDisPlayUseCase.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';

import 'IssueBallHaveImageWidget.dart';
import 'IssueBallNotHaveImageWidget.dart';
import 'IssueBallReduceSizeWidget.dart';

class IssueBallWidgetFactory {
  static Widget getIssueBallWidget(
      int index, BallListMediator searchCollectMediator, BallStyle ballStyle,
      {BoxDecoration? boxDecoration}) {
    var item = searchCollectMediator.itemList[index];
    if(item != null ){
      IssueBallDisPlayUseCase issueBallDisPlayUseCase = IssueBallDisPlayUseCase(
          fBallResDto: item,
          geoLocatorAdapter: sl());
      if (ballStyle == BallStyle.Style1) {
        if (issueBallDisPlayUseCase.isMainPicture()) {
          return IssueBallHaveImageWidget(
            key: Key(item.ballUuid!),
            index: index,
            ballListMediator: searchCollectMediator,
            boxDecoration: boxDecoration,
          );
        } else {
          return IssueBallNotHaveImageWidget(
              key: Key(item.ballUuid!),
              index: index,
              ballListMediator: searchCollectMediator,
              boxDecoration: boxDecoration);
        }
      } else if (ballStyle == BallStyle.Style2) {
        return IssueBallReduceSizeWidget(
          key: Key(item.ballUuid!),
          issueBallDisPlayUseCase: issueBallDisPlayUseCase,
          ballListMediator: searchCollectMediator,
          index: index,
          boxDecoration: boxDecoration,
        );
      } else if (ballStyle == BallStyle.Style3) {
        return IssueBallNotHaveImageWidget(
            key: Key(item.ballUuid!),
            index: index,
            ballListMediator: searchCollectMediator,
            boxDecoration: boxDecoration);
      } else {
        return Container(child: Text("지원되지 않는 Style"));
      }
    }else {
      return Container();
    }

  }
}
