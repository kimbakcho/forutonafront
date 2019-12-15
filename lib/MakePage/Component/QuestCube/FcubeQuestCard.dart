import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:forutonafront/MakePage/Component/CubeMakeRichTextEdit.dart';
import 'package:forutonafront/MakePage/Component/QuestCube/FcubeQuest.dart';
import 'package:forutonafront/MakePage/Component/QuestCube/FcubeQuestDetailPage.dart';
import 'package:forutonafront/MakePage/Fcubecontent.dart';
import 'package:forutonafront/PlayPage/Fcubeplayercontent.dart';
import 'package:forutonafront/PlayPage/FcubeplayercontentExtender1.dart';
import 'package:forutonafront/PlayPage/QuestCube/FcubeQuestSuccessCheck.dart';
import 'package:forutonafront/PlayPage/QuestCube/FcubeQuestSuccessExtender1.dart';
import 'package:forutonafront/globals.dart';
import 'package:geolocator/geolocator.dart';
import 'package:great_circle_distance2/great_circle_distance2.dart';
import 'package:zefyr/zefyr.dart';

class FcubeQuestStartCubeDialog extends StatefulWidget {
  final Fcubecontent startCubecontent;
  FcubeQuestStartCubeDialog({Key key, @required this.startCubecontent})
      : super(key: key);

  @override
  _FcubeQuestStartCubeDialogState createState() {
    return _FcubeQuestStartCubeDialogState(this.startCubecontent);
  }
}

class _FcubeQuestStartCubeDialogState extends State<FcubeQuestStartCubeDialog> {
  Fcubecontent startCubecontent;
  _FcubeQuestStartCubeDialogState(this.startCubecontent);

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 5,
        child: Container(
            height: MediaQuery.of(context).size.height * 0.5,
            child: Column(children: <Widget>[
              Container(
                child: Image(
                  image: AssetImage(StartCubeLocation.cubeimagepath),
                  height: 150,
                  width: 150,
                ),
              ),
              Container(
                child: Text("스타팅 큐브"),
              ),
              Container(
                child: Text("스타팅 큐브 설명"),
              ),
              Container(
                  child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.close),
              )),
            ])));
  }
}

class FcubeQuestFinishcubeDialog extends StatefulWidget {
  final Fcubecontent finishCubecontent;
  FcubeQuestFinishcubeDialog({Key key, @required this.finishCubecontent})
      : super(key: key);

  @override
  _FcubeQuestFinishcubeDialogState createState() {
    return _FcubeQuestFinishcubeDialogState(this.finishCubecontent);
  }
}

class _FcubeQuestFinishcubeDialogState
    extends State<FcubeQuestFinishcubeDialog> {
  Fcubecontent finishCubecontent;
  _FcubeQuestFinishcubeDialogState(this.finishCubecontent);
  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 5,
        child: Container(
            height: MediaQuery.of(context).size.height * 0.5,
            child: Column(children: <Widget>[
              Container(
                child: Image(
                  image: AssetImage(FinishCubeLocation.cubeimagepath),
                  height: 150,
                  width: 150,
                ),
              ),
              Container(
                child: Text("피니싱 큐브"),
              ),
              Container(
                child: Text("피니싱 큐브 설명"),
              ),
              Container(
                  child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.close),
              )),
            ])));
  }
}

class FcubeQuestMesssagecubeDialog extends StatefulWidget {
  final String messageCubecontent;
  FcubeQuestMesssagecubeDialog({Key key, @required this.messageCubecontent})
      : super(key: key);

  @override
  _FcubeQuestMesssagecubeDialogState createState() {
    return _FcubeQuestMesssagecubeDialogState(this.messageCubecontent);
  }
}

class _FcubeQuestMesssagecubeDialogState
    extends State<FcubeQuestMesssagecubeDialog> {
  _FcubeQuestMesssagecubeDialogState(this.messageCubecontent);
  String messageCubecontent;
  CubeMakeRichTextEdit richtextview;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    richtextview = CubeMakeRichTextEdit(
      custommode: "nomal",
      jsondata: messageCubecontent,
      zefyrMode: ZefyrMode.view,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 5,
        child: Container(
            height: MediaQuery.of(context).size.height * 0.5,
            child: Column(children: <Widget>[
              Container(
                child: Image(
                  image: AssetImage(MessageCubeLocation.cubeimagepath),
                  height: 150,
                  width: 150,
                ),
              ),
              Container(
                child: Text("메세지 큐브"),
              ),
              Container(
                child: Text("메시지 큐브 설명"),
              ),
              Container(
                  child: Row(
                children: <Widget>[
                  IconButton(
                    onPressed: () async {
                      int result = await showDialog(
                          context: (context),
                          barrierDismissible: false,
                          builder: (context) {
                            return Dialog(
                                child: Container(
                              height: MediaQuery.of(context).size.height * 0.5,
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.4,
                                    child: richtextview,
                                  ),
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.1,
                                    child: Row(
                                      children: <Widget>[
                                        IconButton(
                                          icon: Icon(Icons.undo),
                                          onPressed: () {
                                            Navigator.pop(context, 0);
                                          },
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.close),
                                          onPressed: () {
                                            Navigator.pop(context, 1);
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ));
                          });
                      if (result == 1) {
                        Navigator.pop(context);
                      }
                    },
                    icon: Icon(Icons.library_books),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.close),
                  )
                ],
              )),
            ])));
  }
}

class FcubeQuestCheckincubeDialog extends StatefulWidget {
  FcubeQuestCheckincubeDialog(
      {Key key,
      @required this.checkinCubecontent,
      @required this.fcubequest,
      @required this.joinmode,
      this.playerdetailcontent,
      this.currentScaffoldState})
      : super(key: key);
  final FcubeQuest fcubequest;
  final CheckinCubeLocation checkinCubecontent;
  final List<FcubeplayercontentExtender1> playerdetailcontent;
  final FcubeJoinMode joinmode;
  final ScaffoldState currentScaffoldState;

  @override
  _FcubeQuestCheckincubeDialogState createState() {
    return _FcubeQuestCheckincubeDialogState(
        this.checkinCubecontent, this.fcubequest, this.joinmode,
        playerdetailcontent: this.playerdetailcontent,
        currentScaffoldState: currentScaffoldState);
  }
}

class _FcubeQuestCheckincubeDialogState
    extends State<FcubeQuestCheckincubeDialog> {
  _FcubeQuestCheckincubeDialogState(
      this.checkinCubecontent, this.fcubequest, this.joinmode,
      {this.playerdetailcontent, this.currentScaffoldState});
  FcubeQuest fcubequest;
  CheckinCubeLocation checkinCubecontent;
  CubeMakeRichTextEdit richtextview;
  List<FcubeplayercontentExtender1> playerdetailcontent;
  FcubeJoinMode joinmode;
  FcubeplayercontentExtender1 findcheckin;
  ScaffoldState currentScaffoldState;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    richtextview = CubeMakeRichTextEdit(
      custommode: "nomal",
      jsondata: checkinCubecontent.message,
      zefyrMode: ZefyrMode.view,
    );
    if (joinmode == FcubeJoinMode.administrator) {
    } else {
      int findindex = playerdetailcontent.indexWhere((value) {
        if (value.contenttype ==
            FcubeplayercontentType.checkInCubeLocationCheckin) {
          var temp = CheckInCubeLocationCheckin.fromJson(
              json.decode(value.contentvalue));
          if (temp.cubeid == checkinCubecontent.cubeid) {
            return true;
          } else {
            return false;
          }
        } else {
          return false;
        }
      });
      if (findindex >= 0) {
        findcheckin = playerdetailcontent[findindex];
      }
    }
  }

  Widget makeexcutebtn() {
    if (joinmode == FcubeJoinMode.player) {
      if (findcheckin == null) {
        return IconButton(
            icon: Icon(Icons.location_on),
            onPressed: () async {
              Position currentposition =
                  GolobalStateContainer.of(context).state.currentposition;
              double checkindistance = GreatCircleDistance.fromDegrees(
                      latitude1: checkinCubecontent.latitude,
                      longitude1: checkinCubecontent.longitude,
                      latitude2: currentposition.latitude,
                      longitude2: currentposition.longitude)
                  .haversineDistance();
              if (checkindistance > 5) {
                print("checkflase");
                final snackBar = SnackBar(
                  content: Text("Checkin은 5M 이내에 있어야 합니다."),
                  duration: Duration(milliseconds: 1000),
                );
                currentScaffoldState.showSnackBar(snackBar);
              } else {
                var tempitem = CheckInCubeLocationCheckin(
                    latitude: currentposition.latitude,
                    longitude: currentposition.longitude,
                    cubeid: checkinCubecontent.cubeid,
                    checkintime: DateTime.now().toUtc());
                FcubeplayercontentExtender1 makeitem =
                    FcubeplayercontentExtender1(
                        contenttype:
                            FcubeplayercontentType.checkInCubeLocationCheckin,
                        contentupdatetime: DateTime.now().toUtc(),
                        contentvalue: json.encode(tempitem.toJson()),
                        cubeuuid: fcubequest.cubeuuid,
                        uid: GolobalStateContainer.of(context)
                            .state
                            .userInfoMain
                            .uid);
                if (await makeitem.makeFcubeplayercontent() > 0) {
                  playerdetailcontent.add(makeitem);
                }
                findcheckin = makeitem;
                setState(() {});
                print("checkIn");
              }
            });
      }
    }
    return IconButton(
      onPressed: () async {
        int result = await showDialog(
            context: (context),
            barrierDismissible: false,
            builder: (context) {
              return Dialog(
                  child: Container(
                height: MediaQuery.of(context).size.height * 0.5,
                child: Column(
                  children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.height * 0.4,
                      child: richtextview,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.1,
                      child: Row(
                        children: <Widget>[
                          IconButton(
                            icon: Icon(Icons.undo),
                            onPressed: () {
                              Navigator.pop(context, 0);
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.close),
                            onPressed: () {
                              Navigator.pop(context, 1);
                            },
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ));
            });
        if (result == 1) {
          Navigator.pop(context);
        }
      },
      icon: Icon(Icons.library_books),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 5,
        child: Container(
            height: MediaQuery.of(context).size.height * 0.5,
            child: Column(children: <Widget>[
              Container(
                child: Image(
                  image: AssetImage(CheckinCubeLocation.cubeimagepath),
                  height: 150,
                  width: 150,
                ),
              ),
              Container(
                child: Text("체크인 큐브"),
              ),
              Container(
                child: Text("체크인 큐브 설명"),
              ),
              Container(
                  child: Row(
                children: <Widget>[
                  makeexcutebtn(),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.close),
                  )
                ],
              )),
            ])));
  }
}

class FcubeQuestAuthChcekCard extends StatefulWidget {
  final FcubeQuestSuccessExtender1 item;
  final FcubeQuest fcubequest;
  FcubeQuestAuthChcekCard({Key key, this.fcubequest, this.item})
      : super(key: key);

  @override
  _FcubeQuestAuthChcekCardState createState() =>
      _FcubeQuestAuthChcekCardState(fcubequest: fcubequest, item: item);
}

class _FcubeQuestAuthChcekCardState extends State<FcubeQuestAuthChcekCard> {
  FcubeQuestSuccessExtender1 item;
  FcubeQuest fcubequest;
  _FcubeQuestAuthChcekCardState({this.fcubequest, this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      width: 250,
      child: Column(
        children: <Widget>[
          item.scuesscheck == 0 ? Text("퀘스트 완료 실패") : Text("퀘스트 완료 성공"),
          SizedBox(
            height: 30,
          ),
          Container(
              child: SizedBox(
            height: 80,
            width: 80,
            child: Placeholder(
              fallbackHeight: 80,
              fallbackWidth: 80,
            ),
          )),
          Container(
              child: item.scuesscheck == 0
                  ? Text("${item.nickname} 님이 퀘스트를 완료 실패 하였습니다. ")
                  : Text("${item.nickname} 님이 퀘스트를 완료 성공 하였습니다. ")),
          Container(
            child: RaisedButton(
              onPressed: () async {
                String uid =
                    GolobalStateContainer.of(context).state.userInfoMain.uid;
                FcubeQuestSuccessCheck checkitem = FcubeQuestSuccessCheck(
                    confirm: 1,
                    cubeuuid: item.cubeuuid,
                    fromuid: item.fromuid,
                    uid: item.uid,
                    readuid: uid);
                await checkitem.insertFcubeQuestSuccessCheck();
                Navigator.pop(context, 0);
              },
              child: Text("확인"),
            ),
          )
        ],
      ),
    );
  }
}
