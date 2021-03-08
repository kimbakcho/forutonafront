import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/AppBis/FBall/Domain/UseCase/HitBall/HitBallUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/FBall/Domain/Value/FBallType.dart';
import 'package:forutonafront/Components/BallListUp/BallListMediator.dart';
import 'package:forutonafront/Components/DetailPageViewer/DetailPageViewer.dart';
import 'package:forutonafront/Page/ICodePage/ID01/ID01MainPage.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:uuid/uuid.dart';

abstract class ListUpBallWidgetItem extends ChangeNotifier {
  final BuildContext context;
  final BallListMediator ballListMediator;
  final int index;
  final HitBallUseCaseInputPort hitBallUseCaseInputPort;
  String ballWidgetKey;

  ListUpBallWidgetItem(this.context, this.ballListMediator, this.index,
      this.hitBallUseCaseInputPort) {
    ballWidgetKey = Uuid().v4();
  }

  moveToDetailPage() async {
    var hits = await hitBallUseCaseInputPort.hit(ballListMediator.itemList[index].ballUuid);
    ballListMediator.itemList[index].ballHits = hits;
    await Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      var ballType2 = ballListMediator.itemList[index].ballType;
      switch (ballType2) {
        case FBallType.IssueBall:
          return ID01MainPage(
            ballUuid: ballListMediator.itemList[index].ballUuid,
            fBallResDto: ballListMediator.itemList[index],
          );
        case FBallType.QuestBall:
          return Container();
        default:
          return Container();
      }
      // return DetailPageViewer(
      //   ballListMediator: ballListMediator,
      //   detailPageItemFactory: sl(),
      //   initIndex: index,
      // );
    }));
    onReFreshBall();
  }

  onReFreshBall();
}
