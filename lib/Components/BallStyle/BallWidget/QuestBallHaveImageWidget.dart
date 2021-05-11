import 'package:flutter/material.dart';
import 'package:forutonafront/AppBis/FBall/Domain/UseCase/BallDisPlayUseCase/BallDisPlayUseCase.dart';
import 'package:forutonafront/AppBis/FBall/Domain/UseCase/BallDisPlayUseCase/IssueBallDisPlayUseCase.dart';
import 'package:forutonafront/AppBis/FBall/Domain/UseCase/DeleteBall/DeleteBallUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/FBall/Domain/UseCase/HitBall/HitBallUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/FBall/Domain/UseCase/NoInterestBallUseCase/NoInterestBallUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/FBall/Domain/UseCase/selectBall/SelectBallUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/FUser/SigInInUserInfoUseCase/SignInUserInfoUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/MaliciousBall/Domain/UseCase/MaliciousBallUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/Tag/Domain/UseCase/TagFromBallUuid/TagFromBallUuidUseCaseInputPort.dart';
import 'package:forutonafront/Components/BallListUp/BallListMediator.dart';
import 'package:forutonafront/Page/QDCodePage/QD01/QD01MainPage.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:provider/provider.dart';

import 'ListUpBallWidgetItem.dart';

class QuestBallHaveImageWidget extends StatelessWidget {
  final int index;

  final BallListMediator ballListMediator;

  const QuestBallHaveImageWidget(
      {Key? key, required this.index, required this.ballListMediator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          QuestBallHaveImageWidgetViewModel(
              context: context,
              ballListMediator: ballListMediator,
              index: index,
              selectBallUseCaseInputPort: sl(),
              tagFromBallUuidUseCaseInputPort: sl()
          ),
      child: Consumer<QuestBallHaveImageWidgetViewModel>(
        builder: (_, model, child) {
          return Container(
            child: TextButton(
              child: Text("Quest1 ${model.questBallDisPlayUseCase.ballName()}"),
              onPressed: () {
                model.moveToDetailPage();
              },
            ),
          );
        },
      ),
    );
  }
}

class QuestBallHaveImageWidgetViewModel extends ListUpBallWidgetItem {
  late BallDisPlayUseCase questBallDisPlayUseCase;
  SelectBallUseCaseInputPort? selectBallUseCaseInputPort;
  TagFromBallUuidUseCaseInputPort? tagFromBallUuidUseCaseInputPort;

  BuildContext context;

  QuestBallHaveImageWidgetViewModel({
    this.selectBallUseCaseInputPort,
    this.tagFromBallUuidUseCaseInputPort,
    required this.context,
    required BallListMediator ballListMediator,
    required int index})
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
    if (item != null) {
      questBallDisPlayUseCase = IssueBallDisPlayUseCase(
          fBallResDto: item, geoLocatorAdapter: sl());
    }
  }



  @override
  Widget detailPage() {
    var item = ballListMediator!.itemList[index!];
    return QD01MainPage(ballUuid: item!.ballUuid!,fBallResDto: item);
  }

  @override
  Future<void> onModifyBall(BuildContext context) {
    // TODO: implement onModifyBall
    throw UnimplementedError();
  }

  @override
  onReFreshBall() {
    // TODO: implement onReFreshBall
    throw UnimplementedError();
  }
}
