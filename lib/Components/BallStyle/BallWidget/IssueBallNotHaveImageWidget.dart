import 'package:flutter/material.dart';
import 'package:forutonafront/Components/BallListUp/BallListMediator.dart';
import 'package:forutonafront/Components/BallStyle/BallOptionPopup/BallOptionPopup.dart';
import 'package:forutonafront/Components/BallStyle/BallOptionPopup/BallOptionWidgetFactory.dart';
import 'package:forutonafront/Components/BallStyle/BallWidget/IssueBallTopBar.dart';
import 'package:forutonafront/FBall/Domain/UseCase/BallDisPlayUseCase/BallDisPlayUseCase.dart';
import 'package:forutonafront/FBall/Domain/UseCase/BallDisPlayUseCase/IssueBallDisPlayUseCase.dart';
import 'package:provider/provider.dart';

import 'BallTextWidget.dart';
import 'BallTitleInfoBar.dart';
import 'ListUpBallWidgetItem.dart';

class IssueBallNotHaveImageWidget extends StatelessWidget {
  final int index;
  final BallDisPlayUseCase issueBallDisPlayUseCase;
  final BallListMediator ballListMediator;
  final BallOptionWidgetFactory ballOptionWidgetFactory;
  final BoxDecoration boxDecoration;

  IssueBallNotHaveImageWidget(
      {Key key,
      this.index,
      this.ballListMediator,
      this.ballOptionWidgetFactory, this.boxDecoration})
      : issueBallDisPlayUseCase = IssueBallDisPlayUseCase(
            fBallResDto: ballListMediator.itemList[index]),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => IssueBallNotHaveImageWidgetViewModel(
          context: context, ballListMediator: ballListMediator, index: index),
      child: Consumer<IssueBallNotHaveImageWidgetViewModel>(
        builder: (_, model, __) {
          return Container(
              child: Column(
                children: <Widget>[
                  IssueBallTopBar(ballDisPlayUseCase: issueBallDisPlayUseCase),
                  Divider(
                    color: Color(0xffF4F4F6).withOpacity(0.9),
                    height: 1,
                    thickness: 1,
                  ),
                  BallTitleInfoBar(
                    ballDisPlayUseCase: issueBallDisPlayUseCase,
                    gotoDetailPage: model.moveToDetailPage,
                    showOptionPopUp: BasicBallOptionPopup(
                        ballOptionWidgetFactory
                            .getBallOptionWidget(BallOptionWidgetFactoryParams(
                                fBallResDto:
                                    issueBallDisPlayUseCase.fBallResDto,
                                ballListMediator: ballListMediator))),
                  ),
                  BallTextWidget(
                    gotoDetailPage: model.moveToDetailPage,
                    ballDisPlayUseCase: issueBallDisPlayUseCase,
                  )
                ],
              ),
              decoration: boxDecoration);
        },
      ),
    );
  }
}

class IssueBallNotHaveImageWidgetViewModel extends ListUpBallWidgetItem {
  IssueBallNotHaveImageWidgetViewModel(
      {BuildContext context, BallListMediator ballListMediator, int index})
      : super(context, ballListMediator, index);
}
