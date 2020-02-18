import 'dart:async';
import 'dart:typed_data';

import 'package:after_init/after_init.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:forutonafront/Common/FcubeDescription.dart';
import 'package:forutonafront/Common/LoadingOverlay.dart';
import 'package:forutonafront/Common/marker_generator.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:forutonafront/MakePage/Component/FcubeExtender1.dart';
import 'package:forutonafront/MakePage/FcubeTypes.dart';
import 'package:forutonafront/MakePage/Fcubecontent.dart';
import 'package:forutonafront/globals.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loading/indicator/ball_scale_indicator.dart';
import 'package:loading/loading.dart';
import 'package:intl/intl.dart';

class ID001CubeDetailPage extends StatefulWidget {
  final FcubeExtender1 fcubeextender1;
  ID001CubeDetailPage({@required this.fcubeextender1, Key key})
      : super(key: key);

  @override
  _ID001CubeDetailPageState createState() {
    return _ID001CubeDetailPageState(this.fcubeextender1);
  }
}

class _ID001CubeDetailPageState extends State<ID001CubeDetailPage>
    with AfterInitMixin {
  _ID001CubeDetailPageState(this.fcubeextender1);
  FcubeExtender1 fcubeextender1;
  CameraPosition initialCameraPosition;
  GoogleMapController mapController;
  Set<Marker> markers;
  Map<FcubeType, Uint8List> markeritem = Map<FcubeType, Uint8List>();
  bool isappBartitle = false;
  Timer timer;
  bool isLoading = false;
  Map<FcubecontentType, Fcubecontent> contents;
  FcubeDescription description;
  @override
  void initState() {
    super.initState();
    initialCameraPosition = new CameraPosition(
        target: LatLng(fcubeextender1.latitude, fcubeextender1.longitude),
        zoom: 16);
    markers = Set<Marker>();

    List<Widget> markerwidget = List<Widget>();
    markerwidget.add(getMakerWidget(FcubeType.questCube));
    markerwidget.add(getMakerWidget(FcubeType.issuecube));
    MarkerGenerator(markerwidget, (bitmaps) {
      bitmaps.asMap().forEach((i, bmp) {
        if (i == 0) {
          markeritem[FcubeType.questCube] = bmp;
        } else if (i == 1) {
          markeritem[FcubeType.issuecube] = bmp;
        }
      });
      initMakers();
    }).generate(context);
    Timer.periodic(Duration(seconds: 1), (timer) {
      this.timer = timer;
      setState(() {});
    });
  }

  @override
  void didInitState() async {
    this.isLoading = true;
    setState(() {});
    String uid = GlobalStateContainer.of(context).state.userInfoMain.uid;
    List<FcubecontentType> types = List<FcubecontentType>();
    types.add(FcubecontentType.description);

    contents = await Fcubecontent.getFcubecontent(FcubeContentSelector(
        cubeuuid: fcubeextender1.cubeuuid, uid: uid, contenttypes: types));
    description = FcubeDescription.fromRawJson(
        contents[FcubecontentType.description].contentvalue);
    this.isLoading = false;
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    if (this.timer != null) {
      this.timer.cancel();
    }
  }

  initMakers() {
    markers.add(new Marker(
        anchor: Offset(0.5, 0.5),
        markerId: MarkerId(fcubeextender1.cubeuuid),
        icon: BitmapDescriptor.fromBytes(markeritem[fcubeextender1.cubetype]),
        position: LatLng(fcubeextender1.latitude, fcubeextender1.longitude)));
    setState(() {});
  }

  Widget getMakerWidget(FcubeType cubetype) {
    if (cubetype == FcubeType.questCube) {
      return Container(
          alignment: Alignment.center,
          child: Container(
            height: 35.00,
            width: 35.00,
            decoration: BoxDecoration(
              color: Color(0xff4f72ff),
              shape: BoxShape.circle,
            ),
            child: Icon(
              ForutonaIcon.quest,
              size: 20,
              color: Colors.white,
            ),
          ),
          height: 92.00,
          width: 92.00,
          decoration: BoxDecoration(
            color: Color(0xff39f999).withOpacity(0.17),
            boxShadow: [
              BoxShadow(
                offset: Offset(0.00, 4.00),
                color: Color(0xff321636).withOpacity(0.04),
                blurRadius: 12,
              ),
            ],
            shape: BoxShape.circle,
          ));
    } else if (cubetype == FcubeType.issuecube) {
      return Container(
          alignment: Alignment.center,
          child: Container(
            height: 35.00,
            width: 35.00,
            padding: EdgeInsets.only(left: 3),
            decoration: BoxDecoration(
              color: Color(0xffdc3e57),
              shape: BoxShape.circle,
            ),
            child: Icon(
              ForutonaIcon.issue,
              size: 20,
              color: Colors.white,
            ),
          ),
          height: 92.00,
          width: 92.00,
          decoration: BoxDecoration(
            color: Color(0xff39f999).withOpacity(0.17),
            boxShadow: [
              BoxShadow(
                offset: Offset(0.00, 4.00),
                color: Color(0xff321636).withOpacity(0.04),
                blurRadius: 12,
              ),
            ],
            shape: BoxShape.circle,
          ));
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    final GoogleMap googleMap = GoogleMap(
        onTap: (LatLng lat) {
          print("tap1");
        },
        onMapCreated: (GoogleMapController controller) {
          mapController = controller;
        },
        markers: markers,
        initialCameraPosition: initialCameraPosition);

    return LoadingOverlay(
      isLoading: isLoading,
      progressIndicator: Loading(
          indicator: BallScaleIndicator(),
          size: 100.0,
          color: Theme.of(context).accentColor),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          titleSpacing: 0,
          elevation: 0,
          actions: <Widget>[
            IconButton(
              icon: Icon(ForutonaIcon.share),
            ),
            IconButton(
              icon: Icon(ForutonaIcon.setting),
            ),
          ],
          title: Container(
              child: Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 2),
                height: 35.00,
                width: 35.00,
                child: Icon(
                  ForutonaIcon.issue,
                  size: 20,
                  color: Colors.white,
                ),
                decoration: BoxDecoration(
                  color: Color(0xffdc3e57),
                  border: Border.all(
                    width: 1.00,
                    color: Color(0xffdc3e57),
                  ),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0.00, 3.00),
                      color: Color(0xff000000).withOpacity(0.16),
                      blurRadius: 6,
                    ),
                  ],
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(
                width: 16,
              ),
              isappBartitle
                  ? Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Text(fcubeextender1.cubename,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: "Noto Sans CJK KR",
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                            color: Color(0xff454f63),
                          )),
                    )
                  : Container(),
            ],
          )),
        ),
        body: NotificationListener<ScrollNotification>(
          onNotification: (nonification) {
            if (nonification is ScrollUpdateNotification) {
              ScrollUpdateNotification noti = nonification;
              if ((noti.metrics.pixels >
                  MediaQuery.of(context).size.height * 0.1)) {
                isappBartitle = true;
                setState(() {});
              } else {
                isappBartitle = false;
              }
            }
          },
          child: ListView(
            children: <Widget>[
              Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: Stack(
                    children: <Widget>[
                      googleMap,
                      GestureDetector(
                          onTap: () {
                            print("tap");
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                  Colors.white.withOpacity(0.8),
                                  Colors.white.withOpacity(0)
                                ])),
                          )),
                      Positioned(
                          top: 0,
                          child: isappBartitle
                              ? Container()
                              : TitleWidget(fcubeextender1: fcubeextender1))
                    ],
                  )),
              MakerPanel(fcubeextender1: fcubeextender1),
              SizedBox(
                height: 16,
              ),
              PlaceAddressPanel(fcubeextender1: fcubeextender1),
              SizedBox(
                height: 16,
              ),
              RemindTimePanel(fcubeextender1: fcubeextender1),
              SizedBox(
                height: 16,
              ),
              ContributorPanel(fcubeextender1: fcubeextender1),
              SizedBox(
                height: 16,
              ),
              description != null
                  ? DescriptionImageSwiper(description: description)
                  : Container(),
              SizedBox(
                height: 16,
              ),
              description != null
                  ? DescriptionText(description: description)
                  : Container(),
              SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DescriptionText extends StatelessWidget {
  const DescriptionText({
    Key key,
    @required this.description,
  }) : super(key: key);

  final FcubeDescription description;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
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
                margin: EdgeInsets.only(bottom: 16),
                child: Text("상세 설명",
                    style: TextStyle(
                      fontFamily: "Noto Sans CJK KR",
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: Color(0xff454f63),
                    ))),
            Container(
              margin: EdgeInsets.only(bottom: 16),
              child: Text(description.text,
                  style: TextStyle(
                    fontFamily: "Noto Sans CJK KR",
                    fontSize: 14,
                    color: Color(0xff78849e),
                  )),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  child: Text(
                      "${DateFormat("yyyy-MM-dd").format(description.writetime.toLocal())} 등록함",
                      style: TextStyle(
                        fontFamily: "Noto Sans CJK KR",
                        fontSize: 14,
                        color: Color(0xff78849e),
                      )),
                ),
                description.havemodify
                    ? Container(
                        child: Text("(수정됨)",
                            style: TextStyle(
                              fontFamily: "Noto Sans CJK KR",
                              fontSize: 9,
                              color: Color(0xffb1b1b1),
                            )),
                      )
                    : Container()
              ],
            )
          ],
        ));
  }
}

class DescriptionImageSwiper extends StatelessWidget {
  const DescriptionImageSwiper({
    Key key,
    @required this.description,
  }) : super(key: key);

  final FcubeDescription description;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240,
      child: Swiper(
        viewportFraction: 0.8,
        scale: 0.9,
        itemCount: description.desimages.length,
        itemBuilder: (context, index) {
          return Container(
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(description.desimages[index].src),
                    fit: BoxFit.fitWidth),
                borderRadius: BorderRadius.circular(12.00)),
          );
        },
      ),
    );
  }
}

class ContributorPanel extends StatelessWidget {
  const ContributorPanel({
    Key key,
    @required this.fcubeextender1,
  }) : super(key: key);

  final FcubeExtender1 fcubeextender1;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
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
      child: Row(
        children: <Widget>[
          Container(
            child: Icon(
              ForutonaIcon.contributor,
              color: Color(0xff707070),
            ),
            height: 42.00,
            width: 42.00,
            decoration: BoxDecoration(
              color: Color(0xffe4e7e8),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0.00, 12.00),
                  color: Color(0xff455b63).withOpacity(0.10),
                  blurRadius: 16,
                ),
              ],
              borderRadius: BorderRadius.circular(20.00),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("기여자",
                    style: TextStyle(
                      fontFamily: "Noto Sans CJK KR",
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: Color(0xff454f63),
                    )),
                Text(
                    "${fcubeextender1.cubelikes + fcubeextender1.cubedislikes}명이 반응 하였습니다.",
                    style: TextStyle(
                      fontFamily: "Noto Sans CJK KR",
                      fontSize: 14,
                      color: Color(0xff78849e),
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class RemindTimePanel extends StatelessWidget {
  const RemindTimePanel({
    Key key,
    @required this.fcubeextender1,
  }) : super(key: key);

  final FcubeExtender1 fcubeextender1;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
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
      child: Row(
        children: <Widget>[
          Container(
            child: Icon(
              ForutonaIcon.whatshot,
              color: Color(0xff707070),
            ),
            height: 42.00,
            width: 42.00,
            decoration: BoxDecoration(
              color: Color(0xffe4e7e8),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0.00, 12.00),
                  color: Color(0xff455b63).withOpacity(0.10),
                  blurRadius: 16,
                ),
              ],
              borderRadius: BorderRadius.circular(20.00),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("남은 시간",
                    style: TextStyle(
                      fontFamily: "Noto Sans CJK KR",
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: Color(0xff454f63),
                    )),
                Text("${fcubeextender1.remindActiveTimetoString()}",
                    style: TextStyle(
                      fontFamily: "Noto Sans CJK KR",
                      fontSize: 14,
                      color: Color(0xff78849e),
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class TitleWidget extends StatelessWidget {
  const TitleWidget({
    Key key,
    @required this.fcubeextender1,
  }) : super(key: key);

  final FcubeExtender1 fcubeextender1;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: 16),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                  child: Text("이슈볼",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontFamily: "Noto Sans CJK KR",
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                        color: Color(0xffff4f9a),
                      ))),
              Container(
                  child: Text(fcubeextender1.cubename,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontFamily: "Noto Sans CJK KR",
                        fontWeight: FontWeight.w700,
                        fontSize: 19,
                        color: Color(0xff454f63),
                      ))),
              Container(
                  child: Row(children: <Widget>[
                Container(
                  child: Icon(
                    ForutonaIcon.visibility,
                    color: Color(0xff78849E),
                    size: 20,
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(left: 5),
                    child: Text("${fcubeextender1.cubehits}",
                        style: TextStyle(
                          fontFamily: "Gibson",
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: Color(0xff78849e),
                        )))
              ]))
            ]));
  }
}

class PlaceAddressPanel extends StatelessWidget {
  const PlaceAddressPanel({
    Key key,
    @required this.fcubeextender1,
  }) : super(key: key);

  final FcubeExtender1 fcubeextender1;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
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
      child: Row(
        children: <Widget>[
          Container(
            height: 42.00,
            width: 42.00,
            child: Icon(
              Icons.location_on,
              color: Color(0xff707070),
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
              borderRadius: BorderRadius.circular(20.00),
            ),
          ),
          Container(
              margin: EdgeInsets.only(left: 16),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("설치 장소",
                        style: TextStyle(
                          fontFamily: "Noto Sans CJK KR",
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color: Color(0xff454f63),
                        )),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.68,
                        child: Text("${fcubeextender1.placeaddress}",
                            softWrap: true,
                            style: TextStyle(
                              fontFamily: "Noto Sans CJK KR",
                              fontSize: 14,
                              color: Color(0xff78849e),
                            )))
                  ]))
        ],
      ),
    );
  }
}

class MakerPanel extends StatelessWidget {
  const MakerPanel({
    Key key,
    @required this.fcubeextender1,
  }) : super(key: key);

  final FcubeExtender1 fcubeextender1;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 105,
        margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
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
                margin: EdgeInsets.fromLTRB(16, 16, 16, 16),
                child: Text("메이커",
                    style: TextStyle(
                      fontFamily: "Noto Sans CJK KR",
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: Color(0xff454f63),
                    )),
              ),
              Container(
                  child: Row(children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
                  height: 41.00,
                  width: 41.00,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(fcubeextender1.profilepicktureurl),
                    ),
                    borderRadius: BorderRadius.circular(50.00),
                  ),
                ),
                Expanded(
                    child: Container(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                      Text(fcubeextender1.nickname,
                          style: TextStyle(
                            fontFamily: "Noto Sans CJK KR",
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Color(0xff78849e),
                          )),
                      Text("팔로워 ${fcubeextender1.followcount}",
                          style: TextStyle(
                            fontFamily: "Noto Sans CJK KR",
                            fontWeight: FontWeight.w500,
                            fontSize: 11,
                            color: Color(0xffb1b1b1),
                          )),
                    ]))),
                Container(
                    height: 30.00,
                    width: 30.00,
                    child: FlatButton(
                        onPressed: () {},
                        padding: EdgeInsets.all(0),
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                        )),
                    decoration: BoxDecoration(
                      color: Color(0xff78849e),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0.00, 3.00),
                          color: Color(0xff000000).withOpacity(0.16),
                          blurRadius: 6,
                        )
                      ],
                      shape: BoxShape.circle,
                    )),
                SizedBox(
                  width: 16,
                )
              ]))
            ]));
  }
}
