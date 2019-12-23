import 'package:after_init/after_init.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/MakePage/Component/QuestCube/FcubeQuest.dart';
import 'package:forutonafront/PlayPage/QuestCube/FcubeQuestSuccessExtender1.dart';
import 'package:forutonafront/globals.dart';
import 'package:intl/intl.dart';

class FcubeQuestResultView extends StatefulWidget {
  final FcubeQuest fcubequest;
  FcubeQuestResultView({Key key, this.fcubequest}) : super(key: key);

  @override
  _FcubeQuestResultViewState createState() {
    return _FcubeQuestResultViewState(fcubequest: this.fcubequest);
  }
}

class _FcubeQuestResultViewState extends State<FcubeQuestResultView>
    with SingleTickerProviderStateMixin, AfterInitMixin<FcubeQuestResultView> {
  FcubeQuest fcubequest;
  _FcubeQuestResultViewState({this.fcubequest});
  TabController _tabController;
  List<FcubeQuestSuccessExtender1> questreqlist =
      List<FcubeQuestSuccessExtender1>();
  List<FcubeQuestSuccessExtender1> sucessreqlist =
      List<FcubeQuestSuccessExtender1>();
  List<FcubeQuestSuccessExtender1> failreqlist =
      List<FcubeQuestSuccessExtender1>();
  bool isloading = false;
  String questsucesstxt;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  void didInitState() async {
    setState(() {
      isloading = true;
    });

    String uid = GlobalStateContainer.of(context).state.userInfoMain.uid;
    FcubeQuestSuccessExtender1 finditem = FcubeQuestSuccessExtender1(
      cubeuuid: fcubequest.cubeuuid,
      uid: fcubequest.uid,
      fromuid: uid,
    );

    questreqlist = await FcubeQuestSuccessExtender1.getQuestReqList(finditem);
    sucessreqlist = questreqlist.where((value) {
      return value.scuesscheck == 1;
    }).toList();
    failreqlist = questreqlist.where((value) {
      return value.scuesscheck == 0;
    }).toList();

    setState(() {
      isloading = false;
    });
  }

  List<Widget> makeSucessMessage() {
    List<Widget> widgetlist = List<Widget>();
    sucessreqlist.forEach((value) {
      DateTime judgmenttime = DateTime.parse(value.judgmenttime);
      judgmenttime = judgmenttime.add(Duration(hours: 9));
      widgetlist.add(Card(
        margin: EdgeInsets.all(10),
        elevation: 10,
        child: Container(
            child: Row(children: <Widget>[
          CircleAvatar(
            backgroundImage: NetworkImage(value.profilepicktureurl),
            maxRadius: 20,
          ),
          Expanded(
              child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  child: Text(value.nickname),
                ),
                Container(
                  child: Text(value.toplayercomment),
                ),
                Container(
                  child: Text(
                      DateFormat("yyyy-MM-dd HH:mm:ss").format(judgmenttime)),
                )
              ],
            ),
          ))
        ])),
      ));
    });
    return widgetlist;
  }

  List<Widget> makeSucessAvater() {
    List<Widget> widgetlist = List<Widget>();
    sucessreqlist.forEach((value) {
      widgetlist.add(Card(
          margin: EdgeInsets.all(10),
          elevation: 10,
          child: Container(
              child: Column(children: <Widget>[
            Container(
              child: CircleAvatar(
                backgroundImage: NetworkImage(value.profilepicktureurl),
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              Text("nickname = " + value.nickname + "    "),
              Text("userlevel =  ${value.userlevel}")
            ])
          ]))));
    });
    return widgetlist;
  }

  List<Widget> makeFailUserList() {
    List<Widget> widgetlist = List<Widget>();
    failreqlist.forEach((value) {
      widgetlist.add(Card(
          margin: EdgeInsets.all(10),
          elevation: 10,
          child: Container(
              child: Column(children: <Widget>[
            Container(
              child: CircleAvatar(
                backgroundImage: NetworkImage(value.profilepicktureurl),
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              Text("nickname = " + value.nickname + "    "),
              Text("userlevel =  ${value.userlevel}")
            ])
          ]))));
    });
    return widgetlist;
  }

  @override
  Widget build(BuildContext context) {
    if (sucessreqlist.length > 0) {
      questsucesstxt = "퀘스트 성공";
    } else {
      questsucesstxt = "퀘스트 실패";
    }
    return Scaffold(
        appBar: AppBar(),
        body: isloading
            ? CircularProgressIndicator()
            : Container(
                child: Column(children: <Widget>[
                TabBar(controller: _tabController, tabs: <Widget>[
                  Text("플레이어 성적"),
                  Text("메이커 성적"),
                ]),
                Expanded(
                    child: TabBarView(
                  controller: _tabController,
                  children: <Widget>[
                    ListView(children: <Widget>[
                      //tab1
                      Container(
                          alignment: Alignment(0, 0),
                          decoration: BoxDecoration(
                              border:
                                  Border.all(width: 1, color: Colors.black)),
                          child: Text("${questsucesstxt}")),
                      Column(children: makeSucessMessage()),
                      Container(
                          child: Column(children: <Widget>[
                        Card(
                            margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                            elevation: 10,
                            child: Container(
                              child: Text("퀘스트를 완료한 플레이어"),
                            )),
                        Container(
                            child: Column(
                          children: makeSucessAvater(),
                        ))
                      ])),
                      Container(
                        alignment: Alignment(0, 0),
                        child: Text("퀘스트를 완료하지 못한 플레이어"),
                      ),
                      Column(
                        children: makeFailUserList(),
                      )
                    ]),
                    //tab2
                    ListView(
                      children: <Widget>[],
                    )
                  ],
                ))
              ])));
  }
}
