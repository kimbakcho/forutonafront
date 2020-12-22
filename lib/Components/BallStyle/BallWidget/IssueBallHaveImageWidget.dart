import 'package:flutter/material.dart';
import 'package:forutonafront/Components/BallListUp/BallListMediator.dart';
import 'package:forutonafront/Components/BallStyle/BallOptionPopup/BallOptionPopup.dart';
import 'package:forutonafront/Components/BallStyle/BallOptionPopup/BallOptionWidgetFactory.dart';
import 'package:forutonafront/AppBis/FBall/Domain/UseCase/BallDisPlayUseCase/BallDisPlayUseCase.dart';
import 'package:forutonafront/AppBis/FBall/Domain/UseCase/BallDisPlayUseCase/IssueBallDisPlayUseCase.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:provider/provider.dart';

import 'BallBigImagePanelWidget.dart';
import 'BallPositionInfoBar.dart';
import 'BallTitleInfoBar.dart';
import 'IssueBallTopBar.dart';
import 'ListUpBallWidgetItem.dart';

class IssueBallHaveImageWidget extends StatelessWidget {
  final int index;
  final BallDisPlayUseCase issueBallDisPlayUseCase;
  final BallListMediator ballListMediator;
  final BallOptionWidgetFactory ballOptionWidgetFactory;
  final BoxDecoration boxDecoration;

  IssueBallHaveImageWidget(
      {Key key,
      this.index,
      this.ballListMediator,
      this.ballOptionWidgetFactory, this.boxDecoration})
      : issueBallDisPlayUseCase = IssueBallDisPlayUseCase(
            fBallResDto: ballListMediator.itemList[index],
            geoLocatorAdapter: sl()),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => IssueBallHaveImageWidgetViewModel(
          context: context,
          ballListMediator: ballListMediator,
          issueBallDisPlayUseCase: issueBallDisPlayUseCase,
          index: index),
      child: Consumer<IssueBallHaveImageWidgetViewModel>(
        builder: (_, model, __) {
          return Container(
            child: Column(
              children: <Widget>[
                IssueBallTopBar(ballDisPlayUseCase: issueBallDisPlayUseCase),
                BallBigImagePanelWidget(
                    ballDisPlayUseCase: issueBallDisPlayUseCase),
                BallTitleInfoBar(
                  ballDisPlayUseCase: issueBallDisPlayUseCase,
                  gotoDetailPage: model.moveToDetailPage,
                  showOptionPopUp: BasicBallOptionPopup(ballOptionWidgetFactory
                      .getBallOptionWidget(BallOptionWidgetFactoryParams(
                          fBallResDto: issueBallDisPlayUseCase.fBallResDto,
                          ballListMediator: ballListMediator))),
                ),
                Divider(
                  color: Color(0xffF4F4F6).withOpacity(0.9),
                  height: 1,
                  thickness: 1,
                ),
                BallPositionInfoBar(
                    gotoDetailPage: model.moveToDetailPage,
                    ballSearchPosition: ballListMediator.searchPosition(),
                    ballDisPlayUseCase: issueBallDisPlayUseCase)
              ],
            ),
            decoration: boxDecoration,
          );
        },
      ),
    );
  }
}

class IssueBallHaveImageWidgetViewModel extends ListUpBallWidgetItem {
  final BallDisPlayUseCase issueBallDisPlayUseCase;

  IssueBallHaveImageWidgetViewModel(
      {this.issueBallDisPlayUseCase,
      BuildContext context,
      BallListMediator ballListMediator,
      int index})
      : super(context, ballListMediator, index);
}
