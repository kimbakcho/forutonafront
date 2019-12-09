import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/Auth/UserInfoMain.dart';
import 'package:forutonafront/MakePage/Component/QuestCube/FcubeQuest.dart';
import 'package:forutonafront/MakePage/Component/QuestCube/FcubeQuestCompleteReqSend.dart';
import 'package:forutonafront/MakePage/Component/QuestCube/FcubeQuestDetailPage.dart';
import 'package:forutonafront/MakePage/Fcubecontent.dart';
import 'package:forutonafront/PlayPage/QuestCube/FcubeQuestSuccess.dart';
import 'package:forutonafront/PlayPage/QuestCube/FcubeQuestSuccessExtender1.dart';
import 'package:forutonafront/globals.dart';
import 'package:intl/intl.dart';

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
  bool isloading = false;
  FirebaseUser _currentuser;
  List<FcubeQuestSuccessExtender1> reqitems =
      List<FcubeQuestSuccessExtender1>();
  Iterable<FcubeQuestSuccessExtender1> notcheck;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  init() async {
    isloading = true;
    setState(() {});
    _currentuser = await FirebaseAuth.instance.currentUser();
    FcubeQuestSuccessExtender1 searchitem = FcubeQuestSuccessExtender1(
        cubeuuid: fcubequest.cubeuuid,
        uid: fcubequest.uid,
        fromuid: _currentuser.uid);
    reqitems = await FcubeQuestSuccessExtender1.getQuestReqList(searchitem);
    notcheck = reqitems.where((value) {
      return value.readingcheck == 0;
    });
    isloading = false;
    setState(() {});
  }

  FcubeJoinMode getjoinmode() {
    UserInfoMain userinfomain =
        GolobalStateContainer.of(context).state.userInfoMain;
    if (userinfomain.uid == fcubequest.uid) {
      return FcubeJoinMode.administrator;
    } else {
      return FcubeJoinMode.player;
    }
  }

  Widget makeActionbtn() {
    if (isloading) {
      return Container();
    } else {
      if (getjoinmode() == FcubeJoinMode.player) {
        return RaisedButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return FcubeQuestCompleteReqSend(
                  fcubequest: fcubequest, detailcontent: detailcontent);
            }));
          },
          child: Text("완료 요청"),
        );
      } else {
        return Container();
      }
    }
  }

  Widget makeAdminwidget() {
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment(-1, 0),
          child: Text("완료요청(${notcheck.length})"),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.8,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: reqitems.length,
            itemBuilder: (context, index) {
              if (reqitems[index].contenttype == "FcubeQuestAuthPicture") {
                return makeFcubeQuestAuthPicture(index);
              } else {
                return Container(
                  child: Text("??"),
                );
              }
            },
          ),
        )
      ],
    );
  }

  Widget makeFcubeQuestAuthPicture(int index) {
    FcubeQuestSuccessExtender1 item = reqitems[index];
    FcubeQuestAuthPicture content =
        FcubeQuestAuthPicture.fromRawJson(item.content);
    return Card(
      margin: EdgeInsets.all(20),
      elevation: 10,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              CircleAvatar(
                backgroundImage: NetworkImage(item.profilepicktureurl),
                maxRadius: 20,
              ),
              Expanded(
                  child: Column(
                children: <Widget>[
                  Text(item.nickname),
                  Text("${item.userlevel}")
                ],
              ))
            ],
          ),
          Divider(
            color: Colors.black,
          ),
          Container(
            alignment: Alignment(1, 0),
            child: Text(
                "${DateFormat("yyyy-MM-dd HH:mm:ss").format(item.reqtime.add(Duration(hours: 9)))}"),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: content.authpicture.length,
            itemBuilder: (context, index) {
              if (content.authpicture[index] != "") {
                return Container(
                  child: Image(
                    height: 100,
                    image: NetworkImage(content.authpicture[index]),
                  ),
                );
              } else {
                return Container();
              }
            },
          ),
          Container(
            child: Text(content.authtext),
          ),
          Row(
            children: <Widget>[
              Expanded(
                  child: Container(
                margin: EdgeInsets.all(10),
                child: RaisedButton(
                  onPressed: () async {
                    item.readingcheck = 1;
                    item.scuesscheck = 1;
                    await item.updateQuestReq();
                  },
                  child: Text("퀘스트 성공"),
                ),
              )),
              Expanded(
                  child: Container(
                margin: EdgeInsets.all(10),
                child: RaisedButton(
                  onPressed: () async {
                    item.readingcheck = 1;
                    item.scuesscheck = 0;
                    await item.updateQuestReq();
                  },
                  child: Text("퀘스트 실패"),
                ),
              )),
            ],
          )
        ],
      ),
    );
  }

  Widget makebodywidget() {
    if (isloading) {
      return CircularProgressIndicator();
    } else {
      if (getjoinmode() == FcubeJoinMode.player) {
        return Container();
      } else {
        return makeAdminwidget();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[makeActionbtn()],
      ),
      body: Container(
        child: makebodywidget(),
      ),
    );
  }
}
