import 'package:after_init/after_init.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/Auth/UserExpPointHistroy.dart';
import 'package:forutonafront/Common/FcubeSponsor.dart';
import 'package:forutonafront/Common/FcubeSponsorExtender1.dart';
import 'package:forutonafront/Common/FcubeSponsorSearch.dart';
import 'package:forutonafront/Common/Fcubereply.dart';
import 'package:forutonafront/Common/FcubereplySearch.dart';
import 'package:forutonafront/Common/LoadingOverlay.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:forutonafront/MakePage/Component/FcubeExtender1.dart';
import 'package:forutonafront/MakePage/Component/IssueCube/ID001CubeDetailPage.dart';
import 'package:intl/intl.dart';
import 'package:loading/indicator/ball_scale_indicator.dart';
import 'package:loading/loading.dart';

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
  int totalexpPoint = 0;
  int makeexpPoint = 0;
  int valuationexpPoint = 0;
  bool isLoading = false;
  int sumSponsorPointValue = 0;
  int cubeSponsorCount = 0;
  List<FcubeSponsorExtender1> fcubeSponsorlist = List<FcubeSponsorExtender1>();
  FcubeSponsorSearch fcubeSponsorsearch;
  @override
  void initState() {
    super.initState();
  }

  @override
  void didInitState() async {
    this.isLoading = true;
    setState(() {});
    replycount = await Fcubereply.getReplyCount(FcubereplySearch(
        cubeuuid: fcubeextender1.cubeuuid, bgroup: 0, limit: 0, offset: 0));
    totalexpPoint = (await UserExpPointHistroy.getCubeuuidGetPoint(
            fcubeextender1.cubeuuid, ""))
        .toInt();
    makeexpPoint = (await UserExpPointHistroy.getCubeuuidGetPoint(
            fcubeextender1.cubeuuid, "makeExp"))
        .toInt();
    valuationexpPoint = (await UserExpPointHistroy.getCubeuuidGetPoint(
            fcubeextender1.cubeuuid, "valuationExp"))
        .toInt();
    fcubeSponsorsearch = FcubeSponsorSearch(
        cubeuuid: fcubeextender1.cubeuuid,
        isdesc: true,
        limit: 3,
        offset: 0,
        orderby: 'sendTime');
    sumSponsorPointValue =
        await FcubeSponsor.getCubeSponsorSumPointValue(fcubeSponsorsearch);
    cubeSponsorCount =
        await FcubeSponsor.getCubeSponsorCount(fcubeSponsorsearch);
    cubeSponsorCount =
        await FcubeSponsor.getCubeSponsorCount(fcubeSponsorsearch);
    fcubeSponsorlist.addAll(
        await FcubeSponsorExtender1.getSponsorForCubeuuid(fcubeSponsorsearch));
    this.isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
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
                    BasicInfoPanel(
                        fcubeextender1: fcubeextender1, replycount: replycount),
                    ExpPointPanel(
                        totalexpPoint: totalexpPoint,
                        makeexpPoint: makeexpPoint,
                        valuationexpPoint: valuationexpPoint),
                    SponsorPanel(
                        sumSponsorPointValue: sumSponsorPointValue,
                        cubeSponsorCount: cubeSponsorCount,
                        fcubeSponsorlist: fcubeSponsorlist,
                        fcubeextender1: fcubeextender1)
                  ],
                ),
              )
            ])),
        isLoading
            ? Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Colors.grey.withOpacity(0.5),
                child: Center(
                    child: Container(
                  height: 100,
                  width: 100,
                  child: Loading(
                      indicator: BallScaleIndicator(),
                      size: 50.0,
                      color: Theme.of(context).accentColor),
                )),
              )
            : Container()
      ],
    );
  }
}

class ExpPointPanel extends StatelessWidget {
  const ExpPointPanel({
    Key key,
    @required this.totalexpPoint,
    @required this.makeexpPoint,
    @required this.valuationexpPoint,
  }) : super(key: key);

  final int totalexpPoint;
  final int makeexpPoint;
  final int valuationexpPoint;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(16),
        width: MediaQuery.of(context).size.width,
        height: 145,
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
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 21,
              left: 16,
              child: Text("EXP 보상",
                  style: TextStyle(
                    fontFamily: "Noto Sans CJK KR",
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: Color(0xff454f63),
                  )),
            ),
            Positioned(
                top: 51,
                left: 16,
                child: Container(
                    height: 42.00,
                    width: 42.00,
                    child: Icon(
                      ForutonaIcon.bigexppoint,
                      color: Color(0xff78849E),
                      size: 32,
                    ),
                    decoration: BoxDecoration(
                        color: Color(0xffe4e7e8),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0.00, 12.00),
                            color: Color(0xff455b63).withOpacity(0.10),
                            blurRadius: 16,
                          ),
                        ],
                        shape: BoxShape.circle))),
            Positioned(
                top: 58,
                left: 73,
                child: Container(
                  child: Text("총 획득 EXP",
                      style: TextStyle(
                        fontFamily: "Noto Sans CJK KR",
                        fontWeight: FontWeight.w700,
                        fontSize: 11,
                        color: Color(0xff454f63),
                      )),
                )),
            Positioned(
                top: 75,
                left: 73,
                child: Container(
                  child: Text("제작 EXP와 평가 EXP를 모두 \n합산한 경험치입니다.",
                      style: TextStyle(
                        fontFamily: "Noto Sans CJK KR",
                        fontSize: 11,
                        color: Color(0xff454f63),
                      )),
                )),
            Positioned(
              top: 48,
              right: 16,
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(right: 5),
                      child: Text("$totalexpPoint",
                          style: TextStyle(
                            fontFamily: "Noto Sans CJK KR",
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: Color(0xff3ec481),
                          )),
                    ),
                    Icon(
                      ForutonaIcon.smallexppoint,
                      color: Color(0xff3ec481),
                      size: 15,
                    )
                  ]),
            ),
            Positioned(
                top: 74,
                right: 16,
                child: Container(
                    padding: EdgeInsets.all(5),
                    child: Row(
                      children: <Widget>[
                        Container(
                            margin: EdgeInsets.only(right: 6),
                            child: Text("제작 EXP",
                                style: TextStyle(
                                  fontFamily: "Noto Sans CJK KR",
                                  fontSize: 9,
                                  color: Color(0xff78849e),
                                ))),
                        makeexpPoint >= 0
                            ? Text("+ $makeexpPoint",
                                style: TextStyle(
                                  fontFamily: "Noto Sans CJK KR",
                                  fontWeight: FontWeight.w700,
                                  fontSize: 10,
                                  color: Color(0xff78849e),
                                ))
                            : Text("- $makeexpPoint",
                                style: TextStyle(
                                  fontFamily: "Noto Sans CJK KR",
                                  fontWeight: FontWeight.w700,
                                  fontSize: 10,
                                  color: Color(0xff78849e),
                                ))
                      ],
                    ),
                    height: 22.00,
                    decoration: BoxDecoration(
                      color: Color(0xff3ec481).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12.00),
                    ))),
            Positioned(
                top: 102,
                right: 16,
                child: Container(
                    padding: EdgeInsets.all(5),
                    child: Row(
                      children: <Widget>[
                        Container(
                            margin: EdgeInsets.only(right: 6),
                            child: Text("평가 EXP",
                                style: TextStyle(
                                  fontFamily: "Noto Sans CJK KR",
                                  fontSize: 9,
                                  color: Color(0xff78849e),
                                ))),
                        makeexpPoint >= 0
                            ? Text("+ $valuationexpPoint",
                                style: TextStyle(
                                  fontFamily: "Noto Sans CJK KR",
                                  fontWeight: FontWeight.w700,
                                  fontSize: 10,
                                  color: Color(0xff78849e),
                                ))
                            : Text("- $valuationexpPoint",
                                style: TextStyle(
                                  fontFamily: "Noto Sans CJK KR",
                                  fontWeight: FontWeight.w700,
                                  fontSize: 10,
                                  color: Color(0xff78849e),
                                ))
                      ],
                    ),
                    height: 22.00,
                    decoration: BoxDecoration(
                      color: Color(0xff3ec481).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12.00),
                    )))
          ],
        ));
  }
}

class BasicInfoPanel extends StatelessWidget {
  const BasicInfoPanel({
    Key key,
    @required this.fcubeextender1,
    @required this.replycount,
  }) : super(key: key);

  final FcubeExtender1 fcubeextender1;
  final int replycount;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                          color: Color(0xff455b63).withOpacity(0.10),
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
                          color: Color(0xff455b63).withOpacity(0.10),
                          blurRadius: 16,
                        ),
                      ],
                      shape: BoxShape.circle),
                ),
                Container(
                    margin: EdgeInsets.fromLTRB(16, 0, 0, 0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                          color: Color(0xff455b63).withOpacity(0.10),
                          blurRadius: 16,
                        ),
                      ],
                      shape: BoxShape.circle),
                ),
                Container(
                    margin: EdgeInsets.fromLTRB(16, 0, 0, 0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
            ]));
  }
}
