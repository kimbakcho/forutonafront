import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/AppBis/FBall/Domain/UseCase/BallDisPlayUseCase/IssueBallDisPlayUseCase.dart';
import 'package:forutonafront/AppBis/FBall/Domain/UseCase/selectBall/SelectBallUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/AppBis/Tag/Domain/UseCase/TagFromBallUuid/TagFromBallUuidUseCaseInputPort.dart';
import 'package:forutonafront/Components/BallListUp/BallListMediator.dart';
import 'package:forutonafront/AppBis/FBall/Domain/UseCase/BallDisPlayUseCase/BallDisPlayUseCase.dart';
import 'package:forutonafront/Page/ICodePage/ID01/ID01MainPage.dart';
import 'package:forutonafront/Page/ICodePage/ID01/ID01Mode.dart';
import 'package:forutonafront/Page/ICodePage/IM001/IM001MainPage.dart';
import 'package:forutonafront/Page/ICodePage/IM001/IM001Mode.dart';
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
              sl(),
              context: context,
              ballListMediator: ballListMediator,
              index: index,
              issueBallDisPlayUseCase: issueBallDisPlayUseCase,
            ),
        child: Consumer<IssueBallReduceSizeWidgetViewModel>(
            builder: (_, model, __) {
          if (model.isBallDelete) {
            return Container(width: 0, height: 0);
          }
          return Container(
            decoration: BoxDecoration(
              borderRadius: boxDecoration.borderRadius,
              border: boxDecoration.border,
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.16),
                    offset: Offset(0,4),
                    blurRadius: 16
                )
              ]
            ),
            child: Material(
                color:
                    boxDecoration != null ? boxDecoration.color : Colors.white,
                borderRadius:
                    boxDecoration != null ? boxDecoration.borderRadius : null,
                child: InkWell(
                    onTap: () {
                      model.moveToDetailPage();
                    },
                    child: Stack(
                      children: [
                        Container(
                            padding: EdgeInsets.fromLTRB(14, 16, 14, 15),
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
                    ))),
          );
        }));
  }
}

class IssueBallReduceSizeWidgetViewModel extends ListUpBallWidgetItem {
  BallDisPlayUseCase issueBallDisPlayUseCase;
  final SelectBallUseCaseInputPort _selectBallUseCaseInputPort;
  final TagFromBallUuidUseCaseInputPort _tagFromBallUuidUseCaseInputPort;

  IssueBallReduceSizeWidgetViewModel(
      this._selectBallUseCaseInputPort, this._tagFromBallUuidUseCaseInputPort,
      {this.issueBallDisPlayUseCase,
      BuildContext context,
      BallListMediator ballListMediator,
      int index})
      : super(context, ballListMediator, index, sl(), sl(), sl(), sl(), sl());

  bool get isFinishBall {
    return ballListMediator.itemList[index].activationTime
        .isBefore(DateTime.now());
  }

  bool get isBallDelete {
    return ballListMediator.itemList[index].ballDeleteFlag;
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

  @override
  Widget detailPage() {
    return ID01MainPage(
      ballUuid: ballListMediator.itemList[index].ballUuid,
      fBallResDto: ballListMediator.itemList[index],
    );
  }

  @override
  Future<void> onModifyBall(BuildContext context) async {
    var tags = await _tagFromBallUuidUseCaseInputPort.getTagFromBallUuid(
        ballUuid: ballListMediator.itemList[index].ballUuid);
    var result =
        await Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return IM001MainPage(
        preSetBallResDto: ballListMediator.itemList[index],
        im001mode: IM001Mode.modify,
        preSetFBallTagResDtos: tags,
      );
    }));
  }
}
