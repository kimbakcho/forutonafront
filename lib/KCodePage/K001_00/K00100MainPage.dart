import 'package:flutter/material.dart';
import 'package:forutonafront/Components/BallNameCollectWidget/SimpleBallNameCollectWidget.dart';
import 'package:forutonafront/Components/TagContainBallCollectWidget/TagContainBallCollectWidget.dart';
import 'package:forutonafront/Components/UserInfoCollectionWidget/SimpleUserInfoCollectWidget.dart';
import 'package:provider/provider.dart';

import '../KCodeScrollerControllerAniBuilder.dart';
import '../KCodeScrollerControllerBtn.dart';
import '../KRankingTagListWidget.dart';

class K00100MainPage extends StatelessWidget {
  final String searchText;
  final SimpleUserInfoCollectListener simpleUserInfoCollectListener;
  final SimpleBallNameCollectListener simpleBallNameCollectListener;
  final TagContainBallCollectListener tagContainBallCollectListener;
  final ScrollController mainScroller;
  final TabController tabController;

  const K00100MainPage(
      {Key key,
      this.searchText,
      this.simpleUserInfoCollectListener,
      this.simpleBallNameCollectListener,
      this.tagContainBallCollectListener,
      this.mainScroller,
      this.tabController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => K00100MainPageViewModel(mainScroller: mainScroller),
        child: Consumer<K00100MainPageViewModel>(builder: (_, model, __) {
          return NotificationListener<ScrollNotification>(
              child: Stack(children: [
                Container(
                  child: ListView(
                      shrinkWrap: true,
                      padding: EdgeInsets.all(0),
                      children: [
                        KRankingTagListWidget(searchText: searchText),
                        SizedBox(height: 16),
                        SimpleUserInfoCollectWidget(
                          searchText: searchText,
                          simpleUserInfoCollectListener:
                              simpleUserInfoCollectListener,
                        ),
                        SizedBox(height: 16),
                        SimpleBallNameCollectWidget(
                          searchText: searchText,
                          simpleBallNameCollectListener:
                              simpleBallNameCollectListener,
                        ),
                        SizedBox(height: 16),
                        TagContainBallCollectWidget(
                          searchText: searchText,
                          tagContainBallCollectListener:
                              tagContainBallCollectListener,
                        ),
                        SizedBox(height: 16),
                      ]),
                  decoration: BoxDecoration(color: Color(0xffF2F0F1)),
                ),
                KCodeScrollerControllerBtn(
                  kCodeScrollerController: model.kCodeScrollerController,
                  mainScroller: model.mainScroller,
                )
              ]),
              onNotification: (scrollNotification) {
                if (tabController.index == 0) {
                  if (scrollNotification is ScrollEndNotification) {
                    model.onEndScroller(scrollNotification);
                  }
                }
                return true;
              });
        }));
  }
}

class K00100MainPageViewModel extends ChangeNotifier {
  ScrollController controller;

  bool showScrollerBtn = false;

  KCodeScrollerController kCodeScrollerController = KCodeScrollerController();

  final ScrollController mainScroller;

  K00100MainPageViewModel({@required this.mainScroller});

  onEndScroller(ScrollEndNotification scrollNotification) {
    if (scrollNotification.metrics.pixels >= 10.0) {
      showScrollerBtn = true;
      kCodeScrollerController.forward();
    } else {
      showScrollerBtn = false;
      kCodeScrollerController.reverse();
    }
    notifyListeners();
  }

}
