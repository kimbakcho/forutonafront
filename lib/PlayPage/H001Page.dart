import 'package:flutter/material.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';

enum H001Pagestate { H001, H003 }

class H001Page extends StatefulWidget {
  H001Page({Key key}) : super(key: key);

  @override
  _H001PageState createState() => _H001PageState();
}

class _H001PageState extends State<H001Page> {
  H001Pagestate currentstate = H001Pagestate.H001;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
            body: Container(
                padding: EdgeInsets.fromLTRB(
                    0, MediaQuery.of(context).padding.top, 0, 0),
                child: Column(children: <Widget>[
                  Container(
                      padding: EdgeInsets.fromLTRB(16, 6, 16, 0),
                      height: 55,
                      child: Row(mainAxisSize: MainAxisSize.max, children: <
                          Widget>[
                        Column(children: <Widget>[
                          currentstate == H001Pagestate.H001
                              ? Container(
                                  height: 36.00,
                                  width: 36.00,
                                  child: FlatButton(
                                    onPressed: () {
                                      setState(() {
                                        currentstate = H001Pagestate.H001;
                                      });
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
                                      setState(() {
                                        currentstate = H001Pagestate.H001;
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
                          currentstate == H001Pagestate.H001
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
                        ]),
                        SizedBox(
                          width: 16,
                        ),
                        Column(children: <Widget>[
                          currentstate == H001Pagestate.H003
                              ? Container(
                                  height: 36.00,
                                  width: 36.00,
                                  child: FlatButton(
                                    onPressed: () {
                                      setState(() {
                                        currentstate = H001Pagestate.H003;
                                      });
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
                                      setState(() {
                                        currentstate = H001Pagestate.H003;
                                      });
                                    },
                                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                    child: Icon(
                                      ForutonaIcon.h003top,
                                      color: Color(0xffB1B1B1),
                                      size: 17,
                                    ),
                                  ),
                                ),
                          currentstate == H001Pagestate.H003
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
                        ])
                      ]))
                ])))
      ],
    );
  }
}
