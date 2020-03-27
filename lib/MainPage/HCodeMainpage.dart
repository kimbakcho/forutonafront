import 'package:flutter/material.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:forutonafront/MainPage/HCodeMainViewModel.dart';
import 'package:forutonafront/HCodePage/H001/H001Page.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class HCodeMainpage extends StatefulWidget {
  HCodeMainpage({Key key}) : super(key: key);

  @override
  _HCodeMainpageState createState() => _HCodeMainpageState();
}

class _HCodeMainpageState extends State<HCodeMainpage> {


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HCodeMainViewModel(),
      child: Consumer<HCodeMainViewModel>(builder: (_, model, child) {
        return Scaffold(
          backgroundColor: Color(0xffF2F0F1),
          body: Stack(children: <Widget>[
            Container(
                child: PageView(
                  physics: NeverScrollableScrollPhysics(),
                    controller: model.pageController,
                    children: <Widget>[
                  H001Page(),
                  Container(
                    child: Text("2"),
                  ),
                  Container(
                    child: Text("3"),
                  ),
                  Container(
                    child: Text("4"),
                  ),
                  Container(
                    child: Text("5"),
                  )
                ]))
          ]),
          bottomNavigationBar: getBottomNavigation(model),

        );
      }),
    );
  }
  Container getBottomNavigation(HCodeMainViewModel model){
    if(model.currentState == HCodeState.H001){
      return null;
    }else {
      return bottomNavigation(model);
    }
  }

  Container bottomNavigation(HCodeMainViewModel model) {
    return Container(
          color: Colors.white,
          height: 52.h,
            child: Row(children: <Widget>[
          Expanded(
              flex: 1,
              child: FlatButton(
                  onPressed: () {
                    model.jumpToPage(HCodeState.H001);
                  },
                  child: Icon(
                    ForutonaIcon.list,
                    color: model.currentState == HCodeState.H001
                        ? Color(0xff454F63)
                        : Color(0xffE4E7E8),
                  ))),
          Expanded(
              flex: 1,
              child: FlatButton(
                  onPressed: () {
                    model.jumpToPage(HCodeState.T004);
                  },
                  child: Icon(
                    ForutonaIcon.map,
                    color: model.currentState == HCodeState.T004
                        ? Color(0xff454F63)
                        : Color(0xffE4E7E8),
                  ))),
          Expanded(
              flex: 1,
              child: FlatButton(
                  onPressed: () {
                    model.jumpToPage(HCodeState.T007);
                  },
                  child: Icon(
                    ForutonaIcon.officialchannel,
                    color: model.currentState == HCodeState.T007
                        ? Color(0xff454F63)
                        : Color(0xffE4E7E8),
                  ))),
          Expanded(
              flex: 1,
              child: FlatButton(
                  onPressed: () {
                    model.jumpToPage(HCodeState.T009);
                  },
                  child: Icon(
                    ForutonaIcon.social,
                    color: model.currentState == HCodeState.T009
                        ? Color(0xff454F63)
                        : Color(0xffE4E7E8),
                  ))),
          Expanded(
              flex: 1,
              child: FlatButton(
                  onPressed: () {
                    model.jumpToPage(HCodeState.T011);
                  },
                  child: Icon(
                    ForutonaIcon.user,
                    color: model.currentState == HCodeState.T011
                        ? Color(0xff454F63)
                        : Color(0xffE4E7E8),
                  ))),
        ]));
  }
}
