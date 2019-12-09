import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:forutonafront/MakePage/Fcubecontent.dart';
import 'package:forutonafront/PlayPage/QuestCube/FcubeQuestSuccess.dart';

class FcubeQuestCompleteReqSend1 extends StatefulWidget {
  final FcubeQuestAuthPicture pickreqcontent;
  final Map<FcubecontentType, Fcubecontent> detailcontent;
  FcubeQuestCompleteReqSend1({Key key, this.pickreqcontent, this.detailcontent})
      : super(key: key);

  @override
  _FcubeQuestCompleteReqSend1State createState() {
    return _FcubeQuestCompleteReqSend1State(
        pickreqcontent: this.pickreqcontent, detailcontent: this.detailcontent);
  }
}

class _FcubeQuestCompleteReqSend1State
    extends State<FcubeQuestCompleteReqSend1> {
  FcubeQuestAuthPicture pickreqcontent;
  Map<FcubecontentType, Fcubecontent> detailcontent;
  _FcubeQuestCompleteReqSend1State({this.pickreqcontent, this.detailcontent});
  String authmethod;
  @override
  void initState() {
    super.initState();
    authmethod = json.decode(
        detailcontent[FcubecontentType.authmethod].contentvalue)["authmethod"];
  }

  Widget makeauthpickture(int index) {
    return Container(
      margin: EdgeInsets.all(10),
      width: 100,
      height: 100,
      decoration: BoxDecoration(
          image: pickreqcontent.authpicture[index] != ""
              ? DecorationImage(
                  image: NetworkImage(pickreqcontent.authpicture[index]),
                  fit: BoxFit.cover)
              : null,
          border: Border.all(width: 1, color: Colors.black)),
    );
  }

  Widget makeauthwidget() {
    if (authmethod == "인증샷") {
      return Column(
        children: <Widget>[
          Container(
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.3),
            child: Text("메이커에게 인증샷을 \n 발송하였습니다."),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              makeauthpickture(0),
              makeauthpickture(1),
              makeauthpickture(2)
            ],
          ),
          Container(
            child: Text(pickreqcontent.authtext),
          ),
          Container(
            child: RaisedButton(
              onPressed: () {
                Navigator.popUntil(context, (predic) {
                  return predic.settings.name == "QuestAdministratorPage";
                });
              },
              child: Text("확인"),
            ),
          )
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[],
      ),
      body: Container(
        child: makeauthwidget(),
      ),
    );
  }
}
