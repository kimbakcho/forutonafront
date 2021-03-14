import 'package:flutter/material.dart';
import 'package:forutonafront/AppBis/FBall/Domain/UseCase/selectBall/SelectBallUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/Tag/Domain/UseCase/TagFromBallUuid/TagFromBallUuidUseCaseInputPort.dart';
import 'package:forutonafront/Components/BallListUp/BallListMediator.dart';
import 'package:forutonafront/AppBis/FBall/Domain/UseCase/BallDisPlayUseCase/BallDisPlayUseCase.dart';
import 'package:forutonafront/AppBis/FBall/Domain/UseCase/BallDisPlayUseCase/IssueBallDisPlayUseCase.dart';
import 'package:forutonafront/Page/ICodePage/ID01/ID01MainPage.dart';
import 'package:forutonafront/Page/ICodePage/IM001/IM001MainPage.dart';
import 'package:forutonafront/Page/ICodePage/IM001/IM001Mode.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'BallBigImagePanelWidget.dart';
import 'BallPositionInfoBar.dart';
import 'BallTitleInfoBar.dart';
import 'IssueBallTopBar.dart';
import 'ListUpBallWidgetItem.dart';

class IssueBallHaveImageWidget extends StatelessWidget {
  final int index;

  final BallListMediator ballListMediator;
  final BoxDecoration boxDecoration;

  IssueBallHaveImageWidget(
      {Key key,
      this.index,
      this.ballListMediator,
      this.boxDecoration})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => IssueBallHaveImageWidgetViewModel(sl(), sl(),
          context: context, ballListMediator: ballListMediator, index: index),
      child: Consumer<IssueBallHaveImageWidgetViewModel>(
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
                      BallBigImagePanelWidget(
                          ballDisPlayUseCase: model.issueBallDisPlayUseCase),
                      BallTitleInfoBar(
                        ballDisPlayUseCase: model.issueBallDisPlayUseCase,
                        gotoDetailPage: model.moveToDetailPage,
                        showOptionPopUp: model.showOptionPopUp,
                      ),
                      Divider(
                        color: Color(0xffF4F4F6).withOpacity(0.9),
                        height: 1,
                        thickness: 1,
                      ),
                      BallPositionInfoBar(
                        gotoDetailPage: model.moveToDetailPage,
                        ballSearchPosition: ballListMediator.searchPosition(),
                        ballDisPlayUseCase: model.issueBallDisPlayUseCase,
                      )
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
  BallDisPlayUseCase issueBallDisPlayUseCase;
  final SelectBallUseCaseInputPort _selectBallUseCaseInputPort;

  final TagFromBallUuidUseCaseInputPort _tagFromBallUuidUseCaseInputPort;

  IssueBallHaveImageWidgetViewModel(
      this._selectBallUseCaseInputPort, this._tagFromBallUuidUseCaseInputPort,
      {BuildContext context, BallListMediator ballListMediator, int index})
      : super(context, ballListMediator, index, sl(), sl(), sl(), sl(),sl()) {
    issueBallDisPlayUseCase = IssueBallDisPlayUseCase(
        fBallResDto: ballListMediator.itemList[index], geoLocatorAdapter: sl());
  }

  @override
  onReFreshBall() async {
    ballListMediator.itemList[index] = await _selectBallUseCaseInputPort
        .selectBall(ballListMediator.itemList[index].ballUuid);
    issueBallDisPlayUseCase = IssueBallDisPlayUseCase(
        fBallResDto: ballListMediator.itemList[index], geoLocatorAdapter: sl());
    ballWidgetKey = Uuid().v4();
    notifyListeners();
  }

  onModifyBall(BuildContext context) async {
    var tags = await _tagFromBallUuidUseCaseInputPort.getTagFromBallUuid(
        ballUuid: ballListMediator.itemList[index].ballUuid);
    await Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return IM001MainPage(
        preSetBallResDto: ballListMediator.itemList[index],
        im001mode: IM001Mode.modify,
        preSetFBallTagResDtos: tags,
      );
    }));
    Navigator.of(context).pop();
  }

  @override
  Widget detailPage() {
    return ID01MainPage(
      ballUuid: ballListMediator.itemList[index].ballUuid,
      fBallResDto: ballListMediator.itemList[index],
    );
  }
}
