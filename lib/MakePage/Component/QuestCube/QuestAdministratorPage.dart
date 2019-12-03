import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:forutonafront/Auth/UserInfoMain.dart';
import 'package:forutonafront/Common/Fcubeplayer.dart';
import 'package:forutonafront/Common/FcubeplayerExtender1.dart';
import 'package:forutonafront/MakePage/Component/FcubeExtender1.dart';
import 'package:forutonafront/MakePage/Component/QuestCube/FcubeQuest.dart';
import 'package:forutonafront/MakePage/Component/QuestCube/FcubeQuestCard.dart';
import 'package:forutonafront/MakePage/FcubeTypes.dart';
import 'package:forutonafront/MakePage/Fcubecontent.dart';
import 'package:forutonafront/globals.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class QuestAdministratorPage extends StatefulWidget {
  FcubeQuest fcubequest;
  QuestAdministratorPage({Key key, this.fcubequest}) : super(key: key);

  @override
  _QuestAdministratorPageState createState() {
    return _QuestAdministratorPageState(this.fcubequest);
  }
}

class _QuestAdministratorPageState extends State<QuestAdministratorPage>
    with SingleTickerProviderStateMixin {
  FcubeQuest fcubequest;
  _QuestAdministratorPageState(this.fcubequest);
  GoogleMapController _mapController;
  CameraPosition initialCameraPosition;
  Set<Marker> markers = new Set<Marker>();
  List<FcubeplayerExtender1> players = new List<FcubeplayerExtender1>();
  bool isdataloading = false;
  FcubeplayerExtender1 playerextender1;
  Timer mianRefrashTimer;
  Timer remainRefrashTimer;
  TabController tabController;
  Map<FcubecontentType, Fcubecontent> detailcontent;
  FcubeTypeMakerImage fcubetypeiamge;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = new TabController(length: 4, vsync: this);

    playerextender1 = FcubeplayerExtender1.fromFcubeplayer(
        Fcubeplayer(cubeuuid: fcubequest.cubeuuid));
    initialCameraPosition = new CameraPosition(
        target: LatLng(fcubequest.latitude, fcubequest.longitude), zoom: 16);
    init();
  }

  init() async {
    isdataloading = true;
    fcubetypeiamge =
        FcubeTypeMakerImage(big: 150, nomal: 100, iconimagesize: 50);
    await fcubetypeiamge.initImage();
    detailcontent = await initFcubeQuest();
    players = await FcubeplayerExtender1.selectPlayers(playerextender1);

    isdataloading = false;
    if (remainRefrashTimer == null) {
      remainRefrashTimer = Timer.periodic(Duration(seconds: 1), remainRefrash);
    }

    setState(() {});
  }

  //남는 시간 때문에표시 때문에 1초씩 돌림
  void remainRefrash(Timer timer) async {
    setState(() {});
  }

  Future<Map<FcubecontentType, Fcubecontent>> initFcubeQuest() async {
    Map<FcubecontentType, Fcubecontent> contents;
    await Future.delayed(Duration.zero, () async {
      String uid = GolobalStateContainer.of(context).state.userInfoMain.uid;
      List<FcubecontentType> types = List<FcubecontentType>();
      types.add(FcubecontentType.startCubeLocation);
      types.add(FcubecontentType.finishCubeLocation);
      types.add(FcubecontentType.messagecubeLocations);
      types.add(FcubecontentType.checkincubeLocations);
      types.add(FcubecontentType.authmethod);
      types.add(FcubecontentType.authPicturedescription);
      contents = await Fcubecontent.getFcubecontent(FcubeContentSelector(
          cubeuuid: fcubequest.cubeuuid, uid: uid, contenttypes: types));
    });
    return contents;
  }

  onMapCreated(GoogleMapController controller) {
    players.forEach((play) async {
      BitmapDescriptor markericon =
          await UserInfoMain.getBytesFromCanvasMakerIcon(
              play.profilepicktureurl);
      if (play.latitude != null && play.longitude != null) {
        Marker marker = Marker(
            markerId: MarkerId("forutonaplayer,${play.uid}"),
            position: LatLng(play.latitude, play.longitude),
            infoWindow: InfoWindow(title: play.nickname),
            icon: markericon);

        markers.add(marker);
        setState(() {});
      }
    });
    setState(() {
      _mapController = controller;
    });
    if (mianRefrashTimer == null) {
      mianRefrashTimer = Timer.periodic(Duration(seconds: 5), maintimerFunc);
    }

    dynamic findstartcubes = json
        .decode(detailcontent[FcubecontentType.startCubeLocation].contentvalue);
    Marker startcube = Marker(
        markerId: MarkerId("startcube,"),
        position:
            LatLng(findstartcubes["latitude"], findstartcubes["longitude"]),
        icon: fcubetypeiamge.nomalimage[FcubeType.startcube],
        infoWindow: InfoWindow(title: "스타트 큐브"),
        onTap: () {
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) {
                return FcubeQuestStartCubeDialog(
                    startCubecontent:
                        detailcontent[FcubecontentType.startCubeLocation]);
              });
        });
    markers.add(startcube);

    dynamic findfinishcube = json.decode(
        detailcontent[FcubecontentType.finishCubeLocation].contentvalue);
    Marker finishcube = Marker(
        markerId: MarkerId("finishcube,"),
        position:
            LatLng(findfinishcube["latitude"], findfinishcube["longitude"]),
        icon: fcubetypeiamge.nomalimage[FcubeType.finishcube],
        infoWindow: InfoWindow(title: "피니쉬 큐브"),
        onTap: () {
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) {
                return FcubeQuestFinishcubeDialog(
                    finishCubecontent:
                        detailcontent[FcubecontentType.finishCubeLocation]);
              });
        });
    markers.add(finishcube);

    List<dynamic> findmessagecube = List<dynamic>.from(json.decode(
        detailcontent[FcubecontentType.messagecubeLocations].contentvalue));
    // .map((x) => json.decode(x)));
    for (int i = 0; i < findmessagecube.length; i++) {
      Marker messagecube = Marker(
          markerId: MarkerId("messagecube,"),
          position: LatLng(
              findmessagecube[i]["latitude"], findmessagecube[i]["longitude"]),
          icon: fcubetypeiamge.nomalimage[FcubeType.messageCube],
          onTap: () {
            showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) {
                  return FcubeQuestMesssagecubeDialog(
                      messageCubecontent: findmessagecube[i]["message"]);
                });
          });
      markers.add(messagecube);
    }
    List<dynamic> findcheckincube = List<dynamic>.from(json.decode(
        detailcontent[FcubecontentType.checkincubeLocations].contentvalue));
    // .map((x) => json.decode(x)));
    for (int i = 0; i < findcheckincube.length; i++) {
      Marker checkincube = Marker(
          markerId: MarkerId("checkcube,"),
          position: LatLng(
              findcheckincube[i]["latitude"], findcheckincube[i]["longitude"]),
          icon: fcubetypeiamge.nomalimage[FcubeType.checkincube],
          onTap: () {
            showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) {
                  return FcubeQuestCheckincubeDialog(
                      checkinCubecontent: findcheckincube[i]["message"]);
                });
          });
      markers.add(checkincube);
    }
  }

  maintimerFunc(Timer timer) async {
    print("maintimerFunc");
    if (_mapController != null) {
      players = await FcubeplayerExtender1.selectPlayers(playerextender1);
      markers.removeWhere((value) {
        return value.markerId.value.split(',')[0] == "forutonaplayer";
      });
      for (int i = 0; i < players.length; i++) {
        BitmapDescriptor markericon =
            await UserInfoMain.getBytesFromCanvasMakerIcon(
                players[i].profilepicktureurl);
        if (players[i].latitude != null && players[i].longitude != null) {
          Marker marker = Marker(
              markerId: MarkerId("forutonaplayer,${players[i].uid}"),
              position: LatLng(players[i].latitude, players[i].longitude),
              infoWindow: InfoWindow(title: players[i].nickname),
              icon: markericon);

          markers.add(marker);
        }
      }
      setState(() {});
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    mianRefrashTimer.cancel();
    remainRefrashTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final GoogleMap googleMap = GoogleMap(
      initialCameraPosition: initialCameraPosition,
      onMapCreated: onMapCreated,
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
      markers: markers,
    );
    DateTime activationtime = fcubequest.activationtime.add(Duration(hours: 9));

    Duration avtibetime = activationtime
        .difference(DateTime.now().toUtc().add(Duration(hours: 9)));
    int actday = avtibetime.inSeconds ~/ (60 * 60 * 24);
    int acthour = (avtibetime.inSeconds - actday * 60 * 60 * 24) ~/ (60 * 60);
    int actmin =
        (avtibetime.inSeconds - actday * 60 * 60 * 24 - acthour * 3600) ~/ (60);
    int actsec = avtibetime.inSeconds % 60;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Text("${players.length}"),
            SizedBox(
              width: 50,
            ),
            Text("${actday}일 ${acthour}:${actmin}:${actsec}"),
          ],
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.picture_in_picture),
            onPressed: () {},
          )
        ],
      ),
      body: isdataloading
          ? Container(
              child: CircularProgressIndicator(),
            )
          : Stack(
              children: <Widget>[
                Container(
                  child: googleMap,
                )
              ],
            ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.1,
          child: TabBar(
            controller: tabController,
            indicatorColor: Colors.black,
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.access_alarms),
              ),
              Tab(
                icon: Icon(Icons.account_balance),
              ),
              Tab(
                icon: Icon(Icons.add_alarm),
              ),
              Tab(
                icon: Icon(Icons.add_location),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
