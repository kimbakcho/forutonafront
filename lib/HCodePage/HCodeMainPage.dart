import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:forutonafront/HCodePage/H001/H001Page.dart';
import 'package:forutonafront/HCodePage/H001/H001ViewModel.dart';
import 'package:forutonafront/HCodePage/H004/H004MainPage.dart';
import 'package:forutonafront/HCodePage/HCodeMainPageViewModel.dart';
import 'package:forutonafront/HCodePage/HCodePageState.dart';
import 'package:forutonafront/MainPage/BottomNavigation.dart';
import 'package:provider/provider.dart';

import 'H003/H003MainPage.dart';

class HCodeMainPage extends StatefulWidget {
  @override
  _HCodeMainPageState createState() => _HCodeMainPageState();
}

class _HCodeMainPageState extends State<HCodeMainPage> {
  @override
  void initState() {
    var statueBar = SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.white, statusBarIconBrightness: Brightness.dark);
    SystemChrome.setSystemUIOverlayStyle(statueBar);
  }

  @override
  Widget build(BuildContext context) {

    print(MediaQuery.of(context).size.width);

    return ChangeNotifierProvider(
        create: (_) => HCodeMainPageViewModel(),
        child: Consumer<HCodeMainPageViewModel>(builder: (_, model, child) {
          return Stack(children: <Widget>[
            Scaffold(
                body: Container(
                    color: Color(0xfff2f0f1),
                    padding: EdgeInsets.fromLTRB(
                        0, MediaQuery.of(context).padding.top, 0, 0),
                    child: Stack(children: <Widget>[
                      // 태그 랭킹 펼칠시 숨기기
                      Consumer<H001ViewModel>(builder: (_, h001model, child) {
                        return !h001model.isFoldTagRanking()
                            ? Positioned(
                                bottom: 0,
                                width: MediaQuery.of(context).size.width,
                                height: 52,
                                child: BottomNavigation(),
                              )
                            : Container();
                      }),
                      Column(children: <Widget>[
                        topNavibar(model),
                        Expanded(
                            child: PageView(
                                controller: model.hCodePageController,
                                children: <Widget>[
                              H001Page(),
                              H003MainPage()
                            ])),
                      ]),
                      // 태그 랭킹 접을때 보이기
                      Consumer<H001ViewModel>(builder: (_, h001model, child) {
                        return h001model.isFoldTagRanking()
                            ? Positioned(
                                bottom: 0,
                                left: 0,
                                width: MediaQuery.of(context).size.width,
                                child: Container(
                                  child : BottomNavigation()
                                )
                              )
                            : Container();
                      }),
                    ])))
          ]);
        }));
  }

  Container topNavibar(HCodeMainPageViewModel model) {
    return Container(
        color: Colors.white,
        padding: EdgeInsets.fromLTRB(16, 7, 16, 0),
        height: 64,
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              h001Button(model),
              SizedBox(
                width: 16,
              ),
              h003Button(model),
              Spacer(),
              searchButton()
            ]));
  }

  Container searchButton() {
    return Container(
        alignment: Alignment.topCenter,
        height: 36,
        width: 36,
        decoration: BoxDecoration(
          color: Color(0xfff6f6f6),
          borderRadius: BorderRadius.circular(8.00),
        ),
        child: FlatButton(
            padding: EdgeInsets.all(0),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  settings: RouteSettings(name: "/H004"),
                  builder: (context) {
                    return H004MainPage();
                  }));
            },
            child: Icon(ForutonaIcon.search)));
  }

  Column h001Button(HCodeMainPageViewModel model) {
    return Column(children: <Widget>[
      model.currentState == HCodePageState.H001Page
          ? Container(
              height: 36.00,
              width: 36.00,
              child: FlatButton(
                onPressed: () {
                  model.jumpTopPage(HCodePageState.H001Page);
                },
                padding: EdgeInsets.fromLTRB(0, 0, 6, 0),
                child: Icon(
                  ForutonaIcon.joystick,
                  color: Color(0xff454F63),
                  size: 17,
                ),
              ),
              decoration: BoxDecoration(
                color: Color(0xff88d4f1),
                border: Border.all(
                  width: 2.00,
                  color: Color(0xff454f63),
                ),
                borderRadius: BorderRadius.circular(8),
              ))
          : Container(
              height: 36.00,
              width: 36.00,
              decoration: BoxDecoration(
                color: Color(0xfff6f6f6),
                borderRadius: BorderRadius.circular(8.00),
              ),
              child: FlatButton(
                onPressed: () {
                  setState(() {
                    model.jumpTopPage(HCodePageState.H001Page);
                  });
                },
                padding: EdgeInsets.fromLTRB(0, 0, 6, 0),
                child: Icon(
                  ForutonaIcon.joystick,
                  color: Color(0xffB1B1B1),
                  size: 17,
                ),
              ),
            ),
      model.currentState == HCodePageState.H001Page
          ? Container(
              margin: EdgeInsets.fromLTRB(0, 6, 0, 0),
              height: 4.00,
              width: 4.00,
              decoration: BoxDecoration(
                color: Color(0xff454f63),
                border: Border.all(
                  width: 1.00,
                  color: Color(0xff454f63),
                ),
                shape: BoxShape.circle,
              ))
          : Container()
    ]);
  }

  Column h003Button(HCodeMainPageViewModel model) {
    return Column(children: <Widget>[
      model.currentState == HCodePageState.H003Page
          ? Container(
              height: 36,
              width: 36,
              child: FlatButton(
                onPressed: () {
                  model.jumpTopPage(HCodePageState.H003Page);
                },
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Icon(
                  ForutonaIcon.h003top,
                  color: Color(0xff454F63),
                  size: 17,
                ),
              ),
              decoration: BoxDecoration(
                color: Color(0xffff9edb),
                border: Border.all(
                  width: 2.00,
                  color: Color(0xff454f63),
                ),
                borderRadius: BorderRadius.circular(8.00),
              ))
          : Container(
              height: 36.00,
              width: 36.00,
              decoration: BoxDecoration(
                color: Color(0xfff6f6f6),
                borderRadius: BorderRadius.circular(8.00),
              ),
              child: FlatButton(
                onPressed: () {
                  model.jumpTopPage(HCodePageState.H003Page);
                },
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Icon(
                  ForutonaIcon.h003top,
                  color: Color(0xffB1B1B1),
                  size: 17,
                ),
              ),
            ),
      model.currentState == HCodePageState.H003Page
          ? Container(
              margin: EdgeInsets.fromLTRB(0, 6, 0, 0),
              height: 4.00,
              width: 4.00,
              decoration: BoxDecoration(
                color: Color(0xff454f63),
                border: Border.all(
                  width: 1.00,
                  color: Color(0xff454f63),
                ),
                shape: BoxShape.circle,
              ))
          : Container()
    ]);
  }
}
