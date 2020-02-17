import 'dart:async';
import 'dart:typed_data';

import 'package:after_init/after_init.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:forutonafront/Common/FCubeGeoSearchUtil.dart';
import 'package:forutonafront/Common/FcubeDescription.dart';
import 'package:forutonafront/Common/FcubeExtenderMarkerGenerator.dart';
import 'package:forutonafront/Common/Fcubeplayer.dart';
import 'package:forutonafront/Common/FcubeplayerExtender1.dart';
import 'package:forutonafront/Common/GeoSearchUtil.dart';
import 'package:forutonafront/Common/LoadingOverlay.dart';
import 'package:forutonafront/Common/marker_generator.dart';

import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:forutonafront/MakePage/Component/FcubeExtender1.dart';
import 'package:forutonafront/MakePage/FcubeTypes.dart';
import 'package:forutonafront/PlayPage/D001EagerGestureRecognizer.dart';
import 'package:forutonafront/PlayPage/D001JoinPlayerDisPlay.dart';
import 'package:forutonafront/Preference.dart';
import 'package:forutonafront/globals.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loading/indicator/ball_scale_indicator.dart';
import 'package:loading/loading.dart';
import 'package:search_map_place/search_map_place.dart';

import 'dart:ui' as ui;

import 'package:sliding_sheet/sliding_sheet.dart';

class D001Controller {
  Function selecttimerstart;
  Function selecttimerstop;
}

class D001PlayPageView extends StatefulWidget {
  D001PlayPageView({this.d001controller, Key key}) : super(key: key);
  final D001Controller d001controller;

  @override
  _D001PlayPageViewState createState() {
    return _D001PlayPageViewState(d001controller: d001controller);
  }
}

class _D001PlayPageViewState extends State<D001PlayPageView>
    with
        AfterInitMixin,
        AutomaticKeepAliveClientMixin,
        SingleTickerProviderStateMixin {
  _D001PlayPageViewState({this.d001controller}) {
    if (d001controller != null) {
      d001controller.selecttimerstart = () {
        selectedTimer =
            Timer.periodic(Duration(milliseconds: 20), makeSelectedIcon);
      };
      d001controller.selecttimerstop = () {
        if (selectedTimer != null) {
          selectedTimer.cancel();
        }
      };
    }
  }
  D001Controller d001controller;
  static double initlatitude = 37.550944;
  static double initlongitude = 126.990819;
  CameraPosition _kInitialPosition = CameraPosition(
    target: LatLng(initlatitude, initlongitude),
    zoom: 16.0,
  );
  Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers;
  D001EagerGestureRecognizer d001eagerGestureRecognizer;
  double mainOpacity = 0.7;
  bool mapOpacityflag = false;
  Color backgroundColor = Color(0x00000000);
  double mainslidermaxheight = 500;
  double mainsliderminheight = 100;
  GoogleMapController mapcontroller;
  GlobalKey swiperkey = GlobalKey();
  Widget slidingUpPanel;
  //카메라 현재 위치
  Position currentposition =
      Position(latitude: initlatitude, longitude: initlongitude);
  CameraPosition currentCameraposition =
      CameraPosition(target: LatLng(initlatitude, initlongitude), zoom: 16);

  CameraPosition idleCameracCrrentposition =
      CameraPosition(target: LatLng(initlatitude, initlongitude), zoom: 16);

  Geolocator geolocation = Geolocator();
  bool isLoading = false;
  SheetController sheetControllere = new SheetController();
  Set<Marker> markers = new Set<Marker>();
  Set<Circle> circles;
  Tween<double> ladertween = Tween<double>(begin: 60, end: 150);
  Animation<double> laderanimation;
  AnimationController laderanimationcontroller;
  final GlobalKey laderkey = GlobalKey();
  Timer selectedTimer;
  double currentsnapprogess = 0.2;
  int movecameraidlecount = 0;
  SwiperController swiperController = new SwiperController();
  int currentswiperindex = 0;
  Map<FcubeType, Uint8List> markeritem = Map<FcubeType, Uint8List>();
  Timer longStayDeadtimer;
  bool overscrollflag = false;
  double overscrollvalue = 0;
  ScrollController _expandListController;
  Fcubeplayer nowplayer;
  bool iscurrentballplayer = false;

  JoinPlayerDisPlayController joinPlayerDisPlayController;
  @override
  void initState() {
    super.initState();
    joinPlayerDisPlayController = JoinPlayerDisPlayController();
    d001eagerGestureRecognizer = new D001EagerGestureRecognizer(
        duration: Duration(seconds: 1), onLongPress: ongoogleMapBlocklongPress);
    gestureRecognizers = Set()
      ..add(Factory<D001EagerGestureRecognizer>(
          () => d001eagerGestureRecognizer));

    laderanimationcontroller =
        AnimationController(duration: Duration(seconds: 1), vsync: this);
    laderanimation =
        CurvedAnimation(parent: laderanimationcontroller, curve: Curves.easeIn)
          ..addListener(() {
            setState(() {});
          });

    laderanimationcontroller.repeat();
    _expandListController = ScrollController();
    _expandListController.addListener(_expandListListener);
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
    }).generate(context);
  }

  Widget getMakerWidget(FcubeType cubetype) {
    if (cubetype == FcubeType.questCube) {
      return Container(
        height: 40.00,
        width: 40.00,
        decoration: BoxDecoration(
          color: Color(0xff4f72ff),
          shape: BoxShape.circle,
        ),
        child: Icon(
          ForutonaIcon.quest,
          size: 17,
          color: Colors.white,
        ),
      );
    } else if (cubetype == FcubeType.issuecube) {
      return Container(
        height: 40.00,
        width: 40.00,
        padding: EdgeInsets.only(left: 3),
        decoration: BoxDecoration(
          color: Color(0xffdc3e57),
          shape: BoxShape.circle,
        ),
        child: Icon(
          ForutonaIcon.issue,
          size: 17,
          color: Colors.white,
        ),
      );
    } else {
      return Container();
    }
  }

  @override
  void didInitState() async {
    nowplayer = Fcubeplayer(
        uid: GlobalStateContainer.of(context).state.userInfoMain.uid);
    // selectedTimer =
    //     Timer.periodic(Duration(milliseconds: 150), makeSelectedIcon);
  }

  @override
  void dispose() {
    super.dispose();
    selectedTimer.cancel();
    if (longStayDeadtimer != null) {
      longStayDeadtimer.cancel();
    }
  }

  ongoogleMapBlocklongPress() {
    if (d001eagerGestureRecognizer.gestureaccept) {
      this.mapOpacityflag = true;
    } else {
      this.mapOpacityflag = false;
    }
    joinPlayerDisPlayController.mapopacity = this.mapOpacityflag;
    setState(() {});
  }

  Future<void> findMoreLoadByNearCube() async {
    LatLngBounds visibleGegion = await mapcontroller.getVisibleRegion();
    double distance = await geolocation.distanceBetween(
        currentposition.latitude,
        currentposition.longitude,
        visibleGegion.northeast.latitude,
        visibleGegion.northeast.longitude);
    List<FcubeExtender1> cubelist =
        GlobalStateContainer.of(context).state.fcubeplayerListUtil.cubeList;
    FCubeGeoSearchUtil searchitem = FCubeGeoSearchUtil.fromGeoSearchUtil(
        GeoSearchUtil(
            distance: distance,
            latitude: currentposition.latitude,
            longitude: currentposition.longitude,
            limit: 40,
            offset: cubelist.length),
        cubescope: 0,
        cubestate: 1,
        activationtime: DateTime.now());
    List<FcubeExtender1> fcubeplaylist =
        await FcubeExtender1.findNearDistanceCube(searchitem);
    GlobalStateContainer.of(context)
        .addfcubeplayerListUtilcubeList(fcubeplaylist);
    setState(() {});
    fcubeplaylist =
        GlobalStateContainer.of(context).state.fcubeplayerListUtil.cubeList;
    makemakerlist(fcubeplaylist);
  }

  _expandListListener() async {
    //바텀 까지 스크롤 업함.
    if (_expandListController.offset >=
            _expandListController.position.maxScrollExtent &&
        !_expandListController.position.outOfRange) {
      isLoading = true;
      setState(() {});
      await findMoreLoadByNearCube();
      isLoading = false;
      setState(() {});
    }
  }

  makemakerlist(List<FcubeExtender1> fcubeplaylist) async {
    Widget issuemaker = Container(
        height: 50,
        width: 50,
        decoration:
            BoxDecoration(shape: BoxShape.circle, color: Color(0xffDC3E57)));
    Widget questmaker = Container(
        height: 50,
        width: 50,
        decoration:
            BoxDecoration(shape: BoxShape.circle, color: Color(0xff4F72FF)));
    for (int i = 0; i < fcubeplaylist.length; i++) {
      if (fcubeplaylist[i].cubetype == FcubeType.issuecube) {
        fcubeplaylist[i].markerwidget = issuemaker;
      } else if (fcubeplaylist[i].cubetype == FcubeType.questCube) {
        fcubeplaylist[i].markerwidget = questmaker;
      }
    }

    FcubeExtenderMarkerGenerator(fcubeplaylist, (bitmaps) {
      setState(() {
        markers.clear();
        bitmaps.asMap().forEach((i, bmp) {
          final cubeitem = fcubeplaylist[i];
          markers.add(Marker(
              markerId: MarkerId(cubeitem.cubeuuid),
              onTap: () {
                onMarkertap(cubeitem);
              },
              anchor: Offset(0.5, 0.5),
              zIndex: 3,
              position: LatLng(cubeitem.latitude, cubeitem.longitude),
              icon: BitmapDescriptor.fromBytes(bmp)));
        });
      });
    }).generate(context);
  }

  onMarkertap(FcubeExtender1 item) {
    Container siwperparent = swiperkey.currentWidget;
    CarouselSlider carouselSlider = siwperparent.child as CarouselSlider;
    List<FcubeExtender1> cubelist =
        GlobalStateContainer.of(context).state.fcubeplayerListUtil.cubeList;

    int page = cubelist.indexWhere((finditem) {
      return finditem.cubeuuid == item.cubeuuid;
    });
    carouselSlider.jumpToPage(page);
  }

  onswiperindexchange(int index) async {
    currentswiperindex = index;
    List<FcubeExtender1> cubelist =
        GlobalStateContainer.of(context).state.fcubeplayerListUtil.cubeList;
    nowplayer.cubeuuid = cubelist[currentswiperindex].cubeuuid;
    changeIscurrentballplayer(currentswiperindex);
    makemakerlist(cubelist);
  }

  makeSelectedIcon(Timer timer) async {
    List<FcubeExtender1> cubelist =
        GlobalStateContainer.of(context).state.fcubeplayerListUtil.cubeList;
    if (cubelist.length > 0 &&
        markers.length > 0 &&
        cubelist.length > currentswiperindex) {
      markers.removeWhere((item) {
        return item.markerId.value == cubelist[currentswiperindex].cubeuuid;
      });

      markers.add(Marker(
          markerId: MarkerId(cubelist[currentswiperindex].cubeuuid),
          anchor: Offset(0.5, 0.5),
          zIndex: 3,
          onTap: () {
            onMarkertap(cubelist[currentswiperindex]);
          },
          position: LatLng(cubelist[currentswiperindex].latitude,
              cubelist[currentswiperindex].longitude),
          icon: BitmapDescriptor.fromBytes(
              markeritem[cubelist[currentswiperindex].cubetype])));

      RenderRepaintBoundary boundary =
          laderkey.currentContext.findRenderObject();
      var image = await boundary.toImage(pixelRatio: 1.0);
      ByteData byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List imagedata = byteData.buffer.asUint8List();

      markers.removeWhere((item) {
        return item.markerId.value == "selectlader";
      });

      markers.add(Marker(
          markerId: MarkerId("selectlader"),
          position: LatLng(cubelist[currentswiperindex].latitude,
              cubelist[currentswiperindex].longitude),
          anchor: Offset(0.5, 0.5),
          zIndex: 2,
          icon: BitmapDescriptor.fromBytes(imagedata)));
    }
  }

  onMapCreated(GoogleMapController controller) async {
    mapcontroller = controller;
    isLoading = true;
    setState(() {});
    currentposition = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    if (currentposition == null) {
      currentposition = await Geolocator()
          .getLastKnownPosition(desiredAccuracy: LocationAccuracy.high);
    }
    GlobalStateContainer.of(context).updateCurrnetPosition(currentposition);
    mapcontroller.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(currentposition.latitude, currentposition.longitude),
        zoom: 16)));
    isLoading = false;
    setState(() {});
  }

  Widget selectBallMainImage(FcubeDescription description) {
    if (description.desimages.length == 0) {
      return Container();
    } else if (description.desimages.length == 1) {
      return Container(
        height: 102,
        margin: EdgeInsets.all(13),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.00),
            image: DecorationImage(
                image: NetworkImage(description.desimages[0].src),
                fit: BoxFit.fitWidth)),
      );
    } else {
      return Container(
        height: 102,
        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: ListView.builder(
            itemCount: description.desimages.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Container(
                  margin: EdgeInsets.fromLTRB(13, 0, 0, 0),
                  height: 102,
                  width: MediaQuery.of(context).size.width * 0.7,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.00),
                      image: DecorationImage(
                          image: NetworkImage(description.desimages[index].src),
                          fit: BoxFit.fitWidth)));
            }),
      );
    }
  }

  Widget getExpanedIssueBallWidget(FcubeExtender1 item) {
    FcubeDescription description =
        FcubeDescription.fromRawJson(item.contentvalue);
    return Container(
      margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
      decoration: BoxDecoration(
        color: Color(0xffffffff).withOpacity(mainOpacity),
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
          Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 33.00,
                      width: 33.00,
                      padding: EdgeInsets.only(left: 2),
                      decoration: BoxDecoration(
                        color: Color(0xffdc3e57),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        ForutonaIcon.issue,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    Expanded(
                        child: Container(
                      padding: EdgeInsets.only(left: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(item.cubename,
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: "Noto Sans CJK KR",
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                                color: Color(0xff454f63),
                              )),
                          Text(item.placeaddress,
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: "Noto Sans CJK KR",
                                fontSize: 12,
                                color: Color(0xff454f63).withOpacity(0.56),
                              ))
                        ],
                      ),
                    ))
                  ],
                ),
                decoration: BoxDecoration(
                  color: Color(0xffdc3e57).withOpacity(0.15),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12.00),
                    topRight: Radius.circular(12.00),
                  ),
                ),
              ),
              Positioned(
                bottom: 10,
                right: 10,
                child: Container(
                    child: Text(
                        "${(item.distancewithme / 1000).toStringAsFixed(1)} km",
                        style: TextStyle(
                          fontFamily: "Noto Sans CJK KR",
                          fontSize: 10,
                          color: Color(0xffff4f9a).withOpacity(0.56),
                        ))),
              )
            ],
          ),
          Container(
              child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(13),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border:
                              Border.all(color: Color(0xffDC3E57), width: 1),
                          image: DecorationImage(
                              image: NetworkImage(item.profilepicktureurl),
                              fit: BoxFit.fill)),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(9, 0, 0, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(item.nickname,
                              style: TextStyle(
                                fontFamily: "Noto Sans CJK KR",
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: Color(0xff454f63),
                              )),
                          Text("${item.userlevel.toInt()} lev",
                              style: TextStyle(
                                fontFamily: "Gibson",
                                fontSize: 12,
                                color: Color(0xff454f63).withOpacity(0.56),
                              ))
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(child: selectBallMainImage(description)),
              Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 13),
                  padding: EdgeInsets.all(13),
                  alignment: Alignment.topLeft,
                  child: Text(description.text)),
              Container(
                  margin: EdgeInsets.only(bottom: 13),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(right: 3),
                        child: Text("${item.cubelikes}",
                            style: TextStyle(
                              fontFamily: "Gibson",
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              color: Color(0xff78849e),
                            )),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Icon(
                          ForutonaIcon.thumbsup,
                          size: 18,
                          color: Color(0xff78849E),
                        ),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 3),
                        child: Text("${item.cubedislikes}",
                            style: TextStyle(
                              fontFamily: "Gibson",
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              color: Color(0xff78849e),
                            )),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Icon(
                          ForutonaIcon.thumbsdown,
                          size: 18,
                          color: Color(0xff78849E),
                        ),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 3),
                        child: Text("${item.commentcount}",
                            style: TextStyle(
                              fontFamily: "Gibson",
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              color: Color(0xff78849e),
                            )),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Icon(
                          ForutonaIcon.comment,
                          size: 18,
                          color: Color(0xff78849E),
                        ),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 3),
                        child: Text(
                            "${item.remindActiveTimetoDuration().inMinutes}",
                            style: TextStyle(
                              fontFamily: "Gibson",
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              color: Color(0xff78849e),
                            )),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Icon(
                          ForutonaIcon.accesstime,
                          size: 18,
                          color: Color(0xff78849E),
                        ),
                      ),
                      SizedBox(
                        width: 16,
                      )
                    ],
                  ))
            ],
          ))
        ],
      ),
    );
  }

  Widget getExpanedQuestBallWidget(FcubeExtender1 item) {
    FcubeDescription description =
        FcubeDescription.fromRawJson(item.contentvalue);
    return Container(
        margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
        decoration: BoxDecoration(
            color: Color(0xffffffff).withOpacity(mainOpacity),
            boxShadow: [
              BoxShadow(
                offset: Offset(0.00, 4.00),
                color: Color(0xff455b63).withOpacity(0.08),
                blurRadius: 16,
              ),
            ],
            borderRadius: BorderRadius.circular(12.00)),
        child: Column(children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 33.00,
                      width: 33.00,
                      decoration: BoxDecoration(
                        color: Color(0xff4F72FF),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        ForutonaIcon.quest,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    Expanded(
                        child: Container(
                      padding: EdgeInsets.only(left: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(item.cubename,
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: "Noto Sans CJK KR",
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                                color: Color(0xff454f63),
                              )),
                          Text(item.placeaddress,
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: "Noto Sans CJK KR",
                                fontSize: 12,
                                color: Color(0xff454f63).withOpacity(0.56),
                              ))
                        ],
                      ),
                    ))
                  ],
                ),
                decoration: BoxDecoration(
                  color: Color(0xff4f72ff).withOpacity(0.15),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12.00),
                    topRight: Radius.circular(12.00),
                  ),
                ),
              ),
              Positioned(
                bottom: 10,
                right: 10,
                child: Container(
                    child: Text(
                        "${(item.distancewithme / 1000).toStringAsFixed(1)} km",
                        style: TextStyle(
                          fontFamily: "Noto Sans CJK KR",
                          fontSize: 10,
                          color: Color(0xffff4f9a).withOpacity(0.56),
                        ))),
              )
            ],
          ),
          Container(
              child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(13),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border:
                              Border.all(color: Color(0xffDC3E57), width: 1),
                          image: DecorationImage(
                              image: NetworkImage(item.profilepicktureurl),
                              fit: BoxFit.fill)),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(9, 0, 0, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(item.nickname,
                              style: TextStyle(
                                fontFamily: "Noto Sans CJK KR",
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: Color(0xff454f63),
                              )),
                          Text("${item.userlevel.toInt()} lev",
                              style: TextStyle(
                                fontFamily: "Gibson",
                                fontSize: 12,
                                color: Color(0xff454f63).withOpacity(0.56),
                              ))
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(child: selectBallMainImage(description)),
              Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 13),
                  padding: EdgeInsets.all(13),
                  alignment: Alignment.topLeft,
                  child: Text(description.text)),
              Container(
                color: Colors.white,
                padding: EdgeInsets.only(top: 16, bottom: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(right: 3),
                      child: Text("${item.pointreward.toInt()}",
                          style: TextStyle(
                            fontFamily: "Gibson",
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            color: Color(0xff78849e),
                          )),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Icon(
                        ForutonaIcon.napoint,
                        size: 18,
                        color: Color(0xff78849E),
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 3),
                      child: Text("${item.userexp.toInt()}",
                          style: TextStyle(
                            fontFamily: "Gibson",
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            color: Color(0xff78849e),
                          )),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Icon(
                        ForutonaIcon.whatshot,
                        size: 18,
                        color: Color(0xff78849E),
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 3),
                      child:
                          Text("${item.remindActiveTimetoDuration().inMinutes}",
                              style: TextStyle(
                                fontFamily: "Gibson",
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                                color: Color(0xff78849e),
                              )),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Icon(
                        ForutonaIcon.accesstime,
                        size: 18,
                        color: Color(0xff78849E),
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                  ],
                ),
              )
            ],
          ))
        ]));
  }

  Widget getExpanedPlayListView() {
    List<FcubeExtender1> cubelist =
        GlobalStateContainer.of(context).state.fcubeplayerListUtil.cubeList;
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFE4E7E8).withOpacity(mainOpacity),
      ),
      margin: sheetControllere.state.progress < 0.8 &&
              sheetControllere.state.progress > 0.6
          ? EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.23)
          : EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.03),
      child: ListView.builder(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          controller: _expandListController,
          itemCount: cubelist.length,
          itemBuilder: (BuildContext context, int index) {
            if (cubelist[index].cubetype == FcubeType.questCube) {
              return getExpanedQuestBallWidget(cubelist[index]);
            } else if (cubelist[index].cubetype == FcubeType.issuecube) {
              return getExpanedIssueBallWidget(cubelist[index]);
            } else {
              return Container();
            }
          }),
    );
  }

  Widget getCollsePlaySwiper() {
    List<FcubeExtender1> cubelist =
        GlobalStateContainer.of(context).state.fcubeplayerListUtil.cubeList;
    if (cubelist.length == 0) {
      return Container(
          decoration: BoxDecoration(
        color: Color(0xFFE4E7E8).withOpacity(mainOpacity),
      ));
    }

    return Container(
      key: swiperkey,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Color(0xFFE4E7E8).withOpacity(mainOpacity),
      ),
      margin:
          EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.73),
      child: CarouselSlider.builder(
          viewportFraction: 0.8,
          initialPage: currentswiperindex,
          itemCount: cubelist.length,
          onPageChanged: onswiperindexchange,
          itemBuilder: (BuildContext context, int index) {
            if (cubelist[index].cubetype == FcubeType.issuecube) {
              return getCollseIssueBall(cubelist[index]);
            } else if (cubelist[index].cubetype == FcubeType.questCube) {
              return getCollseQuestBall(cubelist[index]);
            } else {
              return Container();
            }
          }),
    );
  }

  Widget getCollseIssueBall(FcubeExtender1 item) {
    return Container(
      margin: EdgeInsets.fromLTRB(8, 0, 8, 0),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: mapOpacityflag
            ? Color(0xffffffff).withOpacity(0.15)
            : Color(0xffffffff),
        border: Border.all(
          width: 2.00,
          color: mapOpacityflag
              ? Color(0xff78849e).withOpacity(0.15)
              : Color(0xff78849e),
        ),
        borderRadius: BorderRadius.circular(12.00),
      ),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(9),
            decoration: BoxDecoration(
              color: Color(0xffdc3e57).withOpacity(0.15),
              border: Border.all(
                width: 1.00,
                color: Color(0xffff4f9a).withOpacity(0.15),
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.00),
                topRight: Radius.circular(12.00),
              ),
            ),
            child: Row(
              children: <Widget>[
                Container(
                  height: 35.00,
                  width: 35.00,
                  decoration: BoxDecoration(
                    color: mapOpacityflag
                        ? Color(0xffdc3e57).withOpacity(0.15)
                        : Color(0xffdc3e57),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    ForutonaIcon.issue,
                    size: 17,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 11,
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(item.cubename,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: "Noto Sans CJK KR",
                          fontWeight: FontWeight.w700,
                          fontSize: 13,
                          color: Color(0xff454f63),
                        )),
                    RichText(
                      text: TextSpan(
                          text: item.nickname,
                          style: TextStyle(
                            fontFamily: "Noto Sans CJK KR",
                            fontWeight: FontWeight.w700,
                            fontSize: 10,
                            color: Color(0xff78849e),
                          ),
                          children: [
                            TextSpan(
                                text: "    ${item.userlevel.toInt()} lv",
                                style: TextStyle(
                                  fontFamily: "Noto Sans CJK KR",
                                  fontWeight: FontWeight.w700,
                                  fontSize: 9,
                                  color: Color(0xff454f63).withOpacity(0.56),
                                ))
                          ]),
                    )
                  ],
                ))
              ],
            ),
          ),
          Container(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(right: 3),
                    child: Text("${item.cubelikes}",
                        style: TextStyle(
                          fontFamily: "Gibson",
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: Color(0xff78849e),
                        )),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Icon(
                      ForutonaIcon.thumbsup,
                      size: 18,
                      color: Color(0xff78849E),
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 3),
                    child: Text("${item.cubedislikes}",
                        style: TextStyle(
                          fontFamily: "Gibson",
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: Color(0xff78849e),
                        )),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Icon(
                      ForutonaIcon.thumbsdown,
                      size: 18,
                      color: Color(0xff78849E),
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 3),
                    child: Text("${item.commentcount}",
                        style: TextStyle(
                          fontFamily: "Gibson",
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: Color(0xff78849e),
                        )),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Icon(
                      ForutonaIcon.comment,
                      size: 18,
                      color: Color(0xff78849E),
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 3),
                    child:
                        Text("${item.remindActiveTimetoDuration().inMinutes}",
                            style: TextStyle(
                              fontFamily: "Gibson",
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              color: Color(0xff78849e),
                            )),
                  ),
                  Container(
                    child: Icon(
                      ForutonaIcon.accesstime,
                      size: 18,
                      color: Color(0xff78849E),
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  )
                ],
              ))
        ],
      ),
    );
  }

  Widget getCollseQuestBall(FcubeExtender1 item) {
    return Container(
      margin: EdgeInsets.fromLTRB(8, 0, 8, 0),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: mapOpacityflag
            ? Color(0xffffffff).withOpacity(0.15)
            : Color(0xffffffff),
        border: Border.all(
          width: 2.00,
          color: mapOpacityflag
              ? Color(0xff78849e).withOpacity(0.15)
              : Color(0xff78849e),
        ),
        borderRadius: BorderRadius.circular(12.00),
      ),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(9),
            decoration: BoxDecoration(
              color: Color(0xff4f72ff).withOpacity(0.15),
              border: Border.all(
                width: 1.00,
                color: Color(0xffff4f9a).withOpacity(0.15),
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.00),
                topRight: Radius.circular(12.00),
              ),
            ),
            child: Row(
              children: <Widget>[
                Container(
                  height: 35.00,
                  width: 35.00,
                  decoration: BoxDecoration(
                    color: mapOpacityflag
                        ? Color(0xff4f72ff).withOpacity(0.5)
                        : Color(0xff4f72ff),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    ForutonaIcon.quest,
                    size: 17,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 11,
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(item.cubename,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: "Noto Sans CJK KR",
                          fontWeight: FontWeight.w700,
                          fontSize: 13,
                          color: Color(0xff454f63),
                        )),
                    RichText(
                      text: TextSpan(
                          text: item.nickname,
                          style: TextStyle(
                            fontFamily: "Noto Sans CJK KR",
                            fontWeight: FontWeight.w700,
                            fontSize: 10,
                            color: Color(0xff78849e),
                          ),
                          children: [
                            TextSpan(
                                text: "    ${item.userlevel.toInt()} lv",
                                style: TextStyle(
                                  fontFamily: "Noto Sans CJK KR",
                                  fontWeight: FontWeight.w700,
                                  fontSize: 9,
                                  color: Color(0xff454f63).withOpacity(0.56),
                                ))
                          ]),
                    )
                  ],
                ))
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: 3),
                  child: Text("${item.pointreward.toInt()}",
                      style: TextStyle(
                        fontFamily: "Gibson",
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        color: Color(0xff78849e),
                      )),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Icon(
                    ForutonaIcon.napoint,
                    size: 18,
                    color: Color(0xff78849E),
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                Container(
                  margin: EdgeInsets.only(right: 3),
                  child: Text("${item.userexp.toInt()}",
                      style: TextStyle(
                        fontFamily: "Gibson",
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        color: Color(0xff78849e),
                      )),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Icon(
                    ForutonaIcon.whatshot,
                    size: 18,
                    color: Color(0xff78849E),
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                Container(
                  margin: EdgeInsets.only(right: 3),
                  child: Text("${item.remindActiveTimetoDuration().inMinutes}",
                      style: TextStyle(
                        fontFamily: "Gibson",
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        color: Color(0xff78849e),
                      )),
                ),
                Container(
                  child: Icon(
                    ForutonaIcon.accesstime,
                    size: 18,
                    color: Color(0xff78849E),
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget getSlidingListView() {
    if (sheetControllere.state == null) {
      return getCollsePlaySwiper();
    }
    if (sheetControllere.state.progress > 0.6) {
      if (currentsnapprogess < 0.6) {
        mainOpacity = 1;
      }
      currentsnapprogess = sheetControllere.state.progress;
      return getExpanedPlayListView();
    } else {
      if (currentsnapprogess > 0.6) {
        mainOpacity = 0.7;
      }
      currentsnapprogess = sheetControllere.state.progress;
      return getCollsePlaySwiper();
    }
  }

  onCameraMove(CameraPosition position) {
    currentposition = Position(
        latitude: position.target.latitude,
        longitude: position.target.longitude);
    currentCameraposition = position;
  }

  onCameraIdle() async {
    if (movecameraidlecount != 0) {
      idleCameracCrrentposition = currentCameraposition;
      longStayDeadtimer =
          Timer(Duration(milliseconds: 1500), onLongStayCameraIdle);
    }
    movecameraidlecount++;
  }

  Future<void> resetfindLoadByNearCube() async {
    LatLngBounds visibleGegion = await mapcontroller.getVisibleRegion();
    double distance = await geolocation.distanceBetween(
        currentposition.latitude,
        currentposition.longitude,
        visibleGegion.northeast.latitude,
        visibleGegion.northeast.longitude);
    FCubeGeoSearchUtil searchitem = FCubeGeoSearchUtil.fromGeoSearchUtil(
        GeoSearchUtil(
            distance: distance,
            latitude: currentposition.latitude,
            longitude: currentposition.longitude,
            limit: 40,
            offset: 0),
        cubescope: 0,
        cubestate: 1,
        activationtime: DateTime.now());

    List<FcubeExtender1> oldcubelist =
        GlobalStateContainer.of(context).state.fcubeplayerListUtil.cubeList;
    FcubeExtender1 oldseelctfcube;
    if (oldcubelist.length > currentswiperindex) {
      oldseelctfcube = oldcubelist[currentswiperindex];
    }

    List<FcubeExtender1> fcubeplaylist =
        await FcubeExtender1.findNearDistanceCube(searchitem);

    GlobalStateContainer.of(context)
        .addfcubeplayerListUtilcubeListwithReset(fcubeplaylist);
    setState(() {});
    if (oldseelctfcube != null) {
      int newindexpos = GlobalStateContainer.of(context)
          .state
          .fcubeplayerListUtil
          .cubeList
          .indexWhere((testitem) {
        return oldseelctfcube.cubeuuid == testitem.cubeuuid;
      });
      Container siwperparent = swiperkey.currentWidget;
      CarouselSlider carouselSlider = siwperparent.child as CarouselSlider;
      if (newindexpos >= 0) {
        carouselSlider.jumpToPage(newindexpos);
      } else {
        currentswiperindex = 0;
      }
      changeIscurrentballplayer(currentswiperindex);
    }

    makemakerlist(fcubeplaylist);
  }

  changeIscurrentballplayer(index) async {
    List<FcubeExtender1> cubelist =
        GlobalStateContainer.of(context).state.fcubeplayerListUtil.cubeList;
    if (cubelist.length > 0) {
      nowplayer.cubeuuid = cubelist[currentswiperindex].cubeuuid;
      List<FcubeplayerExtender1> isplaylist =
          await FcubeplayerExtender1.selectPlayers(nowplayer);
      if (isplaylist.length > 0) {
        iscurrentballplayer = true;
        setState(() {});
      } else {
        iscurrentballplayer = false;
        setState(() {});
      }
    } else {
      iscurrentballplayer = false;
      setState(() {});
    }
    if (iscurrentballplayer) {
      joinPlayerDisPlayController.open();
    } else {
      joinPlayerDisPlayController.close();
    }
  }

  onLongStayCameraIdle() async {
    if (currentCameraposition.target.latitude ==
            idleCameracCrrentposition.target.latitude &&
        currentCameraposition.target.longitude ==
            idleCameracCrrentposition.target.longitude &&
        currentCameraposition.zoom == idleCameracCrrentposition.zoom) {
      isLoading = true;
      setState(() {});
      await resetfindLoadByNearCube();
      isLoading = false;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final GoogleMap googleMap = GoogleMap(
      gestureRecognizers: gestureRecognizers,
      initialCameraPosition: _kInitialPosition,
      onMapCreated: onMapCreated,
      onCameraMove: onCameraMove,
      onCameraIdle: onCameraIdle,
      myLocationEnabled: true,
      myLocationButtonEnabled: false,
      markers: markers,
      circles: circles,
    );

    return LoadingOverlay(
        isLoading: isLoading,
        progressIndicator: Loading(
            indicator: BallScaleIndicator(),
            size: 100.0,
            color: Theme.of(context).accentColor),
        child: Scaffold(
            body: Container(
                child: Stack(
          children: <Widget>[
            Positioned(
              bottom: 0,
              right: 0,
              child: RepaintBoundary(
                  key: laderkey,
                  child: Container(
                      height: 300,
                      width: 300,
                      child: FlareActor(
                        "assets/Rive/radar.flr",
                        alignment: Alignment.center,
                        animation: "animating",
                        fit: BoxFit.contain,
                      ))),
            ),
            googleMap,
            Positioned(
                top: 30,
                child: Container(
                    padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                    width: MediaQuery.of(context).size.width,
                    child: SearchMapPlaceWidget(
                        backgroundcolor: mapOpacityflag
                            ? Colors.white.withOpacity(0.4)
                            : Colors.white,
                        apiKey: Preference.kGoogleApiKey,
                        location: _kInitialPosition.target,
                        language: "ko",
                        radius: 30000,
                        onSelected: (place) async {
                          final geolocation = await place.geolocation;
                          mapcontroller.animateCamera(
                              CameraUpdate.newLatLng(geolocation.coordinates));
                          mapcontroller.animateCamera(
                              CameraUpdate.newLatLngBounds(
                                  geolocation.bounds, 0));
                        }))),
            Positioned(
                top: 100,
                right: 30,
                child: Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: mapOpacityflag
                          ? Color(0xffffffff).withOpacity(0.3)
                          : Color(0xffffffff),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0.00, 12.00),
                          color: Color(0xff455b63).withOpacity(0.10),
                          blurRadius: 16,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(12.00),
                    ),
                    child: FlatButton(
                      child: Icon(
                        Icons.my_location,
                      ),
                      onPressed: () async {
                        isLoading = true;
                        setState(() {});
                        currentposition = await Geolocator().getCurrentPosition(
                            desiredAccuracy: LocationAccuracy.high);
                        if (currentposition == null) {
                          currentposition = await Geolocator()
                              .getLastKnownPosition(
                                  desiredAccuracy: LocationAccuracy.high);
                        }
                        GlobalStateContainer.of(context)
                            .updateCurrnetPosition(currentposition);
                        mapcontroller.animateCamera(
                            CameraUpdate.newCameraPosition(CameraPosition(
                                target: LatLng(currentposition.latitude,
                                    currentposition.longitude),
                                zoom: 16)));
                        isLoading = false;
                        setState(() {});
                      },
                    ))),
            Positioned(
              top: 100,
              left: 20,
              child: D001JoinPlayerDisPlay(
                controller: joinPlayerDisPlayController,
              ),
            ),
            SlidingSheet(
              scrollSpec: ScrollSpec(overscroll: false),
              color: Color(0x00FFFFFF),
              elevation: 0,
              cornerRadius: 10,
              listener: (value) {
                print(value);
                setState(() {});
              },
              controller: sheetControllere,
              snapSpec: SnapSpec(
                // Enable snapping. This is true by default.
                snap: true,
                // Set custom snapping points.
                snappings: [0.25, 0.8, 1.0],
                // Define to what the snappings relate to. In this case,
                // the total available space that the sheet can expand to.
                positioning: SnapPositioning.relativeToSheetHeight,
              ),
              headerBuilder: (context, state) {
                return Container(
                    padding: EdgeInsets.all(0),
                    width: MediaQuery.of(context).size.width,
                    height: 35,
                    alignment: Alignment.center,
                    child: Container(
                      margin: EdgeInsets.fromLTRB(0, 16, 0, 16),
                      height: 3.00,
                      width: 134.00,
                      decoration: BoxDecoration(
                        color: Color(0xff78849e),
                        borderRadius: BorderRadius.circular(1.00),
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xFFE4E7E8).withOpacity(mainOpacity),
                    ));
              },
              builder: (context, state) {
                // This is the content of the sheet that will get
                // scrolled, if the content is bigger than the available
                // height of the sheet.
                return Container(
                    height: MediaQuery.of(context).size.height * 0.89,
                    child: getSlidingListView());
              },
            ),
          ],
        ))));
  }

  @override
  bool get wantKeepAlive => true;
}
