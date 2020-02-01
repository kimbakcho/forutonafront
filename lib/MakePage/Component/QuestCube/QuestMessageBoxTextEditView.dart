import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:forutonafront/MakePage/Component/CubeMakeRichTextEdit.dart';
import 'package:forutonafront/MakePage/Component/QuestCube/FcubeQuest.dart';
import 'package:zefyr/zefyr.dart';

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
  CubeRichTextController richTextController;
  FcubeQuest fcubeQuest;
  int messagecubeindex;
  _QuestMessageCubeTextEditViewState({this.fcubeQuest, this.messagecubeindex});

  @override
  void initState() {
    super.initState();
    richTextController = new CubeRichTextController();
    richTextController.isedithint = true;
    richTextController.autofocus = true;
    richTextController.ondatacahnge = (value) {
      setState(() {});
    };
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
                fcubeQuest.messagecubeLocations[messagecubeindex].message =
                    jsonEncode(richTextController.document.toJson());
                Navigator.pop(context, "sucess");
              },
            ),
          )
        ],
      ),
      body: Stack(
        children: <Widget>[
          CubeMakeRichTextEdit(
              custommode: "forutona1",
              zefyrMode: ZefyrMode.edit,
              fcube: fcubeQuest,
              parentcontroller: richTextController),
          Positioned(
            top: 40,
            left: 20,
            child: richTextController.isedithint
                ? Text("메세지 내용을 입력 하세요.")
                : Container(
                    width: 0,
                  ),
          ),
        ],
      ),
    );
  }
}
