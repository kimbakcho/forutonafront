import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/AppBis/FBall/Domain/UseCase/BallDisPlayUseCase/IssueBallDisPlayUseCase.dart';
import 'package:forutonafront/AppBis/FBall/Domain/UseCase/selectBall/SelectBallUseCaseInputPort.dart';
import 'package:forutonafront/Components/BallListUp/BallListMediator.dart';
import 'package:forutonafront/AppBis/FBall/Domain/UseCase/BallDisPlayUseCase/BallDisPlayUseCase.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import 'ListUpBallWidgetItem.dart';
import 'ReduceSizeAddressBar.dart';
import 'ReduceSizeBallTitleWidget.dart';
import 'ReduceSizeImageWidget.dart';
import 'ReduceSizeTopBar.dart';

class IssueBallReduceSizeWidget extends StatelessWidget {
  final BallDisPlayUseCase issueBallDisPlayUseCase;
  final BallListMediator ballListMediator;
  final int index;
  final BoxDecoration boxDecoration;

  const IssueBallReduceSizeWidget(
      {Key key,
      this.ballListMediator,
      this.index,
      this.issueBallDisPlayUseCase,
      this.boxDecoration})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => IssueBallReduceSizeWidgetViewModel(
              sl(),
              context: context,
              ballListMediator: ballListMediator,
              index: index,
              issueBallDisPlayUseCase: issueBallDisPlayUseCase,
            ),
        child: Consumer<IssueBallReduceSizeWidgetViewModel>(
            builder: (_, model, __) {
          return Material(
              color: boxDecoration != null ? boxDecoration.color : Colors.white,
              borderRadius:
                  boxDecoration != null ? boxDecoration.borderRadius : null,
              child: InkWell(
                  onTap: () {
                    model.moveToDetailPage();
                  },
                  child: Stack(
                    children: [
                      Container(
                          padding: EdgeInsets.fromLTRB(14, 16, 14, 16),
                          child: Column(children: [
                            ReduceSizeTopBar(
                                issueBallDisPlayUseCase:
                                    model.issueBallDisPlayUseCase),
                            SizedBox(
                              height: 11,
                            ),
                            Row(children: [
                              Expanded(
                                  child: Column(children: [
                                ReduceSizeBallTitleWidget(
                                    issueBallDisPlayUseCase:
                                        model.issueBallDisPlayUseCase),
                                SizedBox(
                                  height: 3,
                                ),
                                ReduceSizeAddressBar(
                                    issueBallDisPlayUseCase:
                                        model.issueBallDisPlayUseCase)
                              ])),
                              Container(
                                width: 70,
                                height: 53,
                                child: model.issueBallDisPlayUseCase
                                        .isMainPicture()
                                    ? ReduceSizeImageWidget(
                                        issueBallDisPlayUseCase:
                                            model.issueBallDisPlayUseCase)
                                    : Container(),
                              )
                            ]),
                          ])),
                      model.isFinishBall
                          ? Positioned.fill(
                              child: Container(
                              child: Center(
                                child: Text(
                                  '종료된',
                                  style: GoogleFonts.notoSans(
                                    fontSize: 18,
                                    color: const Color(0xffffffff),
                                    height: 0.7777777777777778,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                color: Colors.black.withOpacity(0.4),
                              ),
                            ))
                          : Container()
                    ],
                  )));
        }));
  }
}

class IssueBallReduceSizeWidgetViewModel extends ListUpBallWidgetItem {
  BallDisPlayUseCase issueBallDisPlayUseCase;
  final SelectBallUseCaseInputPort _selectBallUseCaseInputPort;

  IssueBallReduceSizeWidgetViewModel(this._selectBallUseCaseInputPort,
      {this.issueBallDisPlayUseCase,
      BuildContext context,
      BallListMediator ballListMediator,
      int index})
      : super(context, ballListMediator, index,sl());

  bool get isFinishBall {
    return ballListMediator.itemList[index].activationTime
        .isBefore(DateTime.now());
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
