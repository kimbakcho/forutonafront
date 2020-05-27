import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forutonafront/Common/Loding/CommonLoadingComponent.dart';

import 'package:forutonafront/HCodePage/H005/H00501/H00501Page.dart';
import 'package:forutonafront/HCodePage/H005/H005MainPageViewModel.dart';
import 'package:forutonafront/HCodePage/H005/H005PageState.dart';
import 'package:provider/provider.dart';

import 'H00502/H00502Page.dart';

class H005MainPage extends StatefulWidget {
  H005MainPage(this.searchText,{this.initPageState});

  final String searchText;
  H005PageState initPageState;

  @override
  _H005MainPageState createState() {
      return _H005MainPageState(searchText,initPageState: this.initPageState);
  }
}

class _H005MainPageState extends State<H005MainPage>
    with SingleTickerProviderStateMixin {
  _H005MainPageState(this.serachText,{this.initPageState});

  final String serachText;
  TabController tabController;
  H005PageState initPageState;

  @override
  void initState() {
    super.initState();
    if(initPageState!=null){
      tabController = TabController(length: 2, vsync: this, initialIndex: initPageState.index);
    }else {
      tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    }

  }

  @override
  Widget build(BuildContext context) {
    SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.white, statusBarIconBrightness: Brightness.dark);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.white, statusBarIconBrightness: Brightness.dark));
    return ChangeNotifierProvider(
        create: (_) => H005MainPageViewModel(context, serachText,
            tabController: tabController),
        child: Consumer<H005MainPageViewModel>(builder: (_, model, child) {
          return Stack(children: <Widget>[
            Scaffold(
                body: Container(
                    color: Color(0xfff2f0f1),
                    padding:  EdgeInsets.fromLTRB(
                        0, MediaQuery.of(context).padding.top, 0, 0),
                    child: Stack(children: <Widget>[
                      Column(children: <Widget>[
                        topSerchBar(context, model),
                        topTabbar(model),
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
                      model.getIsLoading()?
                          CommonLoadingComponent():Container()
                    ])))
          ]);
        }));
  }

  Container topSerchBar(BuildContext context, H005MainPageViewModel model) {
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
            Container(
                height: 32.00,
                width: MediaQuery.of(context).size.width-80,
                margin: EdgeInsets.only(left: 8),
                alignment: Alignment.center,
                child: Text(model.getSearchTextDisplay(),
                    style: TextStyle(
                      fontFamily: "Noto Sans CJK KR",
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
                ))
          ]),
//          Positioned(
//              right: 40,
//              top: 13,
//              child: Container(
//                  height: 20.00,
//                  width: 20.00,
//                  child: FlatButton(
//                    onPressed: () {
//                      model.sethasClearFlag(true);
//                    },
//                    padding: EdgeInsets.all(0),
//                    child: Icon(Icons.close,
//                        size: 13,
//                        color: !model.hasClearFlag
//                            ? Color(0xff454F63)
//                            : Color(0xffCCCCCC)),
//                  ),
//                  decoration: BoxDecoration(
//                    color: Color(0xffffffff),
//                    border: Border.all(
//                      width: 1.00,
//                      color: !model.hasClearFlag
//                          ? Color(0xff454F63)
//                          : Color(0xffcccccc),
//                    ),
//                    shape: BoxShape.circle,
//                  )))
        ],
      ),
      decoration: BoxDecoration(color: Colors.white),
    );
  }

  Container topTabbar(H005MainPageViewModel model) {
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
