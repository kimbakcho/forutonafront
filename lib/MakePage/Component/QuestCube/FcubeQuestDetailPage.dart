import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/MakePage/Component/CubeMakeRichTextEdit.dart';
import 'package:forutonafront/MakePage/Component/Fcube.dart';
import 'package:forutonafront/MakePage/Component/FcubeExtender1.dart';
import 'package:forutonafront/MakePage/Component/QuestCube/FcubeQuest.dart';
import 'package:forutonafront/MakePage/FcubeTypes.dart';
import 'package:forutonafront/MakePage/Fcubecontent.dart';
import 'package:forutonafront/globals.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:intl/intl.dart';
import 'package:zefyr/zefyr.dart';

class FcubeQuestDetailPage extends StatefulWidget {
  final FcubeExtender1 fcubeextender1;
  FcubeQuestDetailPage({Key key, this.fcubeextender1}) : super(key: key);

  @override
  _FcubeQuestDetailPageState createState() {
    return _FcubeQuestDetailPageState(fcubeextender1: fcubeextender1);
  }
}

class _FcubeQuestDetailPageState extends State<FcubeQuestDetailPage>
    with SingleTickerProviderStateMixin {
  FcubeExtender1 fcubeextender1;
  _FcubeQuestDetailPageState({this.fcubeextender1});
  double currentdistancediff = 0;
  bool isloading = false;
  FcubeQuest fcubequest;
  Map<FcubecontentType, Fcubecontent> contents;
  var geolocator = Geolocator();
  var locationOptions =
      LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);
  Position currentposition;
  GoogleMapController _mapController;
  CameraPosition initialCameraPosition;
  ScrollController listviewcontroller = ScrollController();
  Set<Marker> makres = new Set<Marker>();
  bool isscrolling = false;
  TabController tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    fcubequest = FcubeQuest.fromFcubeExtender1(fcubeextender1);
    fcubequest.cubeimage = "assets/MarkesImages/QuestCube.png";
    listviewcontroller.addListener(() async {
      heidBottomNavi();
    });
    init();
  }

  heidBottomNavi() async {
    if (!this.isscrolling) {
      this.isscrolling = true;
      setState(() {});
      await Future.delayed(Duration(seconds: 1));
      this.isscrolling = false;
      setState(() {});
    }
  }

  init() async {
    initialCameraPosition = new CameraPosition(
        target: LatLng(fcubequest.latitude, fcubequest.longitude), zoom: 16);
    isloading = true;
    setState(() {});
    this.contents = await initFcubeQuest();
    initgeolocation();

    isloading = false;
    setState(() {});
  }

  Future<Map<FcubecontentType, Fcubecontent>> initFcubeQuest() async {
    Map<FcubecontentType, Fcubecontent> contents;
    await Future.delayed(Duration.zero, () async {
      String uid = GolobalStateContainer.of(context).state.userInfoMain.uid;
      List<FcubecontentType> types = List<FcubecontentType>();
      types.add(FcubecontentType.startCubeLocation);
      types.add(FcubecontentType.finishCubeLocation);
      types.add(FcubecontentType.description);
      types.add(FcubecontentType.messagecubeLocations);
      types.add(FcubecontentType.checkincubeLocations);
      types.add(FcubecontentType.authmethod);
      types.add(FcubecontentType.authPicturedescription);
      contents = await Fcubecontent.getFcubecontent(FcubeContentSelector(
          cubeuuid: fcubequest.cubeuuid, uid: uid, contenttypes: types));
    });
    return contents;
  }

  initgeolocation() async {
    PermissionStatus permissition = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.location);
    if (permissition == PermissionStatus.granted) {
      currentposition = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

      currentdistancediff = await Geolocator().distanceBetween(
          currentposition.latitude,
          currentposition.longitude,
          fcubequest.latitude,
          fcubequest.longitude);
      currentdistancediff = currentdistancediff.roundToDouble();
      setState(() {});
      geolocator
          .getPositionStream(locationOptions)
          .listen((Position position) async {
        if (position == null) {
          currentposition = await Geolocator()
              .getLastKnownPosition(desiredAccuracy: LocationAccuracy.high);
          currentposition = position;
        } else {
          currentposition = position;
        }
        currentdistancediff = await Geolocator().distanceBetween(
            currentposition.latitude,
            currentposition.longitude,
            fcubequest.latitude,
            fcubequest.longitude);
        currentdistancediff = currentdistancediff.roundToDouble();
      });
    }
  }

  Widget bottomNavi(FcubeState state) {
    switch (state) {
      case FcubeState.startWait:
        return Container(
          color: Color.fromARGB(125, 10, 10, 10),
          child: Container(
              height: 70,
              alignment: Alignment(1, 0),
              width: MediaQuery.of(context).size.width,
              child: Container(
                margin: EdgeInsets.only(right: 10),
                width: 100,
                height: 50,
                child: RaisedButton(
                  onPressed: () {},
                  child: Text("시작 준비"),
                ),
              )),
        );

        break;
      default:
        return null;
    }
  }

  Widget makedetailcontent() {
    return Container(
        child: Column(
      children: <Widget>[
        ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(fcubequest.profilepicktureurl),
          ),
          title: Text(fcubequest.cubename),
          subtitle: Text(DateFormat("yyyy-MM-dd HH:mm:ss").format(
              DateTime.parse(fcubequest.maketime).add(Duration(hours: 9)))),
        ),
        Divider(
          color: Colors.black,
        ),
        Container(
          height: getdescriptionheight() + 40,
          child: CubeMakeRichTextEdit(
            custommode: "nomal",
            jsondata: jsonDecode(this
                .contents[FcubecontentType.description]
                .contentvalue)["description"],
            zefyrMode: ZefyrMode.view,
          ),
        ),
        Divider(
          color: Colors.black,
        ),
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Text("완료 조건"),
              ),
              Row(
                children: <Widget>[
                  Image(
                    image: AssetImage(fcubequest.cubeimage),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(jsonDecode(this
                            .contents[FcubecontentType.authmethod]
                            .contentvalue)["authmethod"]),
                        Text(jsonDecode(this
                            .contents[FcubecontentType.authmethod]
                            .contentvalue)["authmethod"])
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
        Divider(
          color: Colors.black,
        ),
        Container(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Text("보상 조건"),
            ),
            Row(
              children: <Widget>[
                Image(
                  height: 50,
                  image: AssetImage(fcubequest.cubeimage),
                ),
                Expanded(
                  child: Container(
                    child: Text("${fcubequest.influencereward}"),
                  ),
                )
              ],
            ),
            Row(
              children: <Widget>[
                Image(
                  height: 50,
                  image: AssetImage(fcubequest.cubeimage),
                ),
                Expanded(
                  child: Container(
                    child: Text("${fcubequest.pointreward}"),
                  ),
                )
              ],
            ),
            Divider(
              color: Colors.black,
            ),
          ],
        ))
      ],
    ));
  }

  void onMapCreated(GoogleMapController controller) async {
    setState(() {
      _mapController = controller;
    });
    setmakers();
  }

  double getdescriptionheight() {
    String tempdescription =
        jsonDecode(this.contents[FcubecontentType.description].contentvalue)[
            "description"];
    List<dynamic> description = jsonDecode(tempdescription);
    if (description.length > 0) {
      return (description.length.toDouble() * 40);
    } else {
      return 150;
    }
  }

  double getsiktycontentheight() {
    if (tabController.index == 0) {
      return getdescriptionheight() + 150 + 200 + 200;
    } else {
      return 300;
    }
  }

  void setmakers() async {
    BitmapDescriptor icon =
        await Fcube.getMarkerImage(fcubequest.cubeimage, 150);

    setState(() {
      makres.add(Marker(
          markerId: MarkerId("MainCube"),
          icon: icon,
          position: LatLng(fcubequest.latitude, fcubequest.longitude)));
    });
  }

  @override
  Widget build(BuildContext context) {
    final GoogleMap googleMap = GoogleMap(
      gestureRecognizers: Set()
        ..add(Factory<PanGestureRecognizer>(() => PanGestureRecognizer()))
        ..add(Factory<ScaleGestureRecognizer>(() => ScaleGestureRecognizer()))
        ..add(Factory<TapGestureRecognizer>(() => TapGestureRecognizer()))
        ..add(Factory<VerticalDragGestureRecognizer>(
            () => VerticalDragGestureRecognizer())),
      initialCameraPosition: initialCameraPosition,
      onMapCreated: onMapCreated,
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
      markers: makres,
    );
    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            Container(
              child: IconButton(
                icon: Icon(Icons.share),
                onPressed: () {},
              ),
            ),
            Container(
              child: IconButton(
                icon: Icon(Icons.settings),
                onPressed: () {},
              ),
            ),
          ],
        ),
        body: isloading
            ? Center(child: CircularProgressIndicator())
            : Stack(children: <Widget>[
                ListView(
                  controller: listviewcontroller,
                  children: <Widget>[
                    StickyHeader(
                      header: Container(
                        height: MediaQuery.of(context).size.height * 0.1,
                        child: ListTile(
                          contentPadding: EdgeInsets.all(0),
                          leading: Image(
                            image: AssetImage(fcubequest.cubeimage),
                          ),
                          title: Text(fcubequest.cubename),
                          subtitle: Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(fcubequest.placeaddress),
                              ),
                              Container(
                                width: 50,
                              ),
                              Text("${currentdistancediff} m")
                            ],
                          ),
                        ),
                      ),
                      content: Container(
                          height: MediaQuery.of(context).size.height * 0.35,
                          child: googleMap),
                    ),
                    StickyHeader(
                        header: Container(
                          color: Colors.grey,
                          height: 50,
                          child: TabBar(
                            controller: tabController,
                            indicatorColor: Colors.black,
                            tabs: <Widget>[
                              Tab(text: '상세정보'),
                              Tab(text: '박스'),
                              Tab(text: '참가자'),
                            ],
                          ),
                        ),
                        content: Container(
                            height: getsiktycontentheight(),
                            child: TabBarView(
                              controller: tabController,
                              children: <Widget>[
                                makedetailcontent(),
                                Container(
                                  child: Text("456"),
                                ),
                                Container(
                                  child: Text("789"),
                                ),
                              ],
                            )

                            // TabBarView(
                            //   controller: tabController,
                            //   children: <Widget>[
                            //     Text("11"),
                            //     Text("22"),
                            //     Text("44"),
                            //   ],
                            // ),
                            )),
                  ],
                ),
                Positioned(
                  bottom: 0,
                  child: isscrolling
                      ? Container()
                      : bottomNavi(fcubequest.cubestate),
                )
              ]));
  }
}
