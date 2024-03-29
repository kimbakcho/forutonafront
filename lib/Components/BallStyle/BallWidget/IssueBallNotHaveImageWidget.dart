import 'package:flutter/material.dart';
import 'package:forutonafront/AppBis/FBall/Domain/UseCase/selectBall/SelectBallUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/AppBis/Tag/Domain/UseCase/TagFromBallUuid/TagFromBallUuidUseCaseInputPort.dart';
import 'package:forutonafront/Components/BallListUp/BallListMediator.dart';
import 'package:forutonafront/Components/BallStyle/BallWidget/IssueBallTopBar.dart';
import 'package:forutonafront/AppBis/FBall/Domain/UseCase/BallDisPlayUseCase/IssueBallDisPlayUseCase.dart';
import 'package:forutonafront/Page/ICodePage/ID01/ID01MainPage.dart';
import 'package:forutonafront/Components/DetailPage/DBallMode.dart';
import 'package:forutonafront/Page/ICodePage/IM001/IM001MainPage.dart';
import 'package:forutonafront/Page/MakeCommonPage/MakePageMode.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import 'BallPositionInfoBar.dart';
import 'BallTextWidget.dart';
import 'BallTitleInfoBar.dart';
import 'ListUpBallWidgetItem.dart';

class IssueBallNotHaveImageWidget extends StatelessWidget {
  final int index;
  final BallListMediator? ballListMediator;
  final BoxDecoration? boxDecoration;

  IssueBallNotHaveImageWidget(
      {Key? key,required this.index, this.ballListMediator, this.boxDecoration})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          IssueBallNotHaveImageWidgetViewModel(sl(), sl(),
              context: context,
              ballListMediator: ballListMediator!,
              index: index),
      child: Consumer<IssueBallNotHaveImageWidgetViewModel>(
        builder: (_, model, __) {
          return model.issueBallDisPlayUseCase!.fBallResDto!.ballDeleteFlag
              ? Container(
            width: 0,
            height: 0,
          )
              : Container(
            child: Material(
              color: Colors.white,
              borderRadius: boxDecoration!.borderRadius,
              child: InkWell(
                onTap: () {
                  model.moveToDetailPage();
                },
                child: Container(
                    child: Column(
                      key: Key(model.ballWidgetKey!),
                      children: <Widget>[
                        IssueBallTopBar(
                            ballDisPlayUseCase:
                            model.issueBallDisPlayUseCase!),
                        Divider(
                          color: Color(0xffF4F4F6).withOpacity(0.9),
                          height: 1,
                          thickness: 1,
                        ),
                        BallTitleInfoBar(
                          ballDisPlayUseCase: model.issueBallDisPlayUseCase!,
                        ),
                        BallTextWidget(
                          gotoDetailPage: model.moveToDetailPage,
                          ballDisPlayUseCase: model.issueBallDisPlayUseCase!,
                        ),
                        BallPositionInfoBar(
                          ballSearchPosition: ballListMediator!.searchPosition()!,
                          ballDisPlayUseCase: model.issueBallDisPlayUseCase!,
                        )
                      ],
                    ),
                    decoration: boxDecoration),
              ),
            ),
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.16),
                      offset: Offset(0, 4),
                      blurRadius: 16)
                ]
            ),
          ) ;
        },
      ),
    );
  }
}

class IssueBallNotHaveImageWidgetViewModel extends ListUpBallWidgetItem {
  IssueBallDisPlayUseCase? issueBallDisPlayUseCase;
  final SelectBallUseCaseInputPort? _selectBallUseCaseInputPort;

  final TagFromBallUuidUseCaseInputPort? _tagFromBallUuidUseCaseInputPort;

  IssueBallNotHaveImageWidgetViewModel(this._selectBallUseCaseInputPort,
      this._tagFromBallUuidUseCaseInputPort,
      {required BuildContext context,required BallListMediator ballListMediator,required int index})
      : super(
      context,
      ballListMediator,
      index,
      sl(),
      sl(),
      sl(),
      sl(),
      sl()) {
    var item = ballListMediator.itemList[index];
    if(item != null){
      issueBallDisPlayUseCase = IssueBallDisPlayUseCase(
          fBallResDto: item, geoLocatorAdapter: sl());
    }
  }

  @override
  onReFreshBall() async {
    var item = ballListMediator!.itemList[index!];
    if(item != null){
      item = await _selectBallUseCaseInputPort!
          .selectBall(item.ballUuid!);
      issueBallDisPlayUseCase = IssueBallDisPlayUseCase(
          fBallResDto: item, geoLocatorAdapter: sl());
      ballWidgetKey = Uuid().v4();
    }
    notifyListeners();
  }

  @override
  Widget detailPage() {

    var item = ballListMediator!.itemList[index!];

    return item != null ? ID01MainPage(
      ballUuid: item.ballUuid!,
      fBallResDto: item,
    ) : Container();
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
