import 'package:after_init/after_init.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/Common/FcubeSponsor.dart';
import 'package:forutonafront/Common/FcubeSponsorExtender1.dart';
import 'package:forutonafront/Common/FcubeSponsorSearch.dart';
import 'package:forutonafront/Common/LoadingOverlay.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:forutonafront/MakePage/Component/FcubeExtender1.dart';
import 'package:intl/intl.dart';
import 'package:loading/indicator/ball_scale_indicator.dart';
import 'package:loading/loading.dart';

class ID001SponsorDetailPage extends StatefulWidget {
  ID001SponsorDetailPage({this.fcubeExtender1, key}) : super(key: key);
  final FcubeExtender1 fcubeExtender1;

  @override
  _ID001SponsorDetailPageState createState() {
    return _ID001SponsorDetailPageState(fcubeExtender1: fcubeExtender1);
  }
}

class _ID001SponsorDetailPageState extends State<ID001SponsorDetailPage>
    with AfterInitMixin {
  _ID001SponsorDetailPageState({this.fcubeExtender1});
  FcubeExtender1 fcubeExtender1;
  int sumSponsorPointValue = 0;
  int cubeSponsorCount = 0;
  FcubeSponsorSearch fcubeSponsorsearch;
  List<FcubeSponsorExtender1> fcubeSponsorlist = List<FcubeSponsorExtender1>();
  bool isLoading = true;
  @override
  void didInitState() async {
    isLoading = true;
    setState(() {});
    fcubeSponsorsearch = FcubeSponsorSearch(
        cubeuuid: fcubeExtender1.cubeuuid,
        isdesc: true,
        limit: 3,
        offset: 0,
        orderby: 'sendTime');
    sumSponsorPointValue =
        await FcubeSponsor.getCubeSponsorSumPointValue(fcubeSponsorsearch);
    cubeSponsorCount =
        await FcubeSponsor.getCubeSponsorCount(fcubeSponsorsearch);
    fcubeSponsorlist.addAll(
        await FcubeSponsorExtender1.getSponsorForCubeuuid(fcubeSponsorsearch));
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
        isLoading: isLoading,
        progressIndicator: Loading(
            indicator: BallScaleIndicator(),
            size: 100.0,
            color: Theme.of(context).accentColor),
        child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              titleSpacing: 0,
              backgroundColor: Colors.white,
              title: Container(
                  child: Row(children: <Widget>[
                Expanded(
                  child: Container(
                      child: Text("후원 내역",
                          style: TextStyle(
                            fontFamily: "Noto Sans CJK KR",
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                            color: Color(0xff454f63),
                          ))),
                ),
                new Container(
                  margin: EdgeInsets.only(right: 16),
                  height: 32.00,
                  width: 78.00,
                  child: FlatButton(
                      onPressed: () {},
                      child: Text("후원하기",
                          style: TextStyle(
                            fontFamily: "Noto Sans CJK KR",
                            fontWeight: FontWeight.w500,
                            fontSize: 11,
                            color: Color(0xffffffff),
                          ))),
                  decoration: BoxDecoration(
                    color: Color(0xffff4f9a),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0.00, 4.00),
                        color: Color(0xff455b63).withOpacity(0.08),
                        blurRadius: 16,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(12.00),
                  ),
                )
              ])),
            ),
            body: Container(
                margin: EdgeInsets.all(16),
                child: ListView(children: <Widget>[
                  Container(
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
                      padding: EdgeInsets.all(16),
                      child: Column(children: <Widget>[
                        Stack(children: <Widget>[
                          Container(
                              child: Row(children: <Widget>[
                            Container(
                              height: 42.00,
                              width: 42.00,
                              child: Icon(
                                ForutonaIcon.bigyoupoint,
                                size: 28,
                                color: Color(0xff78849E),
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
                                borderRadius: BorderRadius.circular(21.00),
                              ),
                            ),
                            SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  child: Text("후원 포인트",
                                      style: TextStyle(
                                        fontFamily: "Noto Sans CJK KR",
                                        fontWeight: FontWeight.w700,
                                        fontSize: 11,
                                        color: Color(0xff454f63),
                                      )),
                                ),
                                Container(
                                  child: Text("총 후원된 포인트 입니다.",
                                      style: TextStyle(
                                        fontFamily: "Noto Sans CJK KR",
                                        fontSize: 11,
                                        color: Color(0xff454f63),
                                      )),
                                )
                              ],
                            )
                          ])),
                          Positioned(
                              top: 0,
                              right: 0,
                              child: Container(
                                  child: Row(
                                children: <Widget>[
                                  Text(
                                      "${NumberFormat("###,###,###").format(sumSponsorPointValue)}",
                                      style: TextStyle(
                                        fontFamily: "Noto Sans CJK KR",
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16,
                                        color: Color(0xffff4f9a),
                                      )),
                                  Container(
                                      margin: EdgeInsets.fromLTRB(5, 5, 0, 0),
                                      alignment: Alignment.bottomCenter,
                                      child: Icon(ForutonaIcon.smallyoupoint,
                                          size: 12, color: Color(0xffff4f9a)))
                                ],
                              )))
                        ]),
                        Divider(
                          thickness: 2,
                          indent: 16,
                          endIndent: 16,
                          color: Color(0xffF4F4F6),
                        ),
                        Stack(children: <Widget>[
                          Container(
                              child: Row(children: <Widget>[
                            Container(
                              height: 42.00,
                              width: 42.00,
                              child: Icon(
                                ForutonaIcon.sponsorcount,
                                size: 28,
                                color: Color(0xff78849E),
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
                                borderRadius: BorderRadius.circular(21.00),
                              ),
                            ),
                            SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  child: Text("후원자",
                                      style: TextStyle(
                                        fontFamily: "Noto Sans CJK KR",
                                        fontWeight: FontWeight.w700,
                                        fontSize: 11,
                                        color: Color(0xff454f63),
                                      )),
                                ),
                                Container(
                                  child: Text("후원해 주신 모든 분들께 감사드립니다.",
                                      style: TextStyle(
                                        fontFamily: "Noto Sans CJK KR",
                                        fontSize: 11,
                                        color: Color(0xff454f63),
                                      )),
                                )
                              ],
                            )
                          ])),
                          Positioned(
                              top: 0,
                              right: 0,
                              child: Container(
                                  child: Row(
                                children: <Widget>[
                                  Text("$cubeSponsorCount",
                                      style: TextStyle(
                                        fontFamily: "Noto Sans CJK KR",
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20,
                                        color: Color(0xff454f63),
                                      )),
                                ],
                              )))
                        ])
                      ])),
                  Container(
                    margin: EdgeInsets.only(top: 16),
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
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12)),
                    ),
                    child: Container(
                      child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: fcubeSponsorlist.length,
                          itemBuilder: (context, index) {
                            return Container(
                                margin: EdgeInsets.fromLTRB(0, 0, 0, 8),
                                child: Stack(children: <Widget>[
                                  Container(
                                      child: Column(
                                    children: <Widget>[
                                      Row(children: <Widget>[
                                        Container(
                                          height: 62.00,
                                          width: 62.00,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  color: Color(0xffFF4F9A),
                                                  width: 2),
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                    fcubeSponsorlist[index]
                                                        .profilePicktureUrl),
                                              )),
                                        ),
                                        SizedBox(
                                          width: 16,
                                        ),
                                        Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                  "${fcubeSponsorlist[index].nickName}",
                                                  style: TextStyle(
                                                    fontFamily: "Gibson",
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 16,
                                                    color: Color(0xff454f63),
                                                  )),
                                              Text(
                                                  "${fcubeSponsorlist[index].comment}",
                                                  style: TextStyle(
                                                    fontFamily:
                                                        "Noto Sans CJK KR",
                                                    fontSize: 11,
                                                    color: Color(0xff78849e),
                                                  ))
                                            ])
                                      ]),
                                      fcubeSponsorlist.length != (index + 1)
                                          ? Divider(
                                              thickness: 2,
                                              indent: 16,
                                              endIndent: 16,
                                              color: Color(0xffF4F4F6),
                                            )
                                          : Container(),
                                    ],
                                  )),
                                  Positioned(
                                      top: 0,
                                      right: 0,
                                      child: Container(
                                          child: Row(
                                        children: <Widget>[
                                          Text(
                                              "${fcubeSponsorlist[index].pointValue}",
                                              style: TextStyle(
                                                fontFamily: "Noto Sans CJK KR",
                                                fontWeight: FontWeight.w700,
                                                fontSize: 16,
                                                color: Color(0xffff4f9a),
                                              )),
                                          Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  5, 5, 0, 0),
                                              alignment: Alignment.bottomCenter,
                                              child: Icon(
                                                  ForutonaIcon.smallyoupoint,
                                                  size: 12,
                                                  color: Color(0xffff4f9a)))
                                        ],
                                      ))),
                                ]));
                          }),
                    ),
                  ),
                  Container(
                    height: 44,
                    width: MediaQuery.of(context).size.width,
                    child: FlatButton(
                        onPressed: () async {
                          isLoading = true;
                          setState(() {});
                          fcubeSponsorsearch.offset = fcubeSponsorlist.length;
                          fcubeSponsorlist.addAll(
                              await FcubeSponsorExtender1.getSponsorForCubeuuid(
                                  fcubeSponsorsearch));
                          isLoading = false;
                          setState(() {});
                        },
                        child: Container(
                            alignment: Alignment.center,
                            child: Text("더 보기",
                                style: TextStyle(
                                  fontFamily: "Noto Sans CJK KR",
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                  color: Color(0xffffffff),
                                )))),
                    decoration: BoxDecoration(
                      color: Color(0xffFF4F9A),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0.00, 4.00),
                          color: Color(0xff455b63).withOpacity(0.08),
                          blurRadius: 16,
                        )
                      ],
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12)),
                    ),
                  )
                ]))));
  }
}
