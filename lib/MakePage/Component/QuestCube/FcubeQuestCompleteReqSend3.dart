import 'package:flutter/material.dart';
import 'package:forutonafront/MakePage/Component/QuestCube/FcubeQuest.dart';
import 'package:forutonafront/PlayPage/QuestCube/FcubeQuestSuccessExtender1.dart';

class FcubeQuestCompleteReqSend3 extends StatefulWidget {
  final FcubeQuest fcubequest;
  final FcubeQuestSuccessExtender1 item;
  FcubeQuestCompleteReqSend3({Key key, this.fcubequest, this.item})
      : super(key: key);

  @override
  _FcubeQuestCompleteReqSend3State createState() {
    return _FcubeQuestCompleteReqSend3State(fcubequest: fcubequest, item: item);
  }
}

class _FcubeQuestCompleteReqSend3State
    extends State<FcubeQuestCompleteReqSend3> {
  FcubeQuest fcubequest;
  FcubeQuestSuccessExtender1 item;
  _FcubeQuestCompleteReqSend3State({this.fcubequest, this.item});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Container(
              child: Column(
                children: <Widget>[
                  Text("퀘스트 종료"),
                  Text("${item.nickname} 님이 퀘스트를 완료 하였습니다.")
                ],
              ),
            ),
            Card(
              margin: EdgeInsets.all(10),
              elevation: 10,
              child: Column(
                children: <Widget>[
                  Container(
                    child: Text("플레이어들에게 한마디 해주세요."),
                  ),
                  Container(
                      padding: EdgeInsets.all(5),
                      child: Text(item.toplayercomment))
                ],
              ),
            ),
            Container(
              alignment: Alignment(1, 0),
              child: RaisedButton(
                onPressed: () {
                  Navigator.popUntil(context, (predic) {
                    return predic.settings.name == "FcubeQuestDetailPage";
                  });
                },
                child: Text("퀘스트 결과 페이지로 이동"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
