import 'package:flutter/material.dart';
import 'package:forutonafront/Components/BallListUp/BallListMediator.dart';
import 'package:forutonafront/Components/BallListUp/FullBallListUp.dart';
import 'package:forutonafront/Components/TagList/RankingTagListFromBI.dart';
import 'package:forutonafront/Components/TagList/RankingTagListFromBIManager.dart';
import 'package:forutonafront/HCodePage/H001/H001ViewModel.dart';
import 'package:forutonafront/MainPage/BottomNavigation.dart';
import 'package:provider/provider.dart';

class H001Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => H001ViewModel(
            ballListMediator: BallListMediatorImpl(),
            rankingTagListFromBIManager: RankingTagListFromBIManager()),
        child: Consumer<H001ViewModel>(builder: (_, model, __) {
          return Scaffold(
              body: Container(
                  color: Color(0xfff2f0f1),
                  child: Stack(children: <Widget>[
                    Column(
                      children: <Widget>[
                        Expanded(
                          child: ListView(
                            children: <Widget>[
                              RankingTagListFromBI(
                                  rankingTagListFromBIManager:
                                      model.rankingTagListFromBIManager),
                              FullBallListUp(
                                  ballListMediator: model.ballListMediator)
                            ],
                            padding: EdgeInsets.all(0),
                          ),
                        ),
                        BottomNavigation()
                      ],
                    ),
                  ])));
        }));
  }
}
