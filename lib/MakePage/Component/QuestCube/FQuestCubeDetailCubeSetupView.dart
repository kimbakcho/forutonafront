import 'package:flutter/material.dart';
import 'package:forutonafront/MakePage/Component/QuestCube/FcubeQuest.dart';

class FQuestCubeDetailCubeSetupView extends StatefulWidget {
  final FcubeQuest fcubeQuest;
  FQuestCubeDetailCubeSetupView({Key key, this.fcubeQuest}) : super(key: key);

  @override
  _FQuestCubeDetailCubeSetupViewState createState() {
    return _FQuestCubeDetailCubeSetupViewState(fcubeQuest: fcubeQuest);
  }
}

class _FQuestCubeDetailCubeSetupViewState
    extends State<FQuestCubeDetailCubeSetupView> {
  FcubeQuest fcubeQuest;
  _FQuestCubeDetailCubeSetupViewState({this.fcubeQuest});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[],
      ),
      body: Container(
        child: Text("123"),
      ),
    );
  }
}
