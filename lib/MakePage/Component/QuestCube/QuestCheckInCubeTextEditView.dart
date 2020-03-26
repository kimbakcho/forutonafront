import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:forutonafront/MakePage/Component/QuestCube/FcubeQuest.dart';

class QuestCheckInCubeTextEditView extends StatefulWidget {
  final FcubeQuest fcubeQuest;
  final int checkincubeindex;

  QuestCheckInCubeTextEditView(
      {Key key, this.fcubeQuest, this.checkincubeindex})
      : super(key: key);

  @override
  _QuestCheckInCubeTextEditViewState createState() {
    return _QuestCheckInCubeTextEditViewState(
        fcubeQuest: this.fcubeQuest, checkincubeindex: this.checkincubeindex);
  }
}

class _QuestCheckInCubeTextEditViewState
    extends State<QuestCheckInCubeTextEditView> {
  FcubeQuest fcubeQuest;
  int checkincubeindex;

  _QuestCheckInCubeTextEditViewState({this.fcubeQuest, this.checkincubeindex});

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          Container(
            margin: EdgeInsets.all(10),
            child: RaisedButton(
              child: Text("완료"),
              onPressed: () {
                fcubeQuest.checkincubeLocations[checkincubeindex].message = "";
                Navigator.pop(context, "sucess");
              },
            ),
          )
        ],
      ),
      body: Stack(
        children: <Widget>[],
      ),
    );
  }
}
