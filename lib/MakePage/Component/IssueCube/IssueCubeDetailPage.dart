import 'dart:async';
import 'dart:convert';

import 'package:after_init/after_init.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/MakePage/Component/CubeMakeRichTextEdit.dart';
import 'package:forutonafront/MakePage/Component/Fcube.dart';
import 'package:forutonafront/MakePage/Component/FcubeExtender1.dart';
import 'package:forutonafront/MakePage/Component/IssueCube/IssueCubeResultView.dart';
import 'package:forutonafront/MakePage/Component/QuestCube/FcubeQuestDetailPage.dart';
import 'package:forutonafront/MakePage/Fcubecontent.dart';
import 'package:forutonafront/globals.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';
import 'package:zefyr/zefyr.dart';
import 'package:intl/intl.dart';

class IssueCubeDetailPage extends StatefulWidget {
  final FcubeExtender1 fcubeextender1;
  IssueCubeDetailPage({Key key, this.fcubeextender1}) : super(key: key);

  @override
  _IssueCubeDetailPageState createState() {
    return _IssueCubeDetailPageState(fcubeextender1: fcubeextender1);
  }
}

enum IssueCurrentPanel { close, setting, share }

class _IssueCubeDetailPageState extends State<IssueCubeDetailPage>
    with AfterInitMixin {
  FcubeExtender1 fcubeextender1;
  _IssueCubeDetailPageState({this.fcubeextender1});
  bool ispageloading = false;
  CameraPosition initialCameraPosition;
  GoogleMapController _mapController;
  Fcubecontent description;
  Set<Marker> makres = new Set<Marker>();
  CubeMakeRichTextEdit richtextview;
  double currentdistancediff = 0;
  Position currentposition;
  Timer remainRefrashTimer;
  Timer mianRefrashTimer;
  PanelController panelcontroller = new PanelController();
  bool isSlidingUpPanelDrag = false;
  ScrollNotification scorllernotifiy;
  IssueCurrentPanel currentpanel = IssueCurrentPanel.close;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ispageloading = true;
    initialCameraPosition = new CameraPosition(
        target: LatLng(fcubeextender1.latitude, fcubeextender1.longitude),
        zoom: 16);
  }

  @override
  void didInitState() async {
    // TODO: implement didInitState
    setState(() {
      ispageloading = true;
    });
    currentposition = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    currentdistancediff = await Geolocator().distanceBetween(
        currentposition.latitude,
        currentposition.longitude,
        fcubeextender1.latitude,
        fcubeextender1.longitude);
    currentdistancediff = currentdistancediff.roundToDouble();

    await fcubeextender1.getwithupdatecubestate();
    List<FcubecontentType> contentitems = List<FcubecontentType>();
    contentitems.add(FcubecontentType.description);
    FcubeContentSelector searchitem = FcubeContentSelector(
        uid: fcubeextender1.uid,
        cubeuuid: fcubeextender1.cubeuuid,
        contenttypes: contentitems);
    Map<FcubecontentType, Fcubecontent> detailcontent =
        await Fcubecontent.getFcubecontent(searchitem);
    description = detailcontent[FcubecontentType.description];
    richtextview = CubeMakeRichTextEdit(
      custommode: "nomal",
      customscrollmode: "noscroll",
      jsondata: json.decode(description.contentvalue)["description"],
      zefyrMode: ZefyrMode.view,
    );
    setState(() {
      ispageloading = false;
    });
    remainRefrashTimer = Timer.periodic(Duration(seconds: 1), remainRefrash);
    mianRefrashTimer = Timer.periodic(Duration(seconds: 10), mainRefrash);
  }

  void remainRefrash(Timer timer) {
    setState(() {});
  }

  void mainRefrash(Timer timer) async {
    await fcubeextender1.getwithupdatecubestate();
  }

  FcubeJoinMode getjoinmode() {
    String useruid = GlobalStateContainer.of(context).state.userInfoMain.uid;
    if (useruid == null) {
      return FcubeJoinMode.player;
    } else {
      if (useruid == fcubeextender1.uid) {
        return FcubeJoinMode.administrator;
      } else {
        return FcubeJoinMode.player;
      }
    }
  }

  void onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    setmakers();
  }

  void setmakers() async {
    BitmapDescriptor icon =
        await Fcube.getMarkerImage("assets/MarkesImages/TempCube.png", 150);

    setState(() {
      makres.add(Marker(
          markerId: MarkerId("MainCube"),
          icon: icon,
          position: LatLng(fcubeextender1.latitude, fcubeextender1.longitude)));
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    remainRefrashTimer.cancel();
    mianRefrashTimer.cancel();
  }

  makebottomNavi(FcubeState state) {
    switch (state) {
      case FcubeState.play:
        return Container(
            color: Color.fromARGB(125, 10, 10, 10), child: makePlaymodebtn());
        break;
      case FcubeState.finish:
        return Container(
          child: Container(
            child: RaisedButton(
              child: Text("결과 확인"),
              onPressed: () async {
                await Navigator.push(context,
                    MaterialPageRoute(builder: (context) {
                  return IssueCubeResultView(fcubeextender1: fcubeextender1);
                }));
              },
            ),
          ),
        );
        break;
    }
  }

  Widget makePlaymodebtn() {
    FcubeJoinMode mode = getjoinmode();
    if (mode == FcubeJoinMode.administrator) {
      return Container(
          child: Row(children: <Widget>[
        Expanded(
          child: Container(),
        ),
        Container(
          child: RaisedButton(onPressed: () {}, child: Text("시간 연장하기")),
        )
      ]));
    } else if (mode == FcubeJoinMode.player) {
      return Container(
          child: Row(children: <Widget>[
        Expanded(
          child: Container(),
        ),
        Container(
          child: RaisedButton(onPressed: () {}, child: Text("후원하기")),
        )
      ]));
    } else {
      return Container(
          child: Row(children: <Widget>[
        Expanded(
          child: Container(),
        ),
        Container(
          child: RaisedButton(onPressed: () {}, child: Text("345")),
        )
      ]));
    }
  }

  Widget makeuppanel() {
    if (currentpanel == IssueCurrentPanel.setting) {
      return setpanel();
    } else {
      return Container();
    }
  }

  Widget setpanel() {
    return Container(
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            RaisedButton(
              child: Icon(Icons.arrow_downward),
              onPressed: () {
                currentpanel = IssueCurrentPanel.close;
                setState(() {});
                panelcontroller.close();
              },
            ),
            ListTile(
              title: FlatButton(
                child: Text("수정하기"),
                onPressed: () {},
              ),
            ),
            ListTile(
                title: FlatButton(
              child: Text("삭제하기"),
              onPressed: () async {
                await fcubeextender1.deletecube();
                Navigator.pop(context);
              },
            )),
          ],
        ));
  }

  double calcpanelmaxheight() {
    if (currentpanel == IssueCurrentPanel.setting) {
      return 170;
    } else {
      return 100;
    }
  }

  @override
  Widget build(BuildContext context) {
    final GoogleMap googleMap = GoogleMap(
      gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
        new Factory<OneSequenceGestureRecognizer>(
          () => new EagerGestureRecognizer(),
        ),
      ].toSet(),
      initialCameraPosition: initialCameraPosition,
      onMapCreated: onMapCreated,
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
      markers: makres,
    );
    String makeitme = DateFormat("yyyy-MM-dd HH:mm:ss").format(
        DateTime.parse(fcubeextender1.maketime).add(Duration(hours: 9)));

    return WillPopScope(
      onWillPop: () {
        remainRefrashTimer.cancel();
        mianRefrashTimer.cancel();
        Navigator.pop(context);
        return;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: FlatButton(
            child: Icon(Icons.arrow_back),
            onPressed: () {
              remainRefrashTimer.cancel();
              mianRefrashTimer.cancel();
              Navigator.pop(context);
            },
          ),
          actions: <Widget>[
            RaisedButton(
              child: Icon(Icons.ac_unit),
              onPressed: () {},
            ),
            RaisedButton(
              child: Icon(Icons.call_merge),
              onPressed: () {
                currentpanel = IssueCurrentPanel.setting;
                setState(() {});
                panelcontroller.open();
              },
            ),
          ],
        ),
        body: ispageloading
            ? CircularProgressIndicator()
            : SlidingUpPanel(
                maxHeight: calcpanelmaxheight(),
                minHeight: 70,
                controller: panelcontroller,
                isDraggable: isSlidingUpPanelDrag,
                panel: Container(
                  child: makeuppanel(),
                ),
                collapsed: scorllernotifiy is ScrollUpdateNotification
                    ? Container()
                    : makebottomNavi(fcubeextender1.cubestate),
                renderPanelSheet: false,
                body: NotificationListener<ScrollNotification>(
                    onNotification: (scrollNotification) {
                      scorllernotifiy = scrollNotification;
                      setState(() {});
                    },
                    child: ListView(
                      children: <Widget>[
                        StickyHeader(
                          header: Container(
                            height: MediaQuery.of(context).size.height * 0.1,
                            child: ListTile(
                              contentPadding: EdgeInsets.all(0),
                              leading: Image(
                                image: AssetImage(
                                    "assets/MarkesImages/TempCube.png"),
                              ),
                              title: Text(fcubeextender1.cubename),
                              subtitle: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Text(fcubeextender1.placeaddress),
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
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        fcubeextender1.profilepicktureurl),
                                  ),
                                  title: Text(fcubeextender1.cubename),
                                  subtitle: Text(
                                      DateFormat("yyyy-MM-dd HH:mm:ss").format(
                                          DateTime.parse(
                                                  fcubeextender1.maketime)
                                              .add(Duration(hours: 9)))),
                                )),
                            content: Column(
                              children: <Widget>[
                                Container(
                                  // key: _richtextkey,
                                  child: richtextview,
                                ),
                                Container(
                                  child: Row(
                                    children: <Widget>[
                                      Text("조회수 = ${fcubeextender1.cubehits}"),
                                      Text("등록일시 = ${makeitme}"),
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                          "남은 시간 = ${fcubeextender1.remindActiveTimetoString()}")
                                    ],
                                  ),
                                )
                              ],
                            ))
                      ],
                    )),
              ),
      ),
    );
  }
}
