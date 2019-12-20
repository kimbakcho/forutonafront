import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:forutonafront/MakePage/Component/Fcube.dart';
import 'package:forutonafront/MakePage/Component/QuestCube/FcubeQuest.dart';

class FcubeQuestDetailSetupView extends StatefulWidget {
  final FcubeQuest fcubeQuest;
  FcubeQuestDetailSetupView({Key key, this.fcubeQuest}) : super(key: key);

  @override
  _FcubeQuestDetailSetupViewState createState() {
    return _FcubeQuestDetailSetupViewState(fcubeQuest: this.fcubeQuest);
  }
}

class _FcubeQuestDetailSetupViewState extends State<FcubeQuestDetailSetupView> {
  FcubeQuest fcubeQuest;
  _FcubeQuestDetailSetupViewState({this.fcubeQuest});
  TextEditingController authdiscriptioncontroller = TextEditingController();
  GlobalKey<FormState> checksetupform = new GlobalKey();

  bool isuploading = false;

  String authmethod = "인증샷";
  Future<void> _ackAlert(BuildContext context) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: const Text('퀘스트 큐브 생성을 완료 하였습니다.'),
          actions: <Widget>[
            FlatButton(
              child: Text('확인'),
              onPressed: () {
                Navigator.of(context).popUntil(ModalRoute.withName("/"));
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          Container(
            margin: EdgeInsets.all(10),
            child: RaisedButton(
              onPressed: () async {
                if (checksetupform.currentState.validate()) {
                  fcubeQuest.authmethod = authmethod;
                  fcubeQuest.authPicturedescription =
                      authdiscriptioncontroller.text;
                  fcubeQuest.etcCubemode = json.encode({"maxSuccess": 1});

                  isuploading = true;
                  setState(() {});
                  fcubeQuest.cubestate = FcubeState.startWait;
                  int result = await fcubeQuest.makecube();
                  isuploading = false;
                  setState(() {});
                  if (result == 1) {
                    _ackAlert(context);
                  }
                } else {
                  setState(() {});
                }
              },
              child: isuploading ? CircularProgressIndicator() : Text("완료"),
            ),
          )
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              child: Row(
                children: <Widget>[
                  Expanded(child: Text("완료 조건")),
                  DropdownButton(
                    value: authmethod,
                    onChanged: (value) {
                      authmethod = value;
                      setState(() {});
                    },
                    icon: Icon(Icons.arrow_downward),
                    items: <String>[
                      '인증샷',
                      '인증샷2',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  )
                ],
              ),
            ),
            Form(
              key: checksetupform,
              child: TextFormField(
                validator: (value) {
                  if (value.length == 0) {
                    return "인증샷에 대한 내용이 없습니다.";
                  } else {
                    return null;
                  }
                },
                controller: authdiscriptioncontroller,
                decoration:
                    InputDecoration(hintText: "어떤 인증샷을 보내야 퀘스트를 완료 할수 있나요?"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
