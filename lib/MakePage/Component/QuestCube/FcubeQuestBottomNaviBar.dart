import 'package:flutter/material.dart';
import 'package:forutonafront/MakePage/Component/Fcube.dart';

enum FcubeQuestBottomNaviFuncType {
  descriptionPositionModify,
  descriptionQuestModify,
  cubeRePosition,
  optionModify,
  delete,
}

class FcubeQuestBottomNaviBar extends StatelessWidget {
  final Fcube fcube;
  final Function onfuntionclick;

  const FcubeQuestBottomNaviBar({Key key, this.fcube, this.onfuntionclick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.40,
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment(-1, 0),
              height: MediaQuery.of(context).size.height * 0.06,
              width: MediaQuery.of(context).size.width,
              child: FlatButton(
                child: Text("설치위치 수정"),
                onPressed: () {
                  onfuntionclick(
                      FcubeQuestBottomNaviFuncType.descriptionPositionModify,
                      this.fcube);
                },
              ),
            ),
            Divider(
              color: Colors.black,
            ),
            Container(
              alignment: Alignment(-1, 0),
              height: MediaQuery.of(context).size.height * 0.06,
              width: MediaQuery.of(context).size.width,
              child: FlatButton(
                child: Text("퀘스트설명 수정"),
                onPressed: () {
                  onfuntionclick(
                      FcubeQuestBottomNaviFuncType.descriptionQuestModify,
                      this.fcube);
                },
              ),
            ),
            Divider(
              color: Colors.black,
            ),
            Container(
              alignment: Alignment(-1, 0),
              height: MediaQuery.of(context).size.height * 0.06,
              width: MediaQuery.of(context).size.width,
              child: FlatButton(
                child: Text("박스 재설정"),
                onPressed: () {
                  onfuntionclick(
                      FcubeQuestBottomNaviFuncType.cubeRePosition, this.fcube);
                },
              ),
            ),
            Divider(
              color: Colors.black,
            ),
            Container(
              alignment: Alignment(-1, 0),
              height: MediaQuery.of(context).size.height * 0.06,
              width: MediaQuery.of(context).size.width,
              child: FlatButton(
                child: Text("옵션 수정"),
                onPressed: () {
                  onfuntionclick(
                      FcubeQuestBottomNaviFuncType.optionModify, this.fcube);
                },
              ),
            ),
            Divider(
              color: Colors.black,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.06,
              width: MediaQuery.of(context).size.width,
              child: FlatButton(
                child: Container(
                    alignment: Alignment(-1, 0), child: Text("삭제 하기")),
                onPressed: () {
                  onfuntionclick(
                      FcubeQuestBottomNaviFuncType.delete, this.fcube);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
