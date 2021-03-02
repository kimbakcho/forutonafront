import 'package:flutter/material.dart';
import 'package:forutonafront/AppBis/FBall/Domain/UseCase/selectBall/SelectBallUseCaseInputPort.dart';
import 'package:forutonafront/Components/BallListUp/BallListMediator.dart';
import 'package:forutonafront/Components/BallStyle/BallOptionPopup/BallOptionPopup.dart';
import 'package:forutonafront/Components/BallStyle/BallOptionPopup/BallOptionWidgetFactory.dart';
import 'package:forutonafront/Components/BallStyle/BallWidget/IssueBallTopBar.dart';
import 'package:forutonafront/AppBis/FBall/Domain/UseCase/BallDisPlayUseCase/BallDisPlayUseCase.dart';
import 'package:forutonafront/AppBis/FBall/Domain/UseCase/BallDisPlayUseCase/IssueBallDisPlayUseCase.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import 'BallTextWidget.dart';
import 'BallTitleInfoBar.dart';
import 'ListUpBallWidgetItem.dart';

class IssueBallNotHaveImageWidget extends StatelessWidget {
  final int index;
  final BallListMediator ballListMediator;
  final BallOptionWidgetFactory ballOptionWidgetFactory;
  final BoxDecoration boxDecoration;

  IssueBallNotHaveImageWidget(
      {Key key,
      this.index,
      this.ballListMediator,
      this.ballOptionWidgetFactory,
      this.boxDecoration})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => IssueBallNotHaveImageWidgetViewModel(sl(),
          context: context, ballListMediator: ballListMediator, index: index),
      child: Consumer<IssueBallNotHaveImageWidgetViewModel>(
        builder: (_, model, __) {
          return model.issueBallDisPlayUseCase.fBallResDto.ballDeleteFlag
              ? Container(
                  width: 0,
                  height: 0,
                )
              : Container(
                  child: Column(
                    key: Key(model.ballWidgetKey),
                    children: <Widget>[
                      IssueBallTopBar(
                          ballDisPlayUseCase: model.issueBallDisPlayUseCase),
                      Divider(
                        color: Color(0xffF4F4F6).withOpacity(0.9),
                        height: 1,
                        thickness: 1,
                      ),
                      BallTitleInfoBar(
                        ballDisPlayUseCase: model.issueBallDisPlayUseCase,
                        gotoDetailPage: model.moveToDetailPage,
                        showOptionPopUp: BasicBallOptionPopup(
                            ballOptionWidgetFactory.getBallOptionWidget(
                                BallOptionWidgetFactoryParams(
                                    fBallResDto: model
                                        .issueBallDisPlayUseCase.fBallResDto,
                                    ballListMediator: ballListMediator))),
                      ),
                      BallTextWidget(
                        gotoDetailPage: model.moveToDetailPage,
                        ballDisPlayUseCase: model.issueBallDisPlayUseCase,
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
  IssueBallDisPlayUseCase issueBallDisPlayUseCase;
  final SelectBallUseCaseInputPort _selectBallUseCaseInputPort;

  IssueBallNotHaveImageWidgetViewModel(this._selectBallUseCaseInputPort,
      {BuildContext context, BallListMediator ballListMediator, int index})
      : super(context, ballListMediator, index) {
    issueBallDisPlayUseCase =
        IssueBallDisPlayUseCase(fBallResDto: ballListMediator.itemList[index]);
  }

  @override
  onReFreshBall() async {
    ballListMediator.itemList[index] = await _selectBallUseCaseInputPort
        .selectBall(ballListMediator.itemList[index].ballUuid);
    issueBallDisPlayUseCase =
        IssueBallDisPlayUseCase(fBallResDto: ballListMediator.itemList[index]);
    ballWidgetKey = Uuid().v4();
    notifyListeners();
  }
}
