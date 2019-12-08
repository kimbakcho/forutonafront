import 'package:flutter/material.dart';
import 'package:forutonafront/MakePage/Component/QuestCube/FcubeQuest.dart';
import 'package:forutonafront/MakePage/Component/QuestCube/FcubeQuestCompleteReqSend.dart';
import 'package:forutonafront/MakePage/Fcubecontent.dart';

class FcubeQuestCompleteReqView extends StatefulWidget {
  final FcubeQuest fcubequest;
  final Map<FcubecontentType, Fcubecontent> detailcontent;
  FcubeQuestCompleteReqView({Key key, this.fcubequest, this.detailcontent})
      : super(key: key);

  @override
  _FcubeQuestCompleteReqViewState createState() {
    return _FcubeQuestCompleteReqViewState(
        fcubequest: this.fcubequest, detailcontent: this.detailcontent);
  }
}

class _FcubeQuestCompleteReqViewState extends State<FcubeQuestCompleteReqView> {
  FcubeQuest fcubequest;
  Map<FcubecontentType, Fcubecontent> detailcontent;
  _FcubeQuestCompleteReqViewState({this.fcubequest, this.detailcontent});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          RaisedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return FcubeQuestCompleteReqSend(
                    fcubequest: fcubequest, detailcontent: detailcontent);
              }));
            },
            child: Text("제출하기"),
          )
        ],
      ),
      body: Container(
        child: Text("123"),
      ),
    );
  }
}
