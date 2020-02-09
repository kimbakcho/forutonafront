import 'dart:async';
import 'dart:typed_data';

import 'package:after_init/after_init.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:forutonafront/Common/FCubeGeoSearchUtil.dart';
import 'package:forutonafront/Common/FcubeDescription.dart';
import 'package:forutonafront/Common/FcubeExtenderMarkerGenerator.dart';
import 'package:forutonafront/Common/GeoSearchUtil.dart';
import 'package:forutonafront/Common/LoadingOverlay%20.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:forutonafront/MakePage/Component/FcubeExtender1.dart';
import 'package:forutonafront/MakePage/FcubeTypes.dart';
import 'package:forutonafront/PlayPage/D001EagerGestureRecognizer.dart';
import 'package:forutonafront/Preference.dart';
import 'package:forutonafront/globals.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loading/indicator/ball_scale_indicator.dart';
import 'package:loading/loading.dart';
import 'package:search_map_place/search_map_place.dart';
import 'package:sliding_sheet/sliding_sheet.dart';
import 'dart:ui' as ui;

class D001PlayPageView extends StatefulWidget {
  D001PlayPageView({Key key}) : super(key: key);

  @override
  _D001PlayPageViewState createState() => _D001PlayPageViewState();
}

class _D001PlayPageViewState extends State<D001PlayPageView>
    with
        AfterInitMixin,
        AutomaticKeepAliveClientMixin,
        SingleTickerProviderStateMixin {
  CameraPosition _kInitialPosition = CameraPosition(
    target: LatLng(37.550944, 126.990819),
    zoom: 16.0,
  );
  Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers;
  D001EagerGestureRecognizer d001eagerGestureRecognizer;
  double mainOpacity = 1;
  Color backgroundColor = Color(0x00000000);
  double mainslidermaxheight = 500;
  double mainsliderminheight = 100;
  GoogleMapController mapcontroller;
  Widget slidingUpPanel;
  //카메라 현재 위치
  Position currentposition =
      Position(latitude: 37.550944, longitude: 126.990819);
  Geolocator geolocation = Geolocator();
  double currentsnapprocess = 0.2;
  bool isLoading = false;
  SheetController sheetControllere = new SheetController();
  Set<Marker> markers = new Set<Marker>();
  Set<Circle> circles;
  Tween<double> ladertween = Tween<double>(begin: 70, end: 140);
  Animation<double> laderanimation;
  AnimationController laderanimationcontroller;
  final GlobalKey laderkey = GlobalKey();
  Timer selectedTimer;
  @override
  void initState() {
    super.initState();

    d001eagerGestureRecognizer = new D001EagerGestureRecognizer(
        duration: Duration(seconds: 1), onLongPress: ongoogleMapBlocklongPress);
    gestureRecognizers = Set()
      ..add(Factory<D001EagerGestureRecognizer>(
          () => d001eagerGestureRecognizer));
    laderanimationcontroller =
        AnimationController(duration: Duration(seconds: 2), vsync: this);
    laderanimation =
        CurvedAnimation(parent: laderanimationcontroller, curve: Curves.easeIn)
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              laderanimationcontroller.reverse();
            } else if (status == AnimationStatus.dismissed) {
              laderanimationcontroller.forward();
            }
          });
    laderanimationcontroller.forward();
  }

  @override
  void didInitState() async {
    // Position currentposition =
    //     GlobalStateContainer.of(context).state.currentposition;
    // _kInitialPosition = CameraPosition(
    //     target: LatLng(currentposition.latitude, currentposition.longitude),
    //     zoom: 16);

    selectedTimer =
        Timer.periodic(Duration(milliseconds: 150), makeSelectedIcon);
  }

  @override
  void dispose() {
    super.dispose();
    selectedTimer.cancel();
  }

  ongoogleMapBlocklongPress() {
    if (d001eagerGestureRecognizer.gestureaccept) {
      this.mainOpacity = 0.3;
    } else {
      this.mainOpacity = 1;
    }
    setState(() {});
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
    List<FcubeExtender1> fcubeplaylist =
        await FcubeExtender1.findNearDistanceCube(searchitem);
    GlobalStateContainer.of(context)
        .addfcubeplayerListUtilcubeListwithReset(fcubeplaylist);
    makemakerlist(fcubeplaylist);
    print(fcubeplaylist.length);
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
              anchor: Offset(0.5, 0.5),
              zIndex: 3,
              position: LatLng(cubeitem.latitude, cubeitem.longitude),
              icon: BitmapDescriptor.fromBytes(bmp)));
        });
      });
    }).generate(context);
  }

  makeSelectedIcon(Timer timer) async {
    RenderRepaintBoundary boundary = laderkey.currentContext.findRenderObject();
    var image = await boundary.toImage(pixelRatio: 1.0);
    ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List imagedata = byteData.buffer.asUint8List();
    if (markers.length > 0) {
      markers.removeWhere((item) {
        return item.markerId.value == "selectlader";
      });
      markers.add(Marker(
          markerId: MarkerId("selectlader"),
          position: markers.first.position,
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

    await resetfindLoadByNearCube();
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
      margin: sheetControllere.state.progress < 0.8 &&
              sheetControllere.state.progress > 0.6
          ? EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.23)
          : EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.03),
      child: ListView.builder(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
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

  Widget getSlidingListView() {
    if (sheetControllere.state == null) {
      return Container();
    }
    if (sheetControllere.state.progress > 0.6) {
      return getExpanedPlayListView();
    } else {
      return Container();
    }
  }

  onCameraMove(CameraPosition position) {
    currentposition = Position(
        latitude: position.target.latitude,
        longitude: position.target.longitude);
  }

  onCameraIdle() async {
    isLoading = true;
    setState(() {});
    await resetfindLoadByNearCube();
    isLoading = false;
    setState(() {});
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
              top: 0,
              left: 0,
              child: RepaintBoundary(
                key: laderkey,
                child: Container(
                  height: ladertween.evaluate(laderanimation),
                  width: ladertween.evaluate(laderanimation),
                  decoration: BoxDecoration(
                      color: Color(0xff39F999).withOpacity(0.5),
                      shape: BoxShape.circle),
                ),
              ),
            ),
            googleMap,
            Positioned(
              top: 30,
              child: Container(
                padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                width: MediaQuery.of(context).size.width,
                child: SearchMapPlaceWidget(
                  backgroundcolor: Colors.white.withOpacity(mainOpacity),
                  apiKey: Preference.kGoogleApiKey,
                  location: _kInitialPosition.target,
                  language: "ko",
                  radius: 30000,
                  onSelected: (place) async {
                    final geolocation = await place.geolocation;
                    mapcontroller.animateCamera(
                        CameraUpdate.newLatLng(geolocation.coordinates));
                    mapcontroller.animateCamera(
                        CameraUpdate.newLatLngBounds(geolocation.bounds, 0));
                  },
                ),
              ),
            ),
            SlidingSheet(
              scrollSpec: ScrollSpec(overscroll: false),
              color: Color(0x00FFFFFF),
              elevation: 4,
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
                snappings: [0.2, 0.8, 1.0],
                // Define to what the snappings relate to. In this case,
                // the total available space that the sheet can expand to.
                positioning: SnapPositioning.relativeToSheetHeight,
              ),
              builder: (context, state) {
                // This is the content of the sheet that will get
                // scrolled, if the content is bigger than the available
                // height of the sheet.
                return Container(
                    height: MediaQuery.of(context).size.height * 0.89,
                    child: Column(
                      children: <Widget>[
                        Container(
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
                            )),
                        Expanded(
                          child: Container(
                              height: MediaQuery.of(context).size.height,
                              decoration: BoxDecoration(
                                color:
                                    Color(0xffe4e7e8).withOpacity(mainOpacity),
                              ),
                              child: getSlidingListView()),
                        )
                      ],
                    ));
              },
            ),
          ],
        ))));
  }

  @override
  bool get wantKeepAlive => true;
}
