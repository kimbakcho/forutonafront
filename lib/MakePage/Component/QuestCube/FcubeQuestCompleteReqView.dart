import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/Auth/UserInfoMain.dart';
import 'package:forutonafront/MakePage/Component/QuestCube/FcubeQuest.dart';
import 'package:forutonafront/MakePage/Component/QuestCube/FcubeQuestCard.dart';
import 'package:forutonafront/MakePage/Component/QuestCube/FcubeQuestCompleteReqSend.dart';
import 'package:forutonafront/MakePage/Component/QuestCube/FcubeQuestCompleteReqSend2.dart';
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
  GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
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
    if (getjoinmode() == FcubeJoinMode.administrator) {
      FcubeQuestSuccessExtender1 searchitem = FcubeQuestSuccessExtender1(
          cubeuuid: fcubequest.cubeuuid,
          uid: fcubequest.uid,
          fromuid: _currentuser.uid,
          readingcheck: 0);
      reqitems = await FcubeQuestSuccessExtender1.getQuestReqList(searchitem);
    } else {
      FcubeQuestSuccessExtender1 searchitem = FcubeQuestSuccessExtender1(
          cubeuuid: fcubequest.cubeuuid, readuid: _currentuser.uid);
      reqitems = await FcubeQuestSuccessExtender1.getPlayerQuestSuccessList(
          searchitem);
    }

    isloading = false;
    setState(() {});
  }

  FcubeJoinMode getjoinmode() {
    if (_currentuser.uid == fcubequest.uid) {
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
          child: Text("완료요청(${reqitems.length})"),
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
                    int reslut = await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: Container(
                              height: 100,
                              child: Column(
                                children: <Widget>[
                                  Text("정말로 퀘스트를 성공 하였나요?"),
                                  Text("(성공을 선택하면 퀘스트 결과 페이지로 이동합니다.)"),
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              FlatButton(
                                child: Text("취소"),
                                onPressed: () {
                                  Navigator.pop(context, 0);
                                },
                              ),
                              FlatButton(
                                child: Text("성공"),
                                onPressed: () {
                                  Navigator.pop(context, 1);
                                },
                              )
                            ],
                          );
                        });
                    if (reslut == 1) {
                      item.readingcheck = 1;
                      item.scuesscheck = 1;
                      int updateresult = await item.updateQuestReq();
                      if (updateresult == 1) {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return FcubeQuestCompleteReqSend2(
                            fcubequest: fcubequest,
                            item: item,
                          );
                        }));
                      } else if (updateresult == 2) {
                        item.scuesscheck = 0;
                        _scaffoldkey.currentState.showSnackBar(SnackBar(
                          content: Text(
                              "Single 성공 모드에서 이미 성공한 유저가 있습니다. \n 해당 퀘스트는 실패 처리 됩니다."),
                        ));
                      }
                      reqitems.removeWhere((value) {
                        return value.fromuid == item.fromuid;
                      });
                      setState(() {});
                    }
                  },
                  child: Text("퀘스트 성공"),
                ),
              )),
              Expanded(
                  child: Container(
                margin: EdgeInsets.all(10),
                child: RaisedButton(
                  onPressed: () async {
                    int result = await showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: Container(
                              height: 100,
                              child: Column(
                                children: <Widget>[Text("정말로 퀘스트를 실패 하였나요?")],
                              ),
                            ),
                            actions: <Widget>[
                              FlatButton(
                                child: Text("취소"),
                                onPressed: () {
                                  Navigator.pop(context, 0);
                                },
                              ),
                              FlatButton(
                                child: Text("실패"),
                                onPressed: () {
                                  Navigator.pop(context, 1);
                                },
                              )
                            ],
                          );
                        });
                    if (result == 1) {
                      item.readingcheck = 1;
                      item.scuesscheck = 0;
                      await item.updateQuestReq();
                      reqitems.removeWhere((value) {
                        return value.fromuid == item.fromuid;
                      });
                      setState(() {});
                    }
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

  makeplayerwidget() {
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment(-1, 0),
          child: Text("완료요청(${reqitems.length})"),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.8,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: reqitems.length,
            itemBuilder: (context, index) {
              if (reqitems[index].contenttype == "FcubeQuestAuthPicture") {
                return makeFcubeQuestPlayerAuthPicture(index);
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

  Widget makeFcubeQuestPlayerAuthPicture(int index) {
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
            physics: NeverScrollableScrollPhysics(),
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
          Container(
            margin: EdgeInsets.all(10),
            child: RaisedButton(
              onPressed: () async {
                await showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                          elevation: 10,
                          content: FcubeQuestAuthChcekCard(
                              fcubequest: fcubequest, item: item));
                    });
                this.reqitems.remove(item);
                setState(() {});
              },
              child: Text("결과 확인"),
            ),
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
        return makeplayerwidget();
      } else {
        return makeAdminwidget();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        actions: <Widget>[makeActionbtn()],
      ),
      body: Container(
        child: makebodywidget(),
      ),
    );
  }
}
