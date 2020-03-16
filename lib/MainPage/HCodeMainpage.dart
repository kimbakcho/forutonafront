import 'package:flutter/material.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:forutonafront/PlayPage/H001Page.dart';

enum HCodeState { H001, T004, T007, T009, T011 }

class HCodeMainpage extends StatefulWidget {
  HCodeMainpage({Key key}) : super(key: key);

  @override
  _HCodeMainpageState createState() => _HCodeMainpageState();
}

class _HCodeMainpageState extends State<HCodeMainpage> {
  HCodeState currentstate = HCodeState.H001;
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F0F1),
      body: Stack(
        children: <Widget>[
          Container(
            child: PageView(
              controller: pageController,
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
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: getBottomNavi(),
    );
  }

  Container getBottomNavi() {
    return Container(
        child: Row(children: <Widget>[
      Expanded(
          flex: 1,
          child: FlatButton(
              onPressed: () {
                setState(() {
                  pageController.jumpToPage(0);
                  currentstate = HCodeState.H001;
                });
              },
              child: Icon(
                ForutonaIcon.list,
                color: currentstate == HCodeState.H001
                    ? Color(0xff454F63)
                    : Color(0xffE4E7E8),
              ))),
      Expanded(
          flex: 1,
          child: FlatButton(
              onPressed: () {
                setState(() {
                  currentstate = HCodeState.T004;
                  pageController.jumpToPage(1);
                });
              },
              child: Icon(
                ForutonaIcon.map,
                color: currentstate == HCodeState.T004
                    ? Color(0xff454F63)
                    : Color(0xffE4E7E8),
              ))),
      Expanded(
          flex: 1,
          child: FlatButton(
              onPressed: () {
                setState(() {
                  currentstate = HCodeState.T004;
                  pageController.jumpToPage(2);
                });
              },
              child: Icon(
                ForutonaIcon.officialchannel,
                color: currentstate == HCodeState.T007
                    ? Color(0xff454F63)
                    : Color(0xffE4E7E8),
              ))),
      Expanded(
          flex: 1,
          child: FlatButton(
              onPressed: () {
                setState(() {
                  currentstate = HCodeState.T009;
                  pageController.jumpToPage(3);
                });
              },
              child: Icon(
                ForutonaIcon.social,
                color: currentstate == HCodeState.T009
                    ? Color(0xff454F63)
                    : Color(0xffE4E7E8),
              ))),
      Expanded(
          flex: 1,
          child: FlatButton(
              onPressed: () {
                setState(() {
                  currentstate = HCodeState.T011;
                  pageController.jumpToPage(4);
                });
              },
              child: Icon(
                ForutonaIcon.user,
                color: currentstate == HCodeState.T011
                    ? Color(0xff454F63)
                    : Color(0xffE4E7E8),
              ))),
    ]));
  }
}
