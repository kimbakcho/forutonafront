import 'package:flutter/material.dart';
import 'package:forutonafront/Components/BallListUp/BallListMediator.dart';
import 'package:forutonafront/Components/TagList/RankingTagListMediator.dart';
import 'package:forutonafront/HCodePage/H001/H001BallsPanel.dart';

import 'H001EmptyMessagePanel.dart';

class H001BodyFactory {
  static Widget getBodyWidget(
      {BallListMediator ballListMediator,
      RankingTagListMediator rankingTagListFromBIManager}) {
    if (ballListMediator.currentState == BallListMediatorState.Loading) {
      return Container();
    } else if (ballListMediator.currentState == BallListMediatorState.HasBall) {
      return H001BallsPanel(
          ballListMediator: ballListMediator,
          rankingTagListFromBIManager: rankingTagListFromBIManager);
    } else if (ballListMediator.currentState == BallListMediatorState.Empty) {
      return H001EmptyMessagePanel();
    } else {
      return Container();
    }
  }
}
