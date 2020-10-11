import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/Components/TopSearchDisPlayBar/TopSearchDisPlayBar.dart';
import 'package:provider/provider.dart';

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
    _tabController = TabController(vsync: this, length: 4, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => KCodeMainPageViewModel(),
      child: Consumer<KCodeMainPageViewModel>(
        builder: (_, model, __) {
          return Scaffold(
              body: Container(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            //https://flutter-widget.live/widgets/NestedScrollView
            child: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverOverlapAbsorber(
                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                        context),
                    sliver: SliverAppBar(
                      toolbarHeight: 0,
                      pinned: true,
                      primary: false,
                      flexibleSpace: TopSearchDisPlayBar(
                        initText: widget.searchText,
                      ),
                      expandedHeight: 124,
                      bottom: KCodeTopTabBar(tabController: _tabController),
                    ),
                  ),
                ];
              },
              body: Container(
                padding: EdgeInsets.only(top: 68),
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    ListView.builder(
                      padding: EdgeInsets.all(0),
                      itemCount: 100,
                      itemBuilder: (context,index)=>Container(child:Text("${index}")),
                    ),
                    Container(child: Text("123"),),
                    Container(child: Text("123"),),
                    Container(child: Text("123"),)
                  ],
                ),
              ),
              )
              ,
          ));
        },
      ),
    );
  }
}

class KCodeMainPageViewModel extends ChangeNotifier
    implements KCodeTopTabBarListener {
  @override
  onTabChange(KCodeTabType kCodeTabType) {
    print(kCodeTabType);
  }
}
