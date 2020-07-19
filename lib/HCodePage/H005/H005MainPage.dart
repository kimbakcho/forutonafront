import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forutonafront/FBall/Data/DataStore/FBallRemoteDataSource.dart';
import 'package:forutonafront/FBall/Data/Repository/FBallRepositoryImpl.dart';
import 'package:forutonafront/FBall/Domain/UseCase/FBallListUpFromSearchTitle/FBallListUpFromSearchTitleUseCase.dart';
import 'package:forutonafront/FBall/Domain/UseCase/FBallListUpFromSearchTitle/FBallListUpFromSearchTitleUseCaseInputPort.dart';
import 'package:forutonafront/FBall/Domain/UseCase/FBallListUpFromTagName/FBallListUpFromSearchTagNameUseCase.dart';
import 'package:forutonafront/FBall/Domain/UseCase/FBallListUpFromTagName/FBallListUpFromSearchTagUseCaseInputPort.dart';
import 'package:forutonafront/HCodePage/H005/H00501/H00501Page.dart';
import 'package:forutonafront/HCodePage/H005/H00502/H00502PageViewModel.dart';
import 'package:forutonafront/HCodePage/H005/H005MainPageViewModel.dart';
import 'package:forutonafront/HCodePage/H005/H005PageState.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'H00501/H00501PageViewModel.dart';
import 'H00502/H00502Page.dart';

class H005MainPage extends StatefulWidget {
  H005MainPage({@required this.searchText, @required this.initPageState});

  final String searchText;
  final H005PageState initPageState;

  @override
  _H005MainPageState createState() {
    return _H005MainPageState();
  }
}

class _H005MainPageState extends State<H005MainPage>
    with SingleTickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    super.initState();
    if (widget.initPageState != null) {
      tabController = TabController(
          length: 2, vsync: this, initialIndex: widget.initPageState.index);
    } else {
      tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    var h005mainPageViewModel = H005MainPageViewModel(
        context: context,
        searchText: widget.searchText,
        tabController: tabController);
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
              create: (_) => h005mainPageViewModel),
          ChangeNotifierProvider(
            lazy: false,
              create: (_) => H00501PageViewModel(
                  context: context,
                  fBallListUpFromSearchTitleUseCaseInputPort: sl(),
                  geoLocationUtilUseCaseIp: sl(),
                  onSearchTitleItemCount: h005mainPageViewModel.onBallListUpFromSearchTitleBallTotalCount,
                  searchTitle: widget.searchText)),
          ChangeNotifierProvider(
              lazy: false,
              create: (_) => H00502PageViewModel(
                  context: context,
                  fBallListUpFromSearchTagNameUseCaseInputPort: sl(),
                  geoLocationUtilUseCaseInputPort: sl(),
                  rankingFromTagNameOrderByBallPowerUseCaseInputPort: sl(),
                  emitBallListUpFromSearchTagNameBallTotalCount: h005mainPageViewModel.onBallListUpFromSearchTagNameBallTotalCount,
                  searchTag: widget.searchText))
        ],
        child: Consumer<H005MainPageViewModel>(builder: (_, model, child) {
          return Stack(children: <Widget>[
            Scaffold(
                body: Container(
                    color: Color(0xfff2f0f1),
                    padding: EdgeInsets.fromLTRB(
                        0, MediaQuery.of(context).padding.top, 0, 0),
                    child: Stack(children: <Widget>[
                      Column(children: <Widget>[
                        topSearchBar(context, model),
                        topTabBar(model),
                        Expanded(
                          child: TabBarView(
                            controller: model.tabController,
                            children: <Widget>[
                              H00501Page(),
                              H00502Page(),
                            ],
                          ),
                        )
                      ]),
                    ])))
          ]);
        }));
  }

  Container topSearchBar(BuildContext context, H005MainPageViewModel model) {
    return Container(
      height: 60,
      child: Stack(
        children: <Widget>[
          Row(children: <Widget>[
            BackButton(
                color: Colors.black,
                onPressed: () {
                  Navigator.of(context).pop();
                }),
            FlatButton(
              padding: EdgeInsets.all(0),
              onPressed: (){
                Navigator.of(context).pop();
              },
              child:Container(

                  height: 32.00,
                  width: MediaQuery.of(context).size.width - 80,
                  margin: EdgeInsets.only(left: 8),
                  alignment: Alignment.center,
                  child: Text(model.getSearchTextDisplay(),
                      style: GoogleFonts.notoSans(
                        fontSize: 14,
                        color: Color(0xff454f63),
                      )),
                  decoration: BoxDecoration(
                    color: Color(0xfff9f9f9),
                    border: Border.all(
                      width: 1.00,
                      color: Color(0xfff6f6f6),
                    ),
                    borderRadius: BorderRadius.circular(12.00),
                  )) ,
            )

          ]),
        ],
      ),
      decoration: BoxDecoration(color: Colors.white),
    );
  }

  Container topTabBar(H005MainPageViewModel model) {
    return Container(
      color: Colors.white,
      child: TabBar(
          onTap: (value) {
            model.changeTabIndex(value);
          },
          indicatorColor: Colors.black,
          unselectedLabelColor: Color(0xffCCCCCC),
          labelColor: Color(0xff454F63),
          labelStyle: TextStyle(
            fontFamily: "Noto Sans CJK KR",
            fontSize: 14,
            color: Color(0xff454f63),
          ),
          controller: model.tabController,
          tabs: [
            Tab(
              text: model.getTitleText(),
            ),
            Tab(text: model.getTagText()),
          ]),
    );
  }
}
