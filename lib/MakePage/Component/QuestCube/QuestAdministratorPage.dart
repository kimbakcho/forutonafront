import 'dart:async';
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/Auth/UserInfoMain.dart';
import 'package:forutonafront/Common/Fcubeplayer.dart';
import 'package:forutonafront/Common/FcubeplayerExtender1.dart';
import 'package:forutonafront/MakePage/Component/QuestCube/FcubeQuest.dart';
import 'package:forutonafront/MakePage/Component/QuestCube/FcubeQuestCard.dart';
import 'package:forutonafront/MakePage/Component/QuestCube/FcubeQuestCompleteReqView.dart';
import 'package:forutonafront/MakePage/Component/QuestCube/FcubeQuestDetailPage.dart';
import 'package:forutonafront/MakePage/Component/QuestCube/QuestAdministratorDrawer.dart';
import 'package:forutonafront/MakePage/FcubeTypes.dart';
import 'package:forutonafront/MakePage/Fcubecontent.dart';
import 'package:forutonafront/PlayPage/Fcubeplayercontent.dart';
import 'package:forutonafront/PlayPage/FcubeplayercontentExtender1.dart';
import 'package:forutonafront/PlayPage/QuestCube/FcubeQuestSuccessExtender1.dart';
import 'package:forutonafront/globals.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_circle_distance2/great_circle_distance2.dart';

class QuestAdministratorPage extends StatefulWidget {
  final FcubeQuest fcubequest;
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
  List<FcubeplayerExtender1> myfcubs = new List<FcubeplayerExtender1>();
  List<FcubeplayerExtender1> players = new List<FcubeplayerExtender1>();
  bool isdataloading = false;
  FcubeplayerExtender1 playerextender1;
  Timer mianRefrashTimer;
  Timer remainRefrashTimer;
  TabController tabController;
  Map<FcubecontentType, Fcubecontent> detailcontent;
  List<FcubeplayercontentExtender1> playerdetailcontent;
  FcubeTypeMakerImage fcubetypeiamge;
  var _questAdministratorPageState = new GlobalKey<ScaffoldState>();
  FirebaseUser _currentuser;
  Fcubeplayer myplayer;
  List<FcubeQuestSuccessExtender1> reqsuccesslist =
      List<FcubeQuestSuccessExtender1>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    markers.clear();
    tabController = new TabController(length: 4, vsync: this);

    playerextender1 = FcubeplayerExtender1.fromFcubeplayer(
        Fcubeplayer(cubeuuid: fcubequest.cubeuuid));
    initialCameraPosition = new CameraPosition(
        target: LatLng(fcubequest.latitude, fcubequest.longitude), zoom: 16);
    init();
  }

  @override
  void dispose() {
    super.dispose();
    mianRefrashTimer.cancel();
    remainRefrashTimer.cancel();
  }

  init() async {
    isdataloading = true;
    _currentuser = await FirebaseAuth.instance.currentUser();
    myplayer =
        new Fcubeplayer(cubeuuid: fcubequest.cubeuuid, uid: _currentuser.uid);
    myfcubs = await FcubeplayerExtender1.selectPlayers(myplayer);
    fcubetypeiamge =
        FcubeTypeMakerImage(big: 150, nomal: 100, iconimagesize: 50);
    await fcubetypeiamge.initImage();
    detailcontent = await initFcubeQuest();

    if (getjoinmode() == FcubeJoinMode.player) {
      playerdetailcontent = await initFcubeQuestPlayerContent();
    }

    isdataloading = false;
    if (remainRefrashTimer == null) {
      remainRefrashTimer = Timer.periodic(Duration(seconds: 1), remainRefrash);
    }

    setState(() {});
  }

  FcubeJoinMode getjoinmode() {
    if (_currentuser == null) {
      return FcubeJoinMode.player;
    } else {
      if (_currentuser.uid == fcubequest.uid) {
        return FcubeJoinMode.administrator;
      } else {
        return FcubeJoinMode.player;
      }
    }
  }

  //남는 시간 때문에표시 때문에 1초씩 돌림
  void remainRefrash(Timer timer) async {
    //남은 시간은 utc로 계산해도됨.
    DateTime activationtime = fcubequest.activationtime;
    Duration avtibetime = activationtime.difference(DateTime.now().toUtc());
    await fcubequest.getwithupdatecubestate();
    if (avtibetime.inSeconds < 0) {
      mianRefrashTimer.cancel();
      remainRefrashTimer.cancel();
      await showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return AlertDialog(
                content: FcubeQuestReviewCard(fcubequest: fcubequest));
          });
      Navigator.pop(context);
    }
    setState(() {});
  }

  Future<Map<FcubecontentType, Fcubecontent>> initFcubeQuest() async {
    Map<FcubecontentType, Fcubecontent> contents;
    await Future.delayed(Duration.zero, () async {
      String uid = GlobalStateContainer.of(context).state.userInfoMain.uid;
      List<FcubecontentType> types = List<FcubecontentType>();
      types.add(FcubecontentType.startCubeLocation);
      types.add(FcubecontentType.finishCubeLocation);
      types.add(FcubecontentType.messagecubeLocations);
      types.add(FcubecontentType.checkincubeLocations);
      types.add(FcubecontentType.authmethod);
      types.add(FcubecontentType.authPicturedescription);
      types.add(FcubecontentType.etcCubemode);
      contents = await Fcubecontent.getFcubecontent(FcubeContentSelector(
          cubeuuid: fcubequest.cubeuuid, uid: uid, contenttypes: types));
    });
    return contents;
  }

  Future<List<FcubeplayercontentExtender1>>
      initFcubeQuestPlayerContent() async {
    List<FcubeplayercontentExtender1> contents;
    await Future.delayed(Duration.zero, () async {
      String uid = GlobalStateContainer.of(context).state.userInfoMain.uid;
      List<FcubeplayercontentType> types = List<FcubeplayercontentType>();
      types.add(FcubeplayercontentType.startCubeLocationCheckin);
      types.add(FcubeplayercontentType.checkInCubeLocationCheckin);
      contents =
          await FcubeplayercontentExtender1.getFcubeplayercontentTypeList(
              FcubeplayercontentSelector(
                  cubeuuid: fcubequest.cubeuuid,
                  uid: uid,
                  contenttypes: types));
    });
    return contents;
  }

  onMapCreated(GoogleMapController controller) {
    setState(() {
      _mapController = controller;
    });
    FcubeplayercontentExtender1 startCubeLocationCheckin;
    if (getjoinmode() == FcubeJoinMode.player) {
      int index = playerdetailcontent.indexWhere((value) {
        return value.contenttype ==
            FcubeplayercontentType.startCubeLocationCheckin;
      });
      if (index >= 0) {
        startCubeLocationCheckin = playerdetailcontent[index];
      }
    }

    if (getjoinmode() == FcubeJoinMode.player &&
        detailcontent.containsKey(FcubecontentType.startCubeLocation) &&
        startCubeLocationCheckin == null) {
      dynamic findstartcubes = json.decode(
          detailcontent[FcubecontentType.startCubeLocation].contentvalue);
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
    } else {
      makeplayer();
      makebasicmaker();
    }
    if (mianRefrashTimer == null) {
      mianRefrashTimer = Timer.periodic(Duration(seconds: 5), maintimerFunc);
    }
  }

  makeplayer() async {
    players = await FcubeplayerExtender1.selectPlayers(playerextender1);
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
  }

  makebasicmaker() {
    dynamic findstartcubes = json
        .decode(detailcontent[FcubecontentType.startCubeLocation].contentvalue);
    Marker startcube = Marker(
        zIndex: 1,
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
        zIndex: 1,
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
          zIndex: 1,
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
    List<CheckinCubeLocation> findcheckincube = List<CheckinCubeLocation>.from(
        json
            .decode(detailcontent[FcubecontentType.checkincubeLocations]
                .contentvalue)
            .map((x) => CheckinCubeLocation.fromJson(x)));
    // .map((x) => json.decode(x)));
    for (int i = 0; i < findcheckincube.length; i++) {
      Marker checkincube = Marker(
          zIndex: 1,
          markerId: MarkerId("checkcube,"),
          position:
              LatLng(findcheckincube[i].latitude, findcheckincube[i].longitude),
          icon: fcubetypeiamge.nomalimage[FcubeType.checkincube],
          onTap: () {
            showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) {
                  return FcubeQuestCheckincubeDialog(
                    currentScaffoldState:
                        _questAdministratorPageState.currentState,
                    checkinCubecontent: findcheckincube[i],
                    fcubequest: fcubequest,
                    joinmode: getjoinmode(),
                    playerdetailcontent: playerdetailcontent,
                  );
                });
          });
      markers.add(checkincube);
    }
  }

  maintimerFunc(Timer timer) async {
    print("maintimerFunc");

    if (_mapController != null) {
      //Player 에 CheckIn 에서는 자기의 큐브만 보이기
      FcubeplayercontentExtender1 startCubeLocationCheckin;
      if (getjoinmode() == FcubeJoinMode.player &&
          detailcontent.containsKey(FcubecontentType.startCubeLocation)) {
        int index = playerdetailcontent.indexWhere((value) {
          return value.contenttype ==
              FcubeplayercontentType.startCubeLocationCheckin;
        });
        if (index >= 0) {
          startCubeLocationCheckin = playerdetailcontent[index];
        }
      }

      if (getjoinmode() == FcubeJoinMode.player &&
          myfcubs.length > 0 &&
          myfcubs[0].playstate == FcubeplayerState.playing &&
          fcubequest.remindActiveTimetoDuration().inSeconds > 0 &&
          detailcontent.containsKey(FcubecontentType.startCubeLocation) &&
          startCubeLocationCheckin == null) {
      } else {
        players = await FcubeplayerExtender1.selectPlayers(playerextender1);
        for (int i = 0; i < players.length; i++) {
          Marker findmaker = markers.firstWhere((value) {
            return value.markerId.value == "forutonaplayer,${players[i].uid}";
          });
          if (findmaker == null) {
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
          } else {
            Marker tempMarker = findmaker.copyWith(
              positionParam: LatLng(players[i].latitude, players[i].longitude),
            );
            markers.remove(findmaker);
            markers.add(tempMarker);
          }
        }
      }
      FcubeQuestSuccessExtender1 searchitem = FcubeQuestSuccessExtender1(
          cubeuuid: fcubequest.cubeuuid, readuid: _currentuser.uid);
      reqsuccesslist =
          await FcubeQuestSuccessExtender1.getPlayerQuestSuccessList(
              searchitem);
      // if (getjoinmode() == FcubeJoinMode.player) {
      // } else {}

      setState(() {});
    }
  }

  Widget makebottomNavigationBar() {
    if (isdataloading) {
      return CircularProgressIndicator();
    } else {
      if (getjoinmode() == FcubeJoinMode.player &&
          detailcontent.containsKey(FcubecontentType.startCubeLocation)) {
        FcubeplayercontentExtender1 startCubeLocationCheckin;
        int index = playerdetailcontent.indexWhere((value) {
          return value.contenttype ==
              FcubeplayercontentType.startCubeLocationCheckin;
        });
        if (index >= 0) {
          startCubeLocationCheckin = playerdetailcontent[index];
        }
        if (myfcubs.length >= 0 &&
            myfcubs[0].playstate == FcubeplayerState.playing &&
            fcubequest.remindActiveTimetoDuration().inSeconds > 0 &&
            startCubeLocationCheckin == null) {
          bool nearhavestartcube = false;
          dynamic startCubeLocation = json.decode(
              detailcontent[FcubecontentType.startCubeLocation].contentvalue);
          Position currentposition =
              GlobalStateContainer.of(context).state.currentposition;
          double scubedistance = GreatCircleDistance.fromDegrees(
                  latitude1: startCubeLocation["latitude"],
                  longitude1: startCubeLocation["longitude"],
                  latitude2: currentposition.latitude,
                  longitude2: currentposition.longitude)
              .haversineDistance();
          if (scubedistance < 5) {
            nearhavestartcube = true;
          }
          return Container(
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width,
            child: Container(
              margin: EdgeInsets.all(8),
              child: FloatingActionButton(
                onPressed: nearhavestartcube
                    ? () async {
                        print("check in");
                        FcubeplayercontentExtender1 startcubecheckin =
                            FcubeplayercontentExtender1(
                          contenttype:
                              FcubeplayercontentType.startCubeLocationCheckin,
                          contentvalue: json.encode({
                            "latitude": currentposition.latitude,
                            "longitude": currentposition.longitude,
                            "checkintime":
                                DateTime.now().toUtc().toIso8601String()
                          }),
                          contentupdatetime: DateTime.now().toUtc(),
                          cubeuuid: fcubequest.cubeuuid,
                          uid: _currentuser.uid,
                        );
                        if (await startcubecheckin.makeFcubeplayercontent() >
                            0) {
                          playerdetailcontent.add(startcubecheckin);
                          makeplayer();
                          makebasicmaker();
                          setState(() {});
                        }
                      }
                    : null,
                backgroundColor: nearhavestartcube ? Colors.white : Colors.grey,
                disabledElevation: 20,
                child: Icon(
                  Icons.check,
                ),
              ),
            ),
          );
        }
      }
      return Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height * 0.1,
        width: MediaQuery.of(context).size.width,
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
      );
    }
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
    return WillPopScope(
      onWillPop: () {
        mianRefrashTimer.cancel();
        remainRefrashTimer.cancel();
        Navigator.pop(context);
        return;
      },
      child: Scaffold(
        key: _questAdministratorPageState,
        drawer: QuestAdministratorDrawer(
          fcubequest: fcubequest,
          detailcontent: detailcontent,
        ),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(Icons.dehaze),
            onPressed: () {
              if (!_questAdministratorPageState.currentState.isDrawerOpen) {
                _questAdministratorPageState.currentState.openDrawer();
              }
            },
          ),
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
            Stack(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * 0.1,
                  // child: Placeholder(),
                ),
                Positioned(
                  child: IconButton(
                    icon: Icon(Icons.picture_in_picture),
                    onPressed: () async {
                      mianRefrashTimer.cancel();
                      remainRefrashTimer.cancel();

                      await Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return FcubeQuestCompleteReqView(
                            fcubequest: fcubequest,
                            detailcontent: detailcontent);
                      }));
                      mianRefrashTimer =
                          Timer.periodic(Duration(seconds: 5), maintimerFunc);
                      remainRefrashTimer =
                          Timer.periodic(Duration(seconds: 1), remainRefrash);
                    },
                  ),
                ),
                Positioned(
                  child: Container(
                    color: Colors.blue,
                    child: Text("${reqsuccesslist.length}"),
                  ),
                  top: 5,
                  left: 5,
                )
              ],
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
                  ),
                  Positioned(
                    bottom: 0,
                    child: makebottomNavigationBar(),
                  )
                ],
              ),
        // bottomNavigationBar: (),
      ),
    );
  }
}
