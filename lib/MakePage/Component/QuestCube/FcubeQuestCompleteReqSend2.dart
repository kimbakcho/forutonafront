import 'package:flutter/material.dart';
import 'package:forutonafront/MakePage/Component/QuestCube/FcubeQuest.dart';
import 'package:forutonafront/MakePage/Component/QuestCube/FcubeQuestCompleteReqSend3.dart';
import 'package:forutonafront/PlayPage/QuestCube/FcubeQuestSuccessExtender1.dart';

class FcubeQuestCompleteReqSend2 extends StatefulWidget {
  final FcubeQuest fcubequest;
  final FcubeQuestSuccessExtender1 item;
  FcubeQuestCompleteReqSend2({Key key, this.fcubequest, this.item})
      : super(key: key);

  @override
  _FcubeQuestCompleteReqSend2State createState() {
    return _FcubeQuestCompleteReqSend2State(fcubequest: fcubequest, item: item);
  }
}

class _FcubeQuestCompleteReqSend2State
    extends State<FcubeQuestCompleteReqSend2> {
  _FcubeQuestCompleteReqSend2State({this.fcubequest, this.item});
  FcubeQuest fcubequest;
  FcubeQuestSuccessExtender1 item;
  TextEditingController commentcontroller = TextEditingController();
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
                    child: TextField(
                      autofocus: true,
                      controller: commentcontroller,
                      decoration: InputDecoration(border: OutlineInputBorder()),
                      minLines: 3,
                      maxLines: 6,
                    ),
                  )
                ],
              ),
            ),
            Container(
              alignment: Alignment(1, 0),
              child: RaisedButton(
                onPressed: () async {
                  item.toplayercomment = commentcontroller.text;
                  if (await item.updateQuesttoplayercomment() > 0) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return FcubeQuestCompleteReqSend3(
                          fcubequest: fcubequest, item: item);
                    }));
                  }
                },
                child: Text("작성 완료"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
