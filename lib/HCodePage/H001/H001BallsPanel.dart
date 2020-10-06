import 'package:flutter/material.dart';
import 'package:forutonafront/Common/PageScrollController/PageScrollController.dart';
import 'package:forutonafront/Components/BallListUp/BallListMediator.dart';
import 'package:forutonafront/Components/BallListUp/FullBallListUp.dart';
import 'package:forutonafront/Components/TagList/RankingTagListFromBI.dart';
import 'package:forutonafront/Components/TagList/RankingTagListMediator.dart';
import 'package:provider/provider.dart';

class H001BallsPanel extends StatelessWidget {
  final RankingTagListMediator rankingTagListFromBIManager;
  final BallListMediator ballListMediator;
  final FullBallListUpController fullBallListUpController;

  const H001BallsPanel({
    Key key,
    @required this.ballListMediator,
    @required this.rankingTagListFromBIManager,
    this.fullBallListUpController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => H001BallsPanelViewModel(
          ballListMediator: this.ballListMediator,
          rankingTagListFromBIManager: this.rankingTagListFromBIManager,
          fullBallListUpController: fullBallListUpController),
      child: Consumer<H001BallsPanelViewModel>(
        builder: (_, model, __) {
          return Container(
            child: ListView(
              controller: PageScrollController(
                      scrollController: ScrollController(),
                      onNextPage: model.onNextPage,
                      onRefreshFirst: model.onRefreshFirst).scrollController,
              physics: BouncingScrollPhysics(),
              children: <Widget>[
                RankingTagListFromBI(
                    rankingTagListMediator: model.rankingTagListFromBIManager),
                FullBallListUp(
                  ballListMediator: model.ballListMediator,
                  physics: ScrollPhysics(),
                  fullBallListUpController: fullBallListUpController,
                )
              ],
              padding: EdgeInsets.all(0),
            ),
          );
        },
      ),
    );
  }
}

class H001BallsPanelViewModel extends ChangeNotifier
    implements BallListMediatorComponent, RankingTagListMediatorComponent {
  final BallListMediator ballListMediator;
  final RankingTagListMediator rankingTagListFromBIManager;
  final FullBallListUpController fullBallListUpController;

  H001BallsPanelViewModel(
      {this.ballListMediator,
      this.rankingTagListFromBIManager,
      this.fullBallListUpController}) {
    ballListMediator.registerComponent(this);
    rankingTagListFromBIManager.registerComponent(this);
  }

  onRefreshFirst() async {
    await fullBallListUpController.onRefreshFirst();
  }

  onNextPage() async {
    await fullBallListUpController.onNextPage();
  }

  @override
  void dispose() {
    rankingTagListFromBIManager.unregisterComponent(this);
    ballListMediator.unregisterComponent(this);
    super.dispose();
  }

  @override
  void onBallListUpUpdate() {
    notifyListeners();
  }

  @override
  void onTagListUpdate() {
    notifyListeners();
  }

  @override
  void onBallListEmpty() {

  }
}
