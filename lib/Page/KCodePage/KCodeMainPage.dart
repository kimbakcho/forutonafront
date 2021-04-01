import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/Components/BallNameCollectWidget/SimpleBallNameCollectWidget.dart';
import 'package:forutonafront/Components/TagContainBallCollectWidget/TagContainBallCollectWidget.dart';
import 'package:forutonafront/Components/TopSearchDisPlayBar/TopSearchDisPlayBar.dart';
import 'package:forutonafront/Components/UserInfoCollectionWidget/SimpleUserInfoCollectWidget.dart';
import 'package:provider/provider.dart';

import 'K001_00/K00100MainPage.dart';
import 'K001_01/K00101MainPage.dart';
import 'K001_02/K00102MainPage.dart';
import 'K001_03/K00103MainPage.dart';
import 'KCodeTopTabBar.dart';

class KCodeMainPage extends StatefulWidget {
  final String searchText;

  const KCodeMainPage({Key key, this.searchText}) : super(key: key);

  @override
  _KCodeMainPageState createState() => _KCodeMainPageState();
}

class _KCodeMainPageState extends State<KCodeMainPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 1, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) =>
            KCodeMainPageViewModel(tabController: _tabController,
                scrollController: ScrollController()),
        child: Consumer<KCodeMainPageViewModel>(builder: (_, model, __) {
          return Scaffold(
              body: Container(
                  padding:
                  EdgeInsets.only(top: MediaQuery
                      .of(context)
                      .padding
                      .top),
                  //https://flutter-widget.live/widgets/NestedScrollView
                  child: NestedScrollView(
                      key: model.kCodeNestedScrollViewKey,
                      headerSliverBuilder:
                          (BuildContext context, bool innerBoxIsScrolled) {
                        return <Widget>[
                          SliverOverlapAbsorber(
                            handle:
                            NestedScrollView.sliverOverlapAbsorberHandleFor(
                                context),
                            sliver: SliverAppBar(
                              toolbarHeight: 0,
                              pinned: true,
                              primary: false,
                              flexibleSpace: TopSearchDisPlayBar(
                                initText: widget.searchText,
                              ),

                              expandedHeight: 56,
                              bottom:
                              KCodeTopTabBar(tabController: _tabController),
                            ),
                          ),
                        ];
                      },
                      controller: model.scrollController,
                      body: Container(
                          color: Colors.white,

                          child:
                          TabBarView(controller: _tabController, children: [
                            K00102MainPage(
                              searchText: widget.searchText,
                              mainScroller: model.scrollController,
                              tabController: _tabController,
                              kCodeNestedScrollViewKey: model.kCodeNestedScrollViewKey,
                            ),
                            // K00100MainPage(
                            //   searchText: widget.searchText,
                            //   simpleUserInfoCollectListener: model,
                            //   tagContainBallCollectListener: model,
                            //   simpleBallNameCollectListener: model,
                            //   mainScroller: model.scrollController,
                            //   tabController: _tabController,
                            // ),
                            // K00101MainPage(
                            //   searchText: widget.searchText,
                            //   mainScroller: model.scrollController,
                            //   tabController: _tabController,
                            //   kCodeNestedScrollViewKey: model.kCodeNestedScrollViewKey,
                            // ),
                            //
                            // K00103MainPage(
                            //   searchText: widget.searchText,
                            //   mainScroller: model.scrollController,
                            //   tabController: _tabController,
                            //   kCodeNestedScrollViewKey: model.kCodeNestedScrollViewKey
                            // )
                          ])))));
        }));
  }
}

class KCodeMainPageViewModel extends ChangeNotifier
    implements
        KCodeTopTabBarListener,
        SimpleUserInfoCollectListener,
        SimpleBallNameCollectListener,
        TagContainBallCollectListener {
  final TabController tabController;
  final ScrollController scrollController;

  final GlobalKey<NestedScrollViewState> kCodeNestedScrollViewKey = GlobalKey();

  KCodeMainPageViewModel(
      {@required this.tabController, @required this.scrollController });



  @override
  onTabChange(KCodeTabType kCodeTabType) {
    print(kCodeTabType);
  }

  @override
  void onSimpleUserInfoCollectNextPage(String searchText) {
    tabController.index = 1;
  }

  @override
  void onSimpleBallNameCollectNextPage(String searchText) {
    tabController.index = 2;
  }

  @override
  void onTagContainBallCollectNextPage(String searchText) {
    tabController.index = 3;
  }
}
