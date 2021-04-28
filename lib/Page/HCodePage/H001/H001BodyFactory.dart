import 'package:flutter/material.dart';
import 'package:forutonafront/Common/SearchCollectMediator/SearchCollectMediator.dart';
import 'package:forutonafront/Components/BallListUp/BallListMediator.dart';
import 'package:forutonafront/Components/BallListUp/FullBallListUp.dart';
import 'package:forutonafront/Components/TagList/RankingTagListMediator.dart';
import 'package:forutonafront/Page/HCodePage/H001/H001BallsPanel.dart';

import 'H001EmptyMessagePanel.dart';

class H001BodyFactory {
  static Widget getBodyWidget(
      {BallListMediator? ballListMediator,
      RankingTagListMediator? rankingTagListFromBIManager}) {
    if (ballListMediator!.currentState == SearchCollectMediatorState.HasItem) {
      return H001BallsPanel(
          ballListMediator: ballListMediator,
          fullBallListUpController: FullBallListUpController(),
          rankingTagListFromBIManager: rankingTagListFromBIManager!);
    } else if (ballListMediator.currentState == SearchCollectMediatorState.Empty) {
      return H001EmptyMessagePanel();
    } else {
      return Container();
    }
  }
}
