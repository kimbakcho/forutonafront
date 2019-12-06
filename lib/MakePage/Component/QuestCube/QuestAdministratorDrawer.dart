import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/Common/Fcubeplayer.dart';
import 'package:forutonafront/Common/FcubeplayerExtender1.dart';
import 'package:forutonafront/MakePage/Component/QuestCube/FcubeQuest.dart';
import 'package:forutonafront/MakePage/Fcubecontent.dart';

//Paly와Maker는 같은 객체를 공유 업데이트 보안 정보 체크는 BackEnd 에서 JWT로 탄탄히
class QuestAdministratorDrawer extends StatefulWidget {
  final FcubeQuest fcubequest;
  final Map<FcubecontentType, Fcubecontent> detailcontent;
  QuestAdministratorDrawer(
      {Key key, @required this.fcubequest, @required this.detailcontent})
      : super(key: key);

  @override
  _QuestAdministratorDrawerState createState() {
    return _QuestAdministratorDrawerState(
        fcubequest: this.fcubequest, detailcontent: this.detailcontent);
  }
}

class _QuestAdministratorDrawerState extends State<QuestAdministratorDrawer> {
  FcubeQuest fcubequest;
  Map<FcubecontentType, Fcubecontent> detailcontent;
  _QuestAdministratorDrawerState({this.fcubequest, this.detailcontent});
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var authmethodobj =
        json.decode(detailcontent[FcubecontentType.authmethod].contentvalue);
    String authmethod = authmethodobj["authmethod"];
    var authPicturedescriptionobj = json.decode(
        detailcontent[FcubecontentType.authPicturedescription].contentvalue);
    String authPicturedescription =
        authPicturedescriptionobj["authPicturedescription"];
    return Drawer(
      child: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: Image(
                    image: AssetImage(fcubequest.cubeimage),
                  ),
                ),
                Container(
                  child: Text(fcubequest.cubename),
                ),
                Container(
                  child: Text(fcubequest.placeaddress),
                ),
                Divider(
                  color: Colors.black,
                ),
                Container(
                  child: Text("제작자"),
                ),
                Row(
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage:
                          NetworkImage(fcubequest.profilepicktureurl),
                      maxRadius: 15,
                    ),
                    Column(
                      children: <Widget>[
                        Text(fcubequest.nickname),
                        Text("${fcubequest.userlevel}"),
                      ],
                    )
                  ],
                ),
                Divider(
                  color: Colors.black,
                ),
                Container(
                  child: Text("완료조건"),
                ),
                Row(
                  children: <Widget>[
                    Placeholder(
                      fallbackHeight: 50,
                      fallbackWidth: 50,
                    ),
                    Column(
                      children: <Widget>[
                        Text(authmethod),
                        Text(authPicturedescription)
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width * 0.65,
            height: MediaQuery.of(context).size.height * 0.05,
            child: RaisedButton(
              onPressed: () {
                Navigator.popUntil(context, (value) {
                  return value.settings.name == "FcubeQuestDetailPage";
                });
              },
              child: Text("관리자모드에서 나가기"),
            ),
          )
        ],
      ),
    );
  }
}
