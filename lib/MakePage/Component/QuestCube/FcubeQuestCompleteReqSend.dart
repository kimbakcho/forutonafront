import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:forutonafront/MakePage/Component/QuestCube/FcubeQuest.dart';
import 'package:forutonafront/MakePage/Component/QuestCube/FcubeQuestCompleteReqSend1.dart';
import 'package:forutonafront/MakePage/Fcubecontent.dart';
import 'package:forutonafront/PlayPage/FcubeplayercontentExtender1.dart';
import 'package:forutonafront/PlayPage/QuestCube/FcubeQuestSuccess.dart';
import 'package:forutonafront/globals.dart';
import 'package:image_picker/image_picker.dart';

class FcubeQuestCompleteReqSend extends StatefulWidget {
  final FcubeQuest fcubequest;
  final Map<FcubecontentType, Fcubecontent> detailcontent;
  FcubeQuestCompleteReqSend({Key key, this.fcubequest, this.detailcontent})
      : super(key: key);

  @override
  _FcubeQuestCompleteReqSendState createState() {
    return _FcubeQuestCompleteReqSendState(
        fcubequest: this.fcubequest, detailcontent: this.detailcontent);
  }
}

class _FcubeQuestCompleteReqSendState extends State<FcubeQuestCompleteReqSend> {
  FcubeQuest fcubequest;
  Map<FcubecontentType, Fcubecontent> detailcontent;
  _FcubeQuestCompleteReqSendState({this.fcubequest, this.detailcontent});
  String authmethod;
  String authmethodcontent;
  List<String> authimages = new List<String>();
  FcubeQuestSuccess reqitem;
  TextEditingController authtextcontroller = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    authmethod = json.decode(
        detailcontent[FcubecontentType.authmethod].contentvalue)["authmethod"];
    authmethodcontent = json.decode(
        detailcontent[FcubecontentType.authPicturedescription]
            .contentvalue)["authPicturedescription"];
    authimages.add("");
    authimages.add("");
    authimages.add("");

    reqitem = FcubeQuestSuccess(
      cubeuuid: fcubequest.cubeuuid,
      uid: fcubequest.uid,
    );
  }

  Widget makeauthpickture() {
    return ListView(children: <Widget>[
      Container(
        height: MediaQuery.of(context).size.width * 0.1,
        width: MediaQuery.of(context).size.width * 0.1,
        child: Image(
          image: AssetImage("assets/AuthMethodImages/authpick.PNG"),
        ),
      ),
      Container(
        child: Text(authmethod),
      ),
      Container(
        child: Text(authmethodcontent),
      ),
      Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            makepictureplace(0),
            makepictureplace(1),
            makepictureplace(2)
          ],
        ),
      ),
      Container(
        width: MediaQuery.of(context).size.width * 0.8,
        child: RaisedButton(
          onPressed: () async {
            var image =
                await ImagePicker.pickImage(source: ImageSource.gallery);
            var bytes = await image.readAsBytes();
            String link =
                await FcubeplayercontentExtender1.uploadAuthimage(bytes);
            print(link);
            for (int i = 0; i < authimages.length; i++) {
              if (authimages[i] == "") {
                authimages[i] = link;
                break;
              }
            }
            setState(() {});
          },
          child: Text("갤러리에서 가져오기"),
        ),
      ),
      Container(
        width: MediaQuery.of(context).size.width * 0.8,
        child: RaisedButton(
          onPressed: () async {
            var image = await ImagePicker.pickImage(source: ImageSource.camera);
            var bytes = await image.readAsBytes();
            String link =
                await FcubeplayercontentExtender1.uploadAuthimage(bytes);
            for (int i = 0; i < authimages.length; i++) {
              if (authimages[i] == "") {
                authimages[i] = link;
                break;
              }
            }
            setState(() {});
          },
          child: Text("카메라에서 가져오기"),
        ),
      ),
      Container(
          width: MediaQuery.of(context).size.width * 0.8,
          child: TextField(
            controller: authtextcontroller,
            decoration: InputDecoration(border: OutlineInputBorder()),
            maxLines: 10,
            minLines: 5,
          ))
    ]);
  }

  Widget makepictureplace(int index) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.3,
        height: MediaQuery.of(context).size.width * 0.23,
        child: FlatButton(
          onPressed: () {
            print("pic1");
          },
          child: Stack(
            overflow: Overflow.visible,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    image: authimages[index] != ""
                        ? DecorationImage(
                            image: NetworkImage(authimages[index]),
                            fit: BoxFit.cover)
                        : null,
                    border: Border.all(width: 1, color: Colors.black)),
              ),
              Positioned(
                  right: -10,
                  top: -10,
                  child: Container(
                    height: 20,
                    width: 20,
                    child: RaisedButton(
                      color: Colors.red,
                      padding: EdgeInsets.all(0),
                      child: Icon(
                        Icons.remove,
                        size: 10,
                      ),
                      onPressed: () async {
                        if (await FcubeplayercontentExtender1.deleteAuthimage(
                                authimages[index]) >
                            0) {
                          authimages[index] = "";
                          setState(() {});
                        }
                      },
                    ),
                  ))
            ],
          ),
        ));
  }

  Widget makeauthmethodwidget() {
    if (authmethod == "인증샷") {
      return makeauthpickture();
    } else {
      return Container();
    }
  }

  authpicktuer() async {
    FcubeQuestAuthPicture reqcontent = FcubeQuestAuthPicture();
    reqcontent.authpicture = authimages;
    reqcontent.authtext = authtextcontroller.text;
    reqitem.fromuid = GolobalStateContainer.of(context).state.userInfoMain.uid;
    reqitem.contenttype = "FcubeQuestAuthPicture";
    reqitem.content = reqcontent.toRawJson();
    if (await reqitem.requestFcubeQuestSuccess() > 0) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return FcubeQuestCompleteReqSend1(
            pickreqcontent: reqcontent, detailcontent: detailcontent);
      }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          RaisedButton(
            child: Text("제출하기"),
            onPressed: () async {
              if (authmethod == "인증샷") {
                authpicktuer();
              }
            },
          )
        ],
      ),
      body: Container(child: makeauthmethodwidget()),
    );
  }
}
