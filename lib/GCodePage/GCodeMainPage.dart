import 'package:flutter/material.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:forutonafront/GCodePage/G001/G001MainPage.dart';
import 'package:forutonafront/GCodePage/GCodePageState.dart';
import 'package:forutonafront/MainPage/BottomNavigation.dart';
import 'package:provider/provider.dart';
import 'GCodeMainPageViewModel.dart';

class GCodeMainPage extends StatelessWidget {

  PageController gCodePageController =  PageController();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<GCodeMainPageViewModel>(
          create: (_)  {
            return GCodeMainPageViewModel(context: context,gCodePageController: gCodePageController);
          }
        )
      ],
      child: Consumer<GCodeMainPageViewModel>(builder: (_, model, child) {
        return Stack(children: <Widget>[
          Scaffold(
              body: Container(
            color: Color(0xfff2f0f1),
            padding: EdgeInsets.fromLTRB(
                0, MediaQuery.of(context).padding.top, 0, 0),
            child: Column(
              children: <Widget>[
                topNavibar(model),
                Expanded(
                    child: PageView(
                  controller: gCodePageController,
                  children: <Widget>[
                    G001MainPage(),
                    Container(
                      child: Text("G002"),
                    ),
                  ],
                )),
                BottomNavigation(),
              ],
            ),
          ))
        ]);
      }),
    );
  }

  Container topNavibar(GCodeMainPageViewModel model) {
    return Container(
        color: Colors.white,
        padding: EdgeInsets.fromLTRB(16, 7, 16, 0),
        height: 63,
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              g001Button(model),
              SizedBox(
                width: 16,
              ),
              g003Button(model),
              Spacer(),
              settingButton(model)
            ]));
  }

  Column g001Button(GCodeMainPageViewModel model) {
    return Column(children: <Widget>[
      model.currentState == GCodePageState.G001Page
          ? Container(
              height: 36.00,
              width: 36.00,
              child: FlatButton(
                onPressed: () {
                  model.jumpTopPage(GCodePageState.G001Page);
                },
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Icon(
                  ForutonaIcon.user,
                  color: Color(0xff454F63),
                  size: 17,
                ),
              ),
              decoration: BoxDecoration(
                color: Color(0xff45E193),
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
                  model.jumpTopPage(GCodePageState.G001Page);
                },
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Icon(
                  ForutonaIcon.user,
                  color: Color(0xffB1B1B1),
                  size: 17,
                ),
              ),
            ),
      model.currentState == GCodePageState.G001Page
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

  Column g003Button(GCodeMainPageViewModel model) {
    return Column(children: <Widget>[
      model.currentState == GCodePageState.G003Page
          ? Container(
              height: 36,
              width: 36,
              child: FlatButton(
                onPressed: () {
                  model.jumpTopPage(GCodePageState.G003Page);
                },
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Icon(
                  ForutonaIcon.wallet,
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
                  model.jumpTopPage(GCodePageState.G003Page);
                },
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Icon(
                  ForutonaIcon.wallet,
                  color: Color(0xffB1B1B1),
                  size: 17,
                ),
              ),
            ),
      model.currentState == GCodePageState.G003Page
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

  Container settingButton(GCodeMainPageViewModel model) {
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
            onPressed: model.jumpToSettingPage,
            child: Icon(ForutonaIcon.cog,color: Color(0xffB1B1B1),)));
  }
}
