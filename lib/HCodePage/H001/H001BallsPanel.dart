import 'package:flutter/material.dart';
import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart';
import 'package:forutonafront/Components/BallListUp/BallListMediator.dart';
import 'package:forutonafront/Components/BallListUp/FullBallListUp.dart';
import 'package:forutonafront/Components/TagList/RankingTagListFromBI.dart';
import 'package:forutonafront/Components/TagList/RankingTagListMediator.dart';
import 'package:provider/provider.dart';

class H001BallsPanel extends StatelessWidget {
  final RankingTagListMediator rankingTagListFromBIManager;
  final BallListMediator ballListMediator;

  const H001BallsPanel({
    Key key,
    @required this.ballListMediator,
    @required this.rankingTagListFromBIManager,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => H001BallsPanelViewModel(
          ballListMediator: this.ballListMediator,
          rankingTagListFromBIManager: this.rankingTagListFromBIManager),
      child: Consumer<H001BallsPanelViewModel>(
        builder: (_, model, __) {
          return Container(
            child: ListView(
              children: <Widget>[
                RankingTagListFromBI(
                    rankingTagListMediator:
                        model.rankingTagListFromBIManager),
                FullBallListUp(ballListMediator: model.ballListMediator)
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

  H001BallsPanelViewModel(
      {this.ballListMediator, this.rankingTagListFromBIManager}) {
    ballListMediator.registerComponent(this);
    rankingTagListFromBIManager.registerComponent(this);
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
  void onTagListUpdate()  {
    notifyListeners();
  }
}
