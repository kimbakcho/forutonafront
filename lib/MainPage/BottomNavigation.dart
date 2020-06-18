import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:forutonafront/JCodePage/J001/J001View.dart';
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
        height: 52,
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
                    model.jumpToPage(HCodeState.BCODE);
                  },
                  child: Icon(
                    ForutonaIcon.officialchannel,
                    color: model.currentState == HCodeState.BCODE
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
                  onPressed: () async {
                    //BPage 의 WebviewScaffold 가 Navigator를 Push 해도 띄어져 있는 버그가 있어
                    //해결이 안되 GCODE 페이지로 PageController 로 옮긴 다음에 처리
                    if(model.currentState == HCodeState.BCODE){
                      model.jumpToPage(HCodeState.GCODE);
                    }

                    if (!await model.checkUser()) {
                      await model.gotoJ001Page(context);
                      if (!await model.checkUser()) {
                        model.jumpToPage(HCodeState.HCDOE);
                      }
                    }
                  },
                  child: Icon(
                    ForutonaIcon.user,
                    color: model.currentState == HCodeState.GCODE
                        ? Color(0xff454F63)
                        : Color(0xffE4E7E8),
                  ))),
        ]),
        decoration: BoxDecoration(
          color: Color(0xffffffff),
          boxShadow: [
            BoxShadow(
              offset: Offset(0.00, 3.00),
              color: Color(0xff000000).withOpacity(0.16),
              blurRadius: 6,
            ),
          ],
        ),
      );
    });
  }


}
