import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:forutonafront/MakePage/Component/QuestCube/FcubeQuest.dart';

class QuestMessageCubeTextEditView extends StatefulWidget {
  final FcubeQuest fcubeQuest;
  final int messagecubeindex;

  QuestMessageCubeTextEditView(
      {Key key, this.fcubeQuest, this.messagecubeindex})
      : super(key: key);

  @override
  _QuestMessageCubeTextEditViewState createState() {
    return _QuestMessageCubeTextEditViewState(
        fcubeQuest: this.fcubeQuest, messagecubeindex: this.messagecubeindex);
  }
}

class _QuestMessageCubeTextEditViewState
    extends State<QuestMessageCubeTextEditView> {
  FcubeQuest fcubeQuest;
  int messagecubeindex;

  _QuestMessageCubeTextEditViewState({this.fcubeQuest, this.messagecubeindex});

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
                fcubeQuest.messagecubeLocations[messagecubeindex].message = "";
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
