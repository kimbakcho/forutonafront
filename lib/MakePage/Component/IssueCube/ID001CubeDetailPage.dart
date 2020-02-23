import 'dart:async';
import 'dart:typed_data';
import 'package:after_init/after_init.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:forutonafront/Common/FcubeDescription.dart';
import 'package:forutonafront/Common/FcubeSponsor.dart';
import 'package:forutonafront/Common/FcubeSponsorExtender1.dart';
import 'package:forutonafront/Common/FcubeSponsorSearch.dart';
import 'package:forutonafront/Common/Fcubereply.dart';
import 'package:forutonafront/Common/FcubereplyExtender1.dart';
import 'package:forutonafront/Common/FcubereplySearch.dart';
import 'package:forutonafront/Common/LoadingOverlay.dart';
import 'package:forutonafront/Common/marker_generator.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:forutonafront/MakePage/Component/FcubeExtender1.dart';
import 'package:forutonafront/MakePage/Component/IssueCube/ID001CubeImageViwer.dart';
import 'package:forutonafront/MakePage/Component/IssueCube/ID001GoogleMapInner.dart';
import 'package:forutonafront/MakePage/Component/IssueCube/ID001SponsorDetailPage.dart';
import 'package:forutonafront/MakePage/FcubeTypes.dart';
import 'package:forutonafront/MakePage/Fcubecontent.dart';
import 'package:forutonafront/globals.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loading/indicator/ball_scale_indicator.dart';
import 'package:loading/loading.dart';
import 'package:intl/intl.dart';

class ID001CubeDetailPage extends StatefulWidget {
  final FcubeExtender1 fcubeextender1;
  final bool initmodifyflag;
  ID001CubeDetailPage(
      {@required this.fcubeextender1, this.initmodifyflag, Key key})
      : super(key: key);

  @override
  _ID001CubeDetailPageState createState() {
    return _ID001CubeDetailPageState(this.fcubeextender1);
  }
}

class _ID001CubeDetailPageState extends State<ID001CubeDetailPage>
    with AfterInitMixin {
  _ID001CubeDetailPageState(this.fcubeextender1);
  bool initmodifyflag = false;
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
  TextEditingController textEditingController = new TextEditingController();
  bool replybtnactive = false;
  List<FcubereplyExtender1> replylist = new List<FcubereplyExtender1>();
  List<FcubereplyExtender1> currentrereplylist =
      new List<FcubereplyExtender1>();
  FcubereplySearch groupsearch;
  FcubeSponsorSearch fcubeSponsorsearch;
  List<FcubeSponsorExtender1> fcubeSponsorlist = List<FcubeSponsorExtender1>();
  int sumSponsorPointValue = 0;
  int cubeSponsorCount = 0;
  bool replymode1 = false;
  bool replymode2 = false;
  bool backgroundblock = false;
  bool iskeyboardshow = false;
  int currentreplycount = 0;
  int currentbgroup = 0;
  int totalreplycount = 0;
  bool isappicon = false;
  ScrollController _listscrollcontroller;

  @override
  void initState() {
    super.initState();
    initmodifyflag = widget.initmodifyflag;
    initialCameraPosition = new CameraPosition(
        target: LatLng(fcubeextender1.latitude, fcubeextender1.longitude),
        zoom: 16);
    markers = Set<Marker>();
    if (initmodifyflag) {
      backgroundblock = true;
    } else {
      backgroundblock = false;
    }
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
    KeyboardVisibilityNotification().addNewListener(
      onChange: (bool visible) {
        if (!visible) {
          replymode1 = false;
          replymode2 = false;
          backgroundblock = false;
          currentrereplylist.clear();
        }
        setState(() {
          this.iskeyboardshow = visible;
        });
      },
    );
    _listscrollcontroller = ScrollController();
    _listscrollcontroller.addListener(_onlistscrollListener);
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
    groupsearch = FcubereplySearch(
        cubeuuid: fcubeextender1.cubeuuid, limit: 5, offset: 0, bgroup: 0);
    replylist
        .addAll(await FcubereplyExtender1.selectReplyForCubeGroup(groupsearch));
    totalreplycount = await Fcubereply.getReplyCount(groupsearch);
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
    fcubeSponsorlist.addAll(
        await FcubeSponsorExtender1.getSponsorForCubeuuid(fcubeSponsorsearch));

    this.isLoading = false;
    setState(() {});
  }

  _onlistscrollListener() {
    //바탐
    if (_listscrollcontroller.offset >=
            _listscrollcontroller.position.maxScrollExtent &&
        !_listscrollcontroller.position.outOfRange) {
      bottmappendcubelist();
    }
  }

  bottmappendcubelist() async {
    this.isLoading = true;
    setState(() {});
    groupsearch = FcubereplySearch(
        cubeuuid: fcubeextender1.cubeuuid,
        limit: 5,
        offset: replylist.length,
        bgroup: 0);
    replylist
        .addAll(await FcubereplyExtender1.selectReplyForCubeGroup(groupsearch));
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
        onMapCreated: (GoogleMapController controller) {
          mapController = controller;
        },
        markers: markers,
        initialCameraPosition: initialCameraPosition);
    AppBar appbar = AppBar(
      backgroundColor: Colors.white,
      titleSpacing: 0,
      elevation: 0,
      actions: <Widget>[
        IconButton(
          onPressed: () {},
          icon: Icon(ForutonaIcon.share),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(ForutonaIcon.setting),
        ),
      ],
      title: Container(
          child: Row(
        children: <Widget>[
          isappicon
              ? Container(
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
                )
              : Container(),
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
    );
    return LoadingOverlay(
      isLoading: isLoading,
      progressIndicator: Loading(
          indicator: BallScaleIndicator(),
          size: 100.0,
          color: Theme.of(context).accentColor),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(children: <Widget>[
          NotificationListener<ScrollNotification>(
              onNotification: (nonification) {
                if (nonification is ScrollUpdateNotification) {
                  ScrollUpdateNotification noti = nonification;
                  if (noti.metrics.pixels >= 20) {
                    isappicon = true;
                  } else {
                    isappicon = false;
                  }
                  if ((noti.metrics.pixels > 40)) {
                    isappBartitle = true;
                    setState(() {});
                  } else {
                    isappBartitle = false;
                  }
                }
              },
              child: Container(
                  margin: EdgeInsets.only(top: appbar.preferredSize.height),
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    controller: _listscrollcontroller,
                    children: <Widget>[
                      Container(
                          height: MediaQuery.of(context).size.height * 0.4,
                          child: Stack(
                            children: <Widget>[
                              googleMap,
                              GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) {
                                      return ID001GoogleMapInner(
                                          fcubeExtender1: fcubeextender1);
                                    }));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            stops: [
                                          0.15,
                                          1
                                        ],
                                            colors: [
                                          Colors.white.withOpacity(1),
                                          Colors.white.withOpacity(0)
                                        ])),
                                  )),
                              Positioned(
                                  top: 0,
                                  child: Container(
                                      margin: EdgeInsets.only(left: 16),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            SizedBox(
                                              height: 20,
                                            ),
                                            !isappicon
                                                ? Container(
                                                    margin: EdgeInsets.fromLTRB(
                                                        0, 0, 0, 0),
                                                    child: Text("이슈볼",
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: TextStyle(
                                                          fontFamily:
                                                              "Noto Sans CJK KR",
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontSize: 12,
                                                          color:
                                                              Color(0xffff4f9a),
                                                        )))
                                                : Container(),
                                            !isappBartitle
                                                ? Container(
                                                    child: Text(
                                                        fcubeextender1.cubename,
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: TextStyle(
                                                          fontFamily:
                                                              "Noto Sans CJK KR",
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontSize: 19,
                                                          color:
                                                              Color(0xff454f63),
                                                        )))
                                                : Container(),
                                            !isappBartitle
                                                ? Container(
                                                    child:
                                                        Row(children: <Widget>[
                                                    Container(
                                                      child: Icon(
                                                        ForutonaIcon.visibility,
                                                        color:
                                                            Color(0xff78849E),
                                                        size: 20,
                                                      ),
                                                    ),
                                                    Container(
                                                        margin: EdgeInsets.only(
                                                            left: 5),
                                                        child: Text(
                                                            "${fcubeextender1.cubehits}",
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  "Gibson",
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 14,
                                                              color: Color(
                                                                  0xff78849e),
                                                            )))
                                                  ]))
                                                : Container()
                                          ])))
                            ],
                          )),
                      MakerPanel(fcubeextender1: fcubeextender1),
                      SizedBox(
                        height: 16,
                      ),
                      Container(
                        margin: EdgeInsets.all(16),
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
                          children: <Widget>[
                            PlaceAddressPanel(fcubeextender1: fcubeextender1),
                            Divider(
                              thickness: 2,
                              indent: 16,
                              endIndent: 16,
                              color: Color(0xffF4F4F6),
                            ),
                            RemindTimePanel(fcubeextender1: fcubeextender1),
                            Divider(
                              thickness: 2,
                              indent: 16,
                              endIndent: 16,
                              color: Color(0xffF4F4F6),
                            ),
                            ContributorPanel(fcubeextender1: fcubeextender1),
                          ],
                        ),
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
                          margin: EdgeInsets.all(16),
                          padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                          child: Column(children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(bottom: 16),
                              alignment: Alignment.centerLeft,
                              child: Text("후원 내역",
                                  style: TextStyle(
                                    fontFamily: "Noto Sans CJK KR",
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                    color: Color(0xff454f63),
                                  )),
                            ),
                            Stack(children: <Widget>[
                              Container(
                                  // margin: EdgeInsets.only(bottom: 16),
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
                                        color:
                                            Color(0xff455b63).withOpacity(0.10),
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
                                          margin:
                                              EdgeInsets.fromLTRB(5, 5, 0, 0),
                                          alignment: Alignment.bottomCenter,
                                          child: Icon(
                                              ForutonaIcon.smallyoupoint,
                                              size: 12,
                                              color: Color(0xffff4f9a)))
                                    ],
                                  )))
                            ]),
                            Divider(
                              thickness: 2,
                              indent: 16,
                              endIndent: 16,
                              color: Color(0xffF4F4F6),
                            ),
                            Stack(
                              children: <Widget>[
                                Container(
                                    margin: EdgeInsets.only(bottom: 16),
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
                                              color: Color(0xff455b63)
                                                  .withOpacity(0.10),
                                              blurRadius: 16,
                                            ),
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(21.00),
                                        ),
                                      ),
                                      SizedBox(width: 16),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            child: Text("후원자",
                                                style: TextStyle(
                                                  fontFamily:
                                                      "Noto Sans CJK KR",
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 11,
                                                  color: Color(0xff454f63),
                                                )),
                                          ),
                                          Container(
                                            child: Text("후원해 주신 모든 분들께 감사드립니다.",
                                                style: TextStyle(
                                                  fontFamily:
                                                      "Noto Sans CJK KR",
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
                              ],
                            ),
                            Divider(
                              thickness: 2,
                              indent: 16,
                              endIndent: 16,
                              color: Color(0xffF4F4F6),
                            ),
                            ListView.builder(
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
                                                        color:
                                                            Color(0xffFF4F9A),
                                                        width: 2),
                                                    image: DecorationImage(
                                                      image: NetworkImage(
                                                          fcubeSponsorlist[
                                                                  index]
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
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 16,
                                                          color:
                                                              Color(0xff454f63),
                                                        )),
                                                    Text(
                                                        "${fcubeSponsorlist[index].comment}",
                                                        style: TextStyle(
                                                          fontFamily:
                                                              "Noto Sans CJK KR",
                                                          fontSize: 11,
                                                          color:
                                                              Color(0xff78849e),
                                                        ))
                                                  ])
                                            ]),
                                            Divider(
                                              thickness: 2,
                                              indent: 16,
                                              endIndent: 16,
                                              color: Color(0xffF4F4F6),
                                            )
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
                                                      fontFamily:
                                                          "Noto Sans CJK KR",
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 16,
                                                      color: Color(0xffff4f9a),
                                                    )),
                                                Container(
                                                    margin: EdgeInsets.fromLTRB(
                                                        5, 5, 0, 0),
                                                    alignment:
                                                        Alignment.bottomCenter,
                                                    child: Icon(
                                                        ForutonaIcon
                                                            .smallyoupoint,
                                                        size: 12,
                                                        color:
                                                            Color(0xffff4f9a)))
                                              ],
                                            ))),
                                      ]));
                                }),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 43,
                              child: FlatButton(
                                  onPressed: () async {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) {
                                      return ID001SponsorDetailPage(
                                        fcubeExtender1: fcubeextender1,
                                      );
                                    }));
                                  },
                                  child: Text("전체보기",
                                      style: TextStyle(
                                        fontFamily: "Noto Sans CJK KR",
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16,
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
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Container(
                          height: 87,
                          padding: EdgeInsets.fromLTRB(9, 20, 9, 20),
                          child: FlatButton(
                              onPressed: () {
                                replymode1 = true;
                                backgroundblock = true;
                                setState(() {});
                              },
                              child: TextField(
                                enabled: false,
                                onChanged: (value) {
                                  if (value.length > 0) {
                                    replybtnactive = true;
                                  } else {
                                    replybtnactive = false;
                                  }

                                  setState(() {});
                                },
                                controller: textEditingController,
                                maxLengthEnforced: true,
                                maxLines: null,
                                decoration: InputDecoration(
                                    hintStyle: TextStyle(
                                      fontFamily: "Noto Sans CJK KR",
                                      fontSize: 14,
                                      color: Color(0xff78849e),
                                    ),
                                    hintText: "의견을 남겨 주세요.",
                                    filled: true,
                                    suffixIcon: Container(
                                        width: 30,
                                        margin: EdgeInsets.all(7),
                                        decoration: BoxDecoration(
                                            color: replybtnactive
                                                ? Color(0xFF454F63)
                                                : Color(0xFFCCCCCC),
                                            boxShadow: [
                                              BoxShadow(
                                                offset: Offset(0.00, 4.00),
                                                color: Color(0xff455b63)
                                                    .withOpacity(0.08),
                                                blurRadius: 16,
                                              ),
                                            ],
                                            shape: BoxShape.circle),
                                        child: FlatButton(
                                          shape: CircleBorder(),
                                          padding: EdgeInsets.all(0),
                                          onPressed: () {
                                            if (replybtnactive) {}
                                          },
                                          child: Icon(ForutonaIcon.icn_send,
                                              color: replybtnactive
                                                  ? Color(0xFF39F999)
                                                  : Colors.white,
                                              size: 13),
                                        )),
                                    contentPadding:
                                        EdgeInsets.fromLTRB(23, 0, 15, 0),
                                    fillColor: Colors.white,
                                    disabledBorder: OutlineInputBorder(
                                        gapPadding: 0,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(16)),
                                        borderSide: BorderSide(
                                            color: Color(0xffe4e7e8))),
                                    border: OutlineInputBorder(
                                        gapPadding: 0,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(16)),
                                        borderSide: BorderSide(
                                            color: Color(0xffe4e7e8)))),
                              )),
                          decoration: BoxDecoration(
                            color: Color(0xffe4e7e8),
                            border: Border.all(
                              width: 1.00,
                              color: Color(0xffe4e7e8),
                            ),
                          ),
                        ),
                      ),
                      FCubeReplyList(
                        replylist: replylist,
                        onpushreply: (reply) async {
                          isLoading = true;
                          setState(() {});
                          FcubereplySearch search = FcubereplySearch(
                              bgroup: reply.bgroup,
                              cubeuuid: reply.cubeuuid,
                              limit: 10,
                              offset: 0);
                          currentrereplylist = await FcubereplyExtender1
                              .selectReplyForCubeWithBgroup(search);
                          replymode1 = true;
                          backgroundblock = true;
                          replymode2 = true;
                          currentreplycount = reply.bgroupcount;
                          currentbgroup = reply.bgroup;
                          isLoading = false;
                          setState(() {});
                        },
                      )
                    ],
                  ))),
          Positioned(
              top: 0,
              height: appbar.preferredSize.height +
                  MediaQuery.of(context).padding.top,
              width: MediaQuery.of(context).size.width,
              child: appbar),
          backgroundblock
              ? Container(
                  color: Color(0xff454F63).withOpacity(0.5),
                )
              : Container(),
          initmodifyflag
              ? Positioned(
                  bottom: 0,
                  child: Container(
                      color: Color(0xffffffff),
                      width: MediaQuery.of(context).size.width,
                      height: 112,
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(0),
                            margin: EdgeInsets.fromLTRB(16, 9, 0, 0),
                            child: FlatButton(
                                padding: EdgeInsets.all(0),
                                onPressed: () {
                                  initmodifyflag = false;
                                  backgroundblock = false;
                                  setState(() {});
                                },
                                child: Row(children: <Widget>[
                                  Container(
                                      width: 38,
                                      height: 38,
                                      decoration: BoxDecoration(
                                          color: Color(0xffe4e7e8),
                                          shape: BoxShape.circle),
                                      margin: EdgeInsets.only(right: 16),
                                      child: Icon(ForutonaIcon.panedit,
                                          size: 17, color: Color(0xff454F63))),
                                  Text("수정하기",
                                      style: TextStyle(
                                        fontFamily: "Noto Sans CJK KR",
                                        fontWeight: FontWeight.w700,
                                        fontSize: 17,
                                        color: Color(0xff454f63),
                                      ))
                                ])),
                          ),
                          Divider(
                            height: 1,
                            thickness: 1,
                            color: Color(0xffF4F4F6),
                          ),
                          Container(
                              padding: EdgeInsets.all(0),
                              margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
                              child: FlatButton(
                                  padding: EdgeInsets.all(0),
                                  onPressed: () {
                                    initmodifyflag = false;
                                    backgroundblock = false;
                                    setState(() {});
                                  },
                                  child: Row(children: <Widget>[
                                    Container(
                                        width: 38,
                                        height: 38,
                                        decoration: BoxDecoration(
                                            color: Color(0xffe4e7e8),
                                            shape: BoxShape.circle),
                                        margin: EdgeInsets.only(right: 16),
                                        child: Icon(ForutonaIcon.removepath,
                                            size: 17,
                                            color: Color(0xff454F63))),
                                    Text("삭제하기",
                                        style: TextStyle(
                                          fontFamily: "Noto Sans CJK KR",
                                          fontWeight: FontWeight.w700,
                                          fontSize: 17,
                                          color: Color(0xff454f63),
                                        ))
                                  ])))
                        ],
                      )),
                )
              : Container(),
          replymode2
              ? Positioned(
                  bottom: 0,
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.7,
                            bottom: 90),
                        shrinkWrap: true,
                        itemCount: currentrereplylist.length,
                        itemBuilder: (context, index) {
                          if (currentrereplylist[index].sorts == 0 &&
                              currentrereplylist[index].depth == 0) {
                            return ReplyFirstPanel(
                              currentrereplylist: currentrereplylist[index],
                              currentreplycount: currentreplycount,
                            );
                          } else {
                            return ReplySubPanel(
                                currentrereplylist: currentrereplylist[index]);
                          }
                        }),
                  ))
              : Container(),
          replymode1
              ? Positioned(
                  bottom: 0,
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Column(children: <Widget>[
                        Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(left: 16),
                            width: MediaQuery.of(context).size.width,
                            height: 25,
                            color: Color(0xff78849e),
                            child: replymode2
                                ? Text("답글($currentreplycount)",
                                    style: TextStyle(
                                      fontFamily: "Noto Sans CJK KR",
                                      fontSize: 10,
                                      color: Color(0xffe4e7e8),
                                    ))
                                : Text("댓글($totalreplycount)",
                                    style: TextStyle(
                                      fontFamily: "Noto Sans CJK KR",
                                      fontSize: 10,
                                      color: Color(0xffe4e7e8),
                                    ))),
                        Container(
                            height: 87,
                            padding: EdgeInsets.fromLTRB(9, 20, 9, 20),
                            child: TextField(
                              autofocus: true,
                              onChanged: (value) {
                                if (value.length > 0) {
                                  replybtnactive = true;
                                } else {
                                  replybtnactive = false;
                                }
                                setState(() {});
                              },
                              controller: textEditingController,
                              maxLengthEnforced: true,
                              maxLines: null,
                              decoration: InputDecoration(
                                  hintStyle: TextStyle(
                                    fontFamily: "Noto Sans CJK KR",
                                    fontSize: 14,
                                    color: Color(0xff78849e),
                                  ),
                                  hintText: "의견을 남겨 주세요.",
                                  filled: true,
                                  suffixIcon: Container(
                                      width: 30,
                                      margin: EdgeInsets.all(7),
                                      decoration: BoxDecoration(
                                          color: replybtnactive
                                              ? Color(0xFF454F63)
                                              : Color(0xFFCCCCCC),
                                          boxShadow: [
                                            BoxShadow(
                                              offset: Offset(0.00, 4.00),
                                              color: Color(0xff455b63)
                                                  .withOpacity(0.08),
                                              blurRadius: 16,
                                            ),
                                          ],
                                          shape: BoxShape.circle),
                                      child: FlatButton(
                                        shape: CircleBorder(),
                                        padding: EdgeInsets.all(0),
                                        onPressed: () async {
                                          if (replybtnactive) {
                                            FcubereplyExtender1 reply =
                                                new FcubereplyExtender1();
                                            reply.bgroup =
                                                replymode2 ? currentbgroup : 0;
                                            reply.sorts = 0;
                                            reply.depth = 0;
                                            reply.cubeuuid =
                                                fcubeextender1.cubeuuid;
                                            reply.commenttext =
                                                textEditingController.text;

                                            await reply.makereply();
                                            textEditingController.clear();
                                            isLoading = true;
                                            setState(() {});
                                            groupsearch.limit = 5;
                                            groupsearch.offset = 0;
                                            replylist.clear();
                                            replylist.addAll(
                                                await FcubereplyExtender1
                                                    .selectReplyForCubeGroup(
                                                        groupsearch));
                                            isLoading = false;
                                            setState(() {});

                                            replymode1 = false;
                                            replymode2 = false;
                                            setState(() {});
                                          }
                                        },
                                        child: Icon(ForutonaIcon.icn_send,
                                            color: replybtnactive
                                                ? Color(0xFF39F999)
                                                : Colors.white,
                                            size: 13),
                                      )),
                                  contentPadding:
                                      EdgeInsets.fromLTRB(23, 0, 15, 0),
                                  fillColor: Colors.white,
                                  focusedBorder: OutlineInputBorder(
                                      gapPadding: 0,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(16)),
                                      borderSide:
                                          BorderSide(color: Color(0xffe4e7e8))),
                                  enabledBorder: OutlineInputBorder(
                                      gapPadding: 0,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(16)),
                                      borderSide:
                                          BorderSide(color: Color(0xffe4e7e8))),
                                  border: OutlineInputBorder(
                                      gapPadding: 0,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(16)),
                                      borderSide: BorderSide(
                                          color: Color(0xffe4e7e8)))),
                            ),
                            decoration: BoxDecoration(
                                color: Color(0xffe4e7e8),
                                border: Border.all(
                                  width: 1.00,
                                  color: Color(0xffe4e7e8),
                                )))
                      ])))
              : Container()
        ]),
      ),
    );
  }
}

class ReplySubPanel extends StatelessWidget {
  const ReplySubPanel({
    Key key,
    @required this.currentrereplylist,
  }) : super(key: key);

  final FcubereplyExtender1 currentrereplylist;

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Container(
          margin: EdgeInsets.fromLTRB(16, 1, 16, 0),
          padding: EdgeInsets.only(bottom: 32),
          decoration: BoxDecoration(
            color: Color(0xffe4e7e8),
            border: Border.all(
              width: 1.00,
              color: Color(0xffe4e7e8),
            ),
          ),
          child: Row(children: <Widget>[
            Container(
              margin: EdgeInsets.all(16),
              height: 44,
              width: 44,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image:
                          NetworkImage(currentrereplylist.profilepicktureurl))),
            ),
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.only(top: 16),
                      child: Text("${currentrereplylist.nickname}",
                          style: TextStyle(
                            fontFamily: "Noto Sans CJK KR",
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: Color(0xff454f63),
                          ))),
                  Container(
                      child: Text("${currentrereplylist.commenttext}",
                          style: TextStyle(
                            fontFamily: "Noto Sans CJK KR",
                            fontSize: 14,
                            color: Color(0xff78849e),
                          ))),
                ])
          ])),
      Positioned(
          top: 16,
          right: 0,
          child: FlatButton(
            shape: CircleBorder(),
            child: Icon(
              ForutonaIcon.pointdash,
              size: 17,
            ),
            onPressed: () {},
          )),
      Positioned(
          top: 0,
          left: 40,
          child: Container(
            child: Icon(ForutonaIcon.replysplitbottom,
                size: 10, color: Color(0xff707070)),
          )),
      Positioned(
          bottom: 0,
          left: 40,
          child: Container(
            child: Icon(ForutonaIcon.replysplittop,
                size: 10, color: Color(0xff707070)),
          ))
    ]);
  }
}

class ReplyFirstPanel extends StatelessWidget {
  const ReplyFirstPanel(
      {Key key, @required this.currentrereplylist, this.currentreplycount})
      : super(key: key);
  final int currentreplycount;
  final FcubereplyExtender1 currentrereplylist;

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Container(
        margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
        padding: EdgeInsets.only(bottom: 32),
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
                topLeft: Radius.circular(12), topRight: Radius.circular(12))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(16),
              height: 44,
              width: 44,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image:
                          NetworkImage(currentrereplylist.profilepicktureurl))),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                    margin: EdgeInsets.only(top: 16),
                    child: Text("${currentrereplylist.nickname}",
                        style: TextStyle(
                          fontFamily: "Noto Sans CJK KR",
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: Color(0xff454f63),
                        ))),
                Container(
                    child: Text("${currentrereplylist.commenttext}",
                        style: TextStyle(
                          fontFamily: "Noto Sans CJK KR",
                          fontSize: 14,
                          color: Color(0xff78849e),
                        ))),
                Container(
                    child: Text(
                        "${DateFormat("yyyy-MM-dd a KK:mm").format(currentrereplylist.commenttime.toLocal())}",
                        style: TextStyle(
                          fontFamily: "Noto Sans CJK KR",
                          fontSize: 9,
                          color: Color(0xffb1b1b1),
                        )))
              ],
            )
          ],
        ),
      ),
      Positioned(
        top: 16,
        right: 0,
        child: FlatButton(
          shape: CircleBorder(),
          child: Icon(
            ForutonaIcon.pointdash,
            size: 17,
          ),
          onPressed: () {},
        ),
      ),
      Positioned(
        bottom: 16,
        right: 16,
        child: FlatButton(
          child: Text(
            "답글 ${currentreplycount == 0 ? "" : currentreplycount}",
            style: TextStyle(
              fontFamily: "Noto Sans CJK KR",
              fontWeight: FontWeight.w700,
              fontSize: 14,
              color: Color(0xffFF4F9A),
              decoration: TextDecoration.underline,
            ),
          ),
          onPressed: () {},
        ),
      ),
      Positioned(
        bottom: 0,
        left: 40,
        child: Container(
          child: Icon(ForutonaIcon.replysplittop,
              size: 10, color: Color(0xff707070)),
        ),
      )
    ]);
  }
}

class FCubeReplyList extends StatelessWidget {
  const FCubeReplyList({
    Key key,
    @required this.replylist,
    this.onpushreply,
  }) : super(key: key);
  final Function(FcubereplyExtender1 item) onpushreply;
  final List<FcubereplyExtender1> replylist;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: replylist.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Stack(children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
                  padding: EdgeInsets.only(bottom: 32),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(16),
                        height: 44,
                        width: 44,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: NetworkImage(
                                    replylist[index].profilepicktureurl))),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                              margin: EdgeInsets.only(top: 16),
                              child: Text("${replylist[index].nickname}",
                                  style: TextStyle(
                                    fontFamily: "Noto Sans CJK KR",
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color: Color(0xff454f63),
                                  ))),
                          Container(
                              child: Text("${replylist[index].commenttext}",
                                  style: TextStyle(
                                    fontFamily: "Noto Sans CJK KR",
                                    fontSize: 14,
                                    color: Color(0xff78849e),
                                  ))),
                          Container(
                              child: Text(
                                  "${DateFormat("yyyy-MM-dd a KK:mm").format(replylist[index].commenttime.toLocal())}",
                                  style: TextStyle(
                                    fontFamily: "Noto Sans CJK KR",
                                    fontSize: 9,
                                    color: Color(0xffb1b1b1),
                                  )))
                        ],
                      )
                    ],
                  ),
                ),
                Positioned(
                  top: 16,
                  right: 0,
                  child: FlatButton(
                    shape: CircleBorder(),
                    child: Icon(
                      ForutonaIcon.pointdash,
                      size: 17,
                    ),
                    onPressed: () {},
                  ),
                ),
                Positioned(
                    bottom: 16,
                    right: 16,
                    child: FlatButton(
                        child: Text(
                          "답글 ${replylist[index].bgroupcount == 0 ? "" : replylist[index].bgroupcount}",
                          style: TextStyle(
                            fontFamily: "Noto Sans CJK KR",
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: Color(0xff454f63),
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        onPressed: () {
                          onpushreply(replylist[index]);
                        }))
              ]);
            }));
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
            child: FlatButton(
                child: Container(),
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return ID001CubeImageViwer(
                        description: description, initindex: index);
                  }));
                }),
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
      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xffffffff),
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
      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xffffffff),
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
      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xffffffff),
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
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(fcubeextender1.profilepicktureurl),
                    ),
                    border: Border.all(color: Color(0xffFF4F9A), width: 2),
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
