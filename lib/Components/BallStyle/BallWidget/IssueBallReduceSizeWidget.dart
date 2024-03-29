import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/AppBis/FBall/Domain/UseCase/BallDisPlayUseCase/IssueBallDisPlayUseCase.dart';
import 'package:forutonafront/AppBis/FBall/Domain/UseCase/selectBall/SelectBallUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/AppBis/Tag/Domain/UseCase/TagFromBallUuid/TagFromBallUuidUseCaseInputPort.dart';
import 'package:forutonafront/Components/BallListUp/BallListMediator.dart';
import 'package:forutonafront/AppBis/FBall/Domain/UseCase/BallDisPlayUseCase/BallDisPlayUseCase.dart';
import 'package:forutonafront/Page/ICodePage/ID01/ID01MainPage.dart';
import 'package:forutonafront/Components/DetailPage/DBallMode.dart';
import 'package:forutonafront/Page/ICodePage/IM001/IM001MainPage.dart';
import 'package:forutonafront/Page/MakeCommonPage/MakePageMode.dart';
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
  final BallDisPlayUseCase? issueBallDisPlayUseCase;
  final BallListMediator? ballListMediator;
  final int? index;
  final BoxDecoration? boxDecoration;

  const IssueBallReduceSizeWidget(
      {Key? key,
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
              ballListMediator: ballListMediator!,
              index: index!,
              issueBallDisPlayUseCase: issueBallDisPlayUseCase!,
            ),
        child: Consumer<IssueBallReduceSizeWidgetViewModel>(
            builder: (_, model, __) {
          if (model.isBallDelete) {
            return Container(width: 0, height: 0);
          }
          return Container(
            decoration: BoxDecoration(
                borderRadius: boxDecoration!.borderRadius,
                border: boxDecoration!.border,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.16),
                      offset: Offset(0, 4),
                      blurRadius: 16)
                ]),
            child: Material(
                color:
                    boxDecoration != null ? boxDecoration!.color : Colors.white,
                borderRadius:
                    boxDecoration != null ? boxDecoration!.borderRadius : null,
                child: InkWell(
                    onTap: () {
                      model.moveToDetailPage();
                    },
                    child: Stack(
                      children: [
                        Container(
                            padding: EdgeInsets.fromLTRB(14, 16, 14, 14),
                            child: Column(children: [
                              ReduceSizeTopBar(
                                  issueBallDisPlayUseCase:
                                      model.issueBallDisPlayUseCase!),
                              SizedBox(
                                height: 11,
                              ),
                              Row(children: [
                                Expanded(
                                    child: Column(children: [
                                  ReduceSizeBallTitleWidget(
                                      issueBallDisPlayUseCase:
                                          model.issueBallDisPlayUseCase!),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  ReduceSizeAddressBar(
                                      issueBallDisPlayUseCase:
                                          model.issueBallDisPlayUseCase!)
                                ])),
                                Container(
                                  width: 70,
                                  height: 53,
                                  child: model.issueBallDisPlayUseCase!
                                          .isMainPicture()
                                      ? ReduceSizeImageWidget(
                                          issueBallDisPlayUseCase:
                                              model.issueBallDisPlayUseCase!)
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
  BallDisPlayUseCase? issueBallDisPlayUseCase;
  final SelectBallUseCaseInputPort? _selectBallUseCaseInputPort;
  final TagFromBallUuidUseCaseInputPort? _tagFromBallUuidUseCaseInputPort;

  IssueBallReduceSizeWidgetViewModel(
      this._selectBallUseCaseInputPort, this._tagFromBallUuidUseCaseInputPort,
      {this.issueBallDisPlayUseCase,
      required BuildContext context,
      required BallListMediator ballListMediator,
      required int index})
      : super(context, ballListMediator, index, sl(), sl(), sl(), sl(), sl());

  bool get isFinishBall {
    var item = ballListMediator!.itemList[index!];
    return item != null ? item.activationTime!
        .isBefore(DateTime.now()) : false;
  }

  bool get isBallDelete {
    var item = ballListMediator!.itemList[index!];

    return item != null ? item.ballDeleteFlag : false;
  }

  @override
  onReFreshBall() async {
    var item = ballListMediator!.itemList[index!];
    if(item != null){
      item = await _selectBallUseCaseInputPort!
          .selectBall(item.ballUuid!);

      issueBallDisPlayUseCase =
          IssueBallDisPlayUseCase(fBallResDto: item);
      ballWidgetKey = Uuid().v4();
    }
    notifyListeners();
  }

  @override
  Widget detailPage() {
    var item  = ballListMediator!.itemList[index!];

    return item != null ? ID01MainPage(
      ballUuid: item .ballUuid!,
      fBallResDto: item ,
    ): Container();
  }

  @override
  Future<void> onModifyBall(BuildContext context) async {
    var item = ballListMediator!.itemList[index!];
    if(item != null){
      var tags = await _tagFromBallUuidUseCaseInputPort!.getTagFromBallUuid(
          ballUuid: item.ballUuid!);
      var result =
      await Navigator.of(context).push(MaterialPageRoute(builder: (_) {
        return IM001MainPage(
          preSetBallResDto: item,
          makePageMode: MakePageMode.modify,
          preSetFBallTagResDtos: tags,
        );
      }));
    }

  }
}
