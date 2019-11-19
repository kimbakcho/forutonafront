import 'dart:io';

import 'package:flutter/material.dart';
import 'package:forutonafront/MakePage/Component/Fcube.dart';
import 'package:forutonafront/MakePage/Component/QuestCube/FcubeQuest.dart';
import 'package:forutonafront/MakePage/FcubeTypes.dart';
import 'package:forutonafront/MakePage/Fcubecontent.dart';
import 'package:forutonafront/globals.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sticky_headers/sticky_headers.dart';

class FcubeQuestDetailPage extends StatefulWidget {
  final Fcube fcube;
  FcubeQuestDetailPage({Key key, this.fcube}) : super(key: key);

  @override
  _FcubeQuestDetailPageState createState() {
    return _FcubeQuestDetailPageState(fcube: fcube);
  }
}

class _FcubeQuestDetailPageState extends State<FcubeQuestDetailPage> {
  Fcube fcube;
  _FcubeQuestDetailPageState({this.fcube});

  bool isloading = false;
  FcubeQuest fcubequest;
  Map<FcubecontentType, Fcubecontent> contents;
  var geolocator = Geolocator();
  var locationOptions =
      LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);
  Position currentposition;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fcubequest = FcubeQuest(cube: fcube);
    init();
  }

  init() async {
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
          cubeuuid: fcube.cubeuuid, uid: uid, contenttypes: types));
    });
    return contents;
  }

  initgeolocation() async {
    PermissionStatus permissition = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.location);
    if (permissition == PermissionStatus.granted) {
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
        setState(() {});
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

  @override
  Widget build(BuildContext context) {
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
                  children: <Widget>[
                    StickyHeader(
                      header: Container(
                        height: 50,
                        child: Text("123"),
                      ),
                      content: Container(
                        height: 400,
                        child: Text("123123"),
                      ),
                    ),
                    StickyHeader(
                      header: Container(
                        height: 50,
                        child: Text("AAA"),
                      ),
                      content: Container(
                        height: 400,
                        child: Text("1231AAAA23"),
                      ),
                    ),
                    StickyHeader(
                      header: Container(
                        height: 50,
                        child: Text("BB"),
                      ),
                      content: Container(
                        height: 400,
                        child: Text("BBB"),
                      ),
                    )
                  ],
                ),
                Positioned(
                  bottom: 0,
                  child: bottomNavi(fcubequest.cubestate),
                )
              ]));
  }
}
