import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:forutonafront/MainPage/CodeMainViewModel.dart';
import 'package:provider/provider.dart';

class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CodeMainViewModel>(builder: (_, model, child) {
      return Container(
          color: Colors.white,
          height: 52.h,
          child: Row(children: <Widget>[
            Expanded(
                flex: 1,
                child: FlatButton(
                    onPressed: () {
                      model.jumpToPage(HCodeState.HCDOE);
                    },
                    child: Icon(
                      ForutonaIcon.list,
                      color: model.currentState == HCodeState.HCDOE
                          ? Color(0xff454F63)
                          : Color(0xffE4E7E8),
                    ))),
            Expanded(
                flex: 1,
                child: FlatButton(
                    onPressed: () {
                      model.jumpToPage(HCodeState.ICODE);
                    },
                    child: Icon(
                      ForutonaIcon.map,
                      color: model.currentState == HCodeState.ICODE
                          ? Color(0xff454F63)
                          : Color(0xffE4E7E8),
                    ))),
            Expanded(
                flex: 1,
                child: FlatButton(
                    onPressed: () {
                      model.jumpToPage(HCodeState.JCODE);
                    },
                    child: Icon(
                      ForutonaIcon.officialchannel,
                      color: model.currentState == HCodeState.JCODE
                          ? Color(0xff454F63)
                          : Color(0xffE4E7E8),
                    ))),
            Expanded(
                flex: 1,
                child: FlatButton(
                    onPressed: () {
                      model.jumpToPage(HCodeState.KCODE);
                    },
                    child: Icon(
                      ForutonaIcon.social,
                      color: model.currentState == HCodeState.KCODE
                          ? Color(0xff454F63)
                          : Color(0xffE4E7E8),
                    ))),
            Expanded(
                flex: 1,
                child: FlatButton(
                    onPressed: () {
                      model.jumpToPage(HCodeState.GCODE);
                    },
                    child: Icon(
                      ForutonaIcon.user,
                      color: model.currentState == HCodeState.GCODE
                          ? Color(0xff454F63)
                          : Color(0xffE4E7E8),
                    ))),
          ]));
    });
  }
}
