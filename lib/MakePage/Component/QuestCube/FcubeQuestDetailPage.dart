import 'dart:io';

import 'package:flutter/material.dart';
import 'package:forutonafront/MakePage/Component/Fcube.dart';
import 'package:forutonafront/MakePage/Component/QuestCube/FcubeQuest.dart';
import 'package:forutonafront/MakePage/Fcubecontent.dart';
import 'package:forutonafront/globals.dart';

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fcubequest = FcubeQuest(cube: fcube);
    initFcubeQuest();
  }

  initFcubeQuest() async {
    Future.delayed(Duration.zero, () async {
      isloading = true;
      String uid = GolobalStateContainer.of(context).state.userInfoMain.uid;
      List<FcubecontentType> types = List<FcubecontentType>();
      types.add(FcubecontentType.startCubeLocation);
      types.add(FcubecontentType.finishCubeLocation);
      types.add(FcubecontentType.description);
      types.add(FcubecontentType.messagecubeLocations);
      types.add(FcubecontentType.checkincubeLocations);
      types.add(FcubecontentType.authmethod);
      types.add(FcubecontentType.authPicturedescription);

      Map<FcubecontentType, Fcubecontent> contents =
          await Fcubecontent.getFcubecontent(FcubeContentSelector(
              cubeuuid: fcube.cubeuuid, uid: uid, contenttypes: types));
      isloading = false;
    });
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
            ? CircularProgressIndicator()
            : Container(
                child: Text("123"),
              ));
  }
}
