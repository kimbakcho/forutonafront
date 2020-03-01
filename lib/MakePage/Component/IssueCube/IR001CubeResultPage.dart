import 'package:after_init/after_init.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/Common/Fcubereply.dart';
import 'package:forutonafront/Common/FcubereplySearch.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:forutonafront/MakePage/Component/FcubeExtender1.dart';
import 'package:intl/intl.dart';

class IR001CubeResultPage extends StatefulWidget {
  IR001CubeResultPage({this.fcubeextender1, Key key}) : super(key: key);
  final FcubeExtender1 fcubeextender1;
  @override
  _IR001CubeResultPageState createState() {
    return _IR001CubeResultPageState(fcubeextender1: fcubeextender1);
  }
}

class _IR001CubeResultPageState extends State<IR001CubeResultPage>
    with AfterInitMixin {
  _IR001CubeResultPageState({this.fcubeextender1});

  FcubeExtender1 fcubeextender1;
  int replycount = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  void didInitState() async {
    replycount = await Fcubereply.getReplyCount(FcubereplySearch(
        cubeuuid: fcubeextender1.cubeuuid, bgroup: 0, limit: 0, offset: 0));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text("결과",
              style: TextStyle(
                fontFamily: "Noto Sans CJK KR",
                fontWeight: FontWeight.w700,
                fontSize: 20,
                color: Color(0xff454f63),
              )),
          titleSpacing: 0,
        ),
        backgroundColor: Colors.white,
        body: Stack(children: <Widget>[
          Container(
            child: ListView(
              children: <Widget>[
                Container(
                    margin: EdgeInsets.all(16),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Color(0xffffffff),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0.00, 4.00),
                          color: Color(0xff455b63).withOpacity(0.08),
                          blurRadius: 16,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(12.00),
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                              child: Row(children: <Widget>[
                            Container(
                              height: 42.00,
                              width: 42.00,
                              child: Icon(ForutonaIcon.visibility),
                              decoration: BoxDecoration(
                                  color: Color(0xffe4e7e8),
                                  boxShadow: [
                                    BoxShadow(
                                      offset: Offset(0.00, 12.00),
                                      color:
                                          Color(0xff455b63).withOpacity(0.10),
                                      blurRadius: 16,
                                    ),
                                  ],
                                  shape: BoxShape.circle),
                            ),
                            Container(
                                margin: EdgeInsets.fromLTRB(16, 0, 0, 0),
                                child: Column(children: <Widget>[
                                  Text("조회",
                                      style: TextStyle(
                                        fontFamily: "Noto Sans CJK KR",
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14,
                                        color: Color(0xff454f63),
                                      )),
                                  Text(
                                      "${NumberFormat("###,###,###").format(fcubeextender1.cubehits)} 회",
                                      style: TextStyle(
                                        fontFamily: "Noto Sans CJK KR",
                                        fontSize: 14,
                                        color: Color(0xff78849e),
                                      ))
                                ]))
                          ])),
                          Divider(
                            thickness: 2,
                            indent: 16,
                            endIndent: 16,
                            color: Color(0xffF4F4F6),
                          ),
                          Container(
                              child: Row(children: <Widget>[
                            Container(
                              height: 42.00,
                              width: 42.00,
                              child: Icon(ForutonaIcon.sponsorcount),
                              decoration: BoxDecoration(
                                  color: Color(0xffe4e7e8),
                                  boxShadow: [
                                    BoxShadow(
                                      offset: Offset(0.00, 12.00),
                                      color:
                                          Color(0xff455b63).withOpacity(0.10),
                                      blurRadius: 16,
                                    ),
                                  ],
                                  shape: BoxShape.circle),
                            ),
                            Container(
                                margin: EdgeInsets.fromLTRB(16, 0, 0, 0),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text("영향력",
                                          style: TextStyle(
                                            fontFamily: "Noto Sans CJK KR",
                                            fontWeight: FontWeight.w700,
                                            fontSize: 14,
                                            color: Color(0xff454f63),
                                          )),
                                      Text(
                                          "긍정 ${NumberFormat("###,###,###").format(fcubeextender1.cubelikes)}  |  부정 ${NumberFormat("###,###,###").format(fcubeextender1.cubedislikes)}",
                                          style: TextStyle(
                                            fontFamily: "Noto Sans CJK KR",
                                            fontSize: 14,
                                            color: Color(0xff78849e),
                                          ))
                                    ]))
                          ])),
                          Divider(
                            thickness: 2,
                            indent: 16,
                            endIndent: 16,
                            color: Color(0xffF4F4F6),
                          ),
                          Container(
                              child: Row(children: <Widget>[
                            Container(
                              height: 42.00,
                              width: 42.00,
                              child: Icon(ForutonaIcon.sponsorcount),
                              decoration: BoxDecoration(
                                  color: Color(0xffe4e7e8),
                                  boxShadow: [
                                    BoxShadow(
                                      offset: Offset(0.00, 12.00),
                                      color:
                                          Color(0xff455b63).withOpacity(0.10),
                                      blurRadius: 16,
                                    ),
                                  ],
                                  shape: BoxShape.circle),
                            ),
                            Container(
                                margin: EdgeInsets.fromLTRB(16, 0, 0, 0),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text("의견",
                                          style: TextStyle(
                                            fontFamily: "Noto Sans CJK KR",
                                            fontWeight: FontWeight.w700,
                                            fontSize: 14,
                                            color: Color(0xff454f63),
                                          )),
                                      Text("$replycount건",
                                          style: TextStyle(
                                            fontFamily: "Noto Sans CJK KR",
                                            fontSize: 14,
                                            color: Color(0xff78849e),
                                          ))
                                    ]))
                          ])),
                        ])),
              ],
            ),
          )
        ]));
  }
}
