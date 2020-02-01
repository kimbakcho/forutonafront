import 'dart:async';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:forutonafront/Common/FcubeAuthMethodType.dart';
import 'package:forutonafront/Common/FcubeReview.dart';
import 'package:forutonafront/Common/Fcubeplayer.dart';
import 'package:forutonafront/Common/FcubeplayerExtender1.dart';
import 'package:forutonafront/Common/Fcubereply.dart';
import 'package:forutonafront/Common/FcubereplyExtender1.dart';
import 'package:forutonafront/MakePage/Component/CubeMakeRichTextEdit.dart';
import 'package:forutonafront/MakePage/Component/Fcube.dart';
import 'package:forutonafront/MakePage/Component/FcubeExtender1.dart';
import 'package:forutonafront/MakePage/Component/QuestCube/FcubeQuest.dart';
import 'package:forutonafront/MakePage/Component/QuestCube/FcubeQuestBottomNaviBar.dart';
import 'package:forutonafront/MakePage/Component/QuestCube/FcubeQuestCard.dart';
import 'package:forutonafront/MakePage/Component/QuestCube/FcubeQuestResultView.dart';
import 'package:forutonafront/MakePage/Component/QuestCube/QuestAdministratorPage.dart';
import 'package:forutonafront/MakePage/Fcubecontent.dart';
import 'package:forutonafront/Preference.dart';
import 'package:forutonafront/globals.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:intl/intl.dart';
import 'package:zefyr/zefyr.dart';

//Paly와Maker는 같은 객체를 공유 업데이트 보안 정보 체크는 BackEnd 에서 JWT로 탄탄히
class FcubeQuestDetailPage extends StatefulWidget {
  final FcubeExtender1 fcubeextender1;
  FcubeQuestDetailPage({Key key, this.fcubeextender1}) : super(key: key);

  @override
  _FcubeQuestDetailPageState createState() {
    return _FcubeQuestDetailPageState(fcubeextender1: fcubeextender1);
  }
}

enum FcubeJoinMode { administrator, player }
enum UpPanelMode { startedit, settingedit }

class _FcubeQuestDetailPageState extends State<FcubeQuestDetailPage>
    with SingleTickerProviderStateMixin {
  FcubeExtender1 fcubeextender1;
  _FcubeQuestDetailPageState({this.fcubeextender1});
  double currentdistancediff = 0;
  bool isloading = false;
  FcubeQuest fcubequest;
  Map<FcubecontentType, Fcubecontent> contents;
  var geolocator = Geolocator();
  var locationOptions =
      LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);
  Position currentposition;
  CameraPosition initialCameraPosition;
  ScrollController listviewcontroller = ScrollController();
  Set<Marker> makres = new Set<Marker>();
  bool isscrolling = false;
  TabController tabController;
  Timer acttimetimer;
  TextEditingController replycontroller = new TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  List<FcubereplyExtender1> replyExtenderlist = List<FcubereplyExtender1>();
  CubeMakeRichTextEdit richtextview;
  bool isSlidingUpPanelDrag = false;
  PanelController panelcontroller = new PanelController();
  bool ispanelopen = false;
  DateTime selectfinishtime;
  FirebaseUser _currentuser;
  List<FcubeplayerExtender1> myfcubs;
  List<FcubeplayerExtender1> joinplayer;
  Fcubeplayer playerme;
  static const MethodChannel platform =
      MethodChannel('com.wing.forutonafront/service');
  UpPanelMode currentupPanelmode = UpPanelMode.startedit;
  bool isjoininsertbtnloading = false;
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  Fcubeplayer findjoinplayer;
  GlobalKey _richtextkey = GlobalKey();
  GlobalKey _replykey = GlobalKey();
  double richtextheightsize = 0;
  double replysize = 0;
  Duration avtibetime = Duration();

  @override
  void initState() {
    super.initState();

    tabController = TabController(length: 3, vsync: this);
    fcubequest = FcubeQuest.fromFcubeExtender1(fcubeextender1);
    fcubequest.cubeimage = "assets/MarkesImages/QuestCube.png";
    listviewcontroller.addListener(() async {
      heidBottomNavi();
    });
    init();
  }

  init() async {
    initialCameraPosition = new CameraPosition(
        target: LatLng(fcubequest.latitude, fcubequest.longitude), zoom: 16);
    isloading = true;
    await fcubequest.getwithupdatecubestate();
    avtibetime =
        fcubequest.activationtime.toUtc().difference(DateTime.now().toUtc());
    if (avtibetime.inSeconds < 0) {
      fcubequest.cubestate = FcubeState.finish;
    }

    _currentuser = await FirebaseAuth.instance.currentUser();
    setState(() {});
    this.contents = await initFcubeQuest();
    initgeolocation();

    Fcubeplayer player =
        new Fcubeplayer(cubeuuid: fcubequest.cubeuuid, uid: _currentuser.uid);
    myfcubs = await FcubeplayerExtender1.selectPlayers(player);
    findjoinplayer = new Fcubeplayer(cubeuuid: fcubequest.cubeuuid);
    joinplayer = await FcubeplayerExtender1.selectPlayers(findjoinplayer);
    isloading = false;
    setState(() {});
    acttimetimer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {});
    });
    initreply();
    richtextview = CubeMakeRichTextEdit(
      custommode: "nomal",
      customscrollmode: "noscroll",
      jsondata:
          jsonDecode(this.contents[FcubecontentType.description].contentvalue)[
              "description"],
      zefyrMode: ZefyrMode.view,
    );
  }

  void initreply() async {
    replyExtenderlist = await FcubereplyExtender1.selectStep1ForReply(
        fcubequest.cubeuuid, 0, 0);
    setState(() {});
  }

  FcubeJoinMode getjoinmode() {
    if (_currentuser == null) {
      return FcubeJoinMode.player;
    } else {
      if (_currentuser.uid == fcubequest.uid) {
        return FcubeJoinMode.administrator;
      } else {
        return FcubeJoinMode.player;
      }
    }
  }

  Widget makePlaymodebtn() {
    FcubeJoinMode mode = getjoinmode();
    if (mode == FcubeJoinMode.administrator) {
      return RaisedButton(
        onPressed: () async {
          await Navigator.push(
              context,
              MaterialPageRoute(
                  settings: RouteSettings(name: "QuestAdministratorPage"),
                  builder: (context) {
                    return QuestAdministratorPage(fcubequest: fcubequest);
                  }));
          await fcubequest.getwithupdatecubestate();
        },
        child: Text("관리자 모드"),
      );
    } else if (mode == FcubeJoinMode.player) {
      //myfcubs.length 참여자가 참가하지 않을때 검색할했을때 큐브가 0
      if (myfcubs.length == 0) {
        return RaisedButton(
          onPressed: () async {
            panelcontroller.open();
          },
          child: Text("참가 하기"),
        );
      } else {
        return RaisedButton(
          onPressed: () async {
            await Navigator.push(
                context,
                MaterialPageRoute(
                    settings: RouteSettings(name: "QuestAdministratorPage"),
                    builder: (context) {
                      return QuestAdministratorPage(fcubequest: fcubequest);
                    }));
            await fcubequest.getwithupdatecubestate();
            startservice();
          },
          child: Text("참가 했음"),
        );
      }
    } else {
      return Container();
    }
  }

  heidBottomNavi() async {
    if (!this.isscrolling) {
      this.isscrolling = true;
      setState(() {});
      await Future.delayed(Duration(seconds: 1));
      this.isscrolling = false;
      setState(() {});
    }
  }

  double replyheight() {
    double reslut = replyExtenderlist.length * 100.0;
    if (reslut >= 300) {
      reslut = 300;
    }
    return reslut;
  }

  Future<Map<FcubecontentType, Fcubecontent>> initFcubeQuest() async {
    Map<FcubecontentType, Fcubecontent> contents;
    await Future.delayed(Duration.zero, () async {
      String uid = GlobalStateContainer.of(context).state.userInfoMain.uid;
      List<FcubecontentType> types = List<FcubecontentType>();
      types.add(FcubecontentType.startCubeLocation);
      types.add(FcubecontentType.finishCubeLocation);
      types.add(FcubecontentType.description);
      types.add(FcubecontentType.messagecubeLocations);
      types.add(FcubecontentType.checkincubeLocations);
      types.add(FcubecontentType.authmethod);
      types.add(FcubecontentType.authPicturedescription);
      types.add(FcubecontentType.etcCubemode);
      contents = await Fcubecontent.getFcubecontent(FcubeContentSelector(
          cubeuuid: fcubequest.cubeuuid, uid: uid, contenttypes: types));
    });
    return contents;
  }

  initgeolocation() async {
    PermissionStatus permissition = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.location);
    if (permissition == PermissionStatus.granted) {
      currentposition = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

      currentdistancediff = await Geolocator().distanceBetween(
          currentposition.latitude,
          currentposition.longitude,
          fcubequest.latitude,
          fcubequest.longitude);
      currentdistancediff = currentdistancediff.roundToDouble();
      setState(() {});
      geolocator
          .getPositionStream(locationOptions)
          .listen((Position position) async {
        if (position == null) {
          currentposition = await Geolocator()
              .getLastKnownPosition(desiredAccuracy: LocationAccuracy.high);
          currentposition = position;
        } else {
          currentposition = position;
        }
        currentdistancediff = await Geolocator().distanceBetween(
            currentposition.latitude,
            currentposition.longitude,
            fcubequest.latitude,
            fcubequest.longitude);
        currentdistancediff = currentdistancediff.roundToDouble();
      });
    }
  }

  Widget makebottomNavi(FcubeState state) {
    switch (state) {
      case FcubeState.startWait:
        return Container(
          color: Color.fromARGB(125, 10, 10, 10),
          child: Container(
              height: 70,
              alignment: Alignment(1, 0),
              width: MediaQuery.of(context).size.width,
              child: Container(
                margin: EdgeInsets.only(right: 10),
                width: 100,
                height: 50,
                child: RaisedButton(
                  onPressed: () async {
                    currentupPanelmode = UpPanelMode.startedit;
                    setState(() {
                      panelcontroller.open();
                    });
                  },
                  child: Text("시작 준비"),
                ),
              )),
        );
        break;
      case FcubeState.play:
        DateTime activationtime =
            fcubequest.activationtime.add(Duration(hours: 9));

        avtibetime = activationtime
            .difference(DateTime.now().toUtc().add(Duration(hours: 9)));
        int actday = avtibetime.inSeconds ~/ (60 * 60 * 24);
        int acthour =
            (avtibetime.inSeconds - actday * 60 * 60 * 24) ~/ (60 * 60);
        int actmin =
            (avtibetime.inSeconds - actday * 60 * 60 * 24 - acthour * 3600) ~/
                (60);
        int actsec = avtibetime.inSeconds % 60;
        return Container(
            height: 70,
            alignment: Alignment(1, 0),
            width: MediaQuery.of(context).size.width,
            color: Color.fromARGB(125, 10, 10, 10),
            child: Container(
                height: 70,
                alignment: Alignment(1, 0),
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: <Widget>[
                    Container(
                      color: Colors.white,
                      child: Text("참가자 수"),
                    ),
                    SizedBox(
                      width: 50,
                    ),
                    Container(
                      color: Colors.white,
                      child: Text("$actday일 $acthour:$actmin:$actsec"),
                    ),
                    Expanded(
                        child: SizedBox(
                      width: 50,
                    )),
                    Container(child: makePlaymodebtn())
                  ],
                )));
        break;
      case FcubeState.finish:
        return Container(
          height: 70,
          width: MediaQuery.of(context).size.width,
          color: Color.fromARGB(125, 10, 10, 10),
          child: Row(children: <Widget>[
            Expanded(
              child: Text(
                  "${DateFormat("yyyy-MM-dd HH:mm:ss").format(fcubequest.activationtime.add(Duration(hours: 9)))}"),
            ),
            Container(
                width: 150,
                padding: EdgeInsets.all(10),
                child: RaisedButton(
                    child: Text("결과 확인"),
                    onPressed: () async {
                      if (getjoinmode() == FcubeJoinMode.player) {
                        String uid = GlobalStateContainer.of(context)
                            .state
                            .userInfoMain
                            .uid;
                        List<FcubeReview> reviews =
                            await FcubeReview.getFcubeReviews(
                                fcubequest.cubeuuid, uid);
                        if (reviews.length > 0) {
                          await Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return FcubeQuestResultView(fcubequest: fcubequest);
                          }));
                          fcubequest.cubestate = FcubeState.finish;
                        } else {
                          int result = await showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                    content: FcubeQuestReviewCard(
                                        fcubequest: fcubequest));
                              });
                          if (result == 1) {
                            await Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return FcubeQuestResultView(
                                  fcubequest: fcubequest);
                            }));
                            fcubequest.cubestate = FcubeState.finish;
                          }
                        }
                      } else {
                        await Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return FcubeQuestResultView(fcubequest: fcubequest);
                        }));
                        fcubequest.cubestate = FcubeState.finish;
                      }
                    }))
          ]),
        );
        break;
      default:
        return null;
    }
  }

  @override
  void dispose() {
    if (acttimetimer != null && acttimetimer.isActive) {
      acttimetimer.cancel();
    }
    super.dispose();
  }

  Widget makedetailcontent() {
    return Container(
        child: ListView(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: <Widget>[
        ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(fcubequest.profilepicktureurl),
          ),
          title: Text(fcubequest.cubename),
          subtitle: Text(DateFormat("yyyy-MM-dd HH:mm:ss").format(
              DateTime.parse(fcubequest.maketime).add(Duration(hours: 9)))),
        ),
        Divider(
          color: Colors.black,
        ),
        Container(
          key: _richtextkey,
          child: richtextview,
        ),
        Divider(
          color: Colors.black,
        ),
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Text("완료 조건"),
              ),
              Row(
                children: <Widget>[
                  Image(
                    image: AssetImage(fcubequest.cubeimage),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(jsonDecode(this
                            .contents[FcubecontentType.authmethod]
                            .contentvalue)["authmethod"]),
                        Text(jsonDecode(this
                            .contents[FcubecontentType.authmethod]
                            .contentvalue)["authmethod"])
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
        Divider(
          color: Colors.black,
        ),
        Container(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Text("보상 조건"),
            ),
            Row(
              children: <Widget>[
                Image(
                  height: 50,
                  image: AssetImage(fcubequest.cubeimage),
                ),
                Expanded(
                  child: Container(
                    child: Text("${fcubequest.influencereward}"),
                  ),
                )
              ],
            ),
            Row(
              children: <Widget>[
                Image(
                  height: 50,
                  image: AssetImage(fcubequest.cubeimage),
                ),
                Expanded(
                  child: Container(
                    child: Text("${fcubequest.pointreward}"),
                  ),
                )
              ],
            ),
            Divider(
              color: Colors.black,
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    child: Text("남은 시간"),
                  ),
                ),
                Container(
                  child: Text("${fcubequest.remindActiveTimetoString()}"),
                )
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    child: Text("참가 제한"),
                  ),
                ),
                Container(
                  child: Text("${fcubequest.haspassword == 0 ? "공개" : "비공개"}"),
                )
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    child: Text("박스 공개 범위"),
                  ),
                ),
                Container(
                  child: Text("${fcubequest.cubescope == 0 ? "공개" : "비공개"}"),
                )
              ],
            ),
            Divider(
              color: Colors.black,
              height: 2,
            ),
            Container(
              child: Column(
                children: <Widget>[
                  Container(
                    child: Text("영향력"),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          child: Column(
                            children: <Widget>[
                              Container(
                                child: Text("영향력 레벨"),
                              ),
                              Container(
                                child: Text("${fcubequest.influencelevel}"),
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                          child: Container(
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: Text("조회수"),
                            ),
                            Container(
                              child: Text("${fcubequest.cubehits}"),
                            )
                          ],
                        ),
                      )),
                      Expanded(
                          child: Container(
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: Text("좋아요 수"),
                            ),
                            Container(
                              child: Text("${fcubequest.cubelikes}"),
                            )
                          ],
                        ),
                      )),
                      Expanded(
                          child: Container(
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: Text("싫어요 수"),
                            ),
                            Container(
                              child: Text("${fcubequest.cubedislikes}"),
                            )
                          ],
                        ),
                      ))
                    ],
                  )
                ],
              ),
            )
          ],
        )),
        Container(
            padding: EdgeInsets.all(10),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Form(
                    child: TextFormField(
                        controller: replycontroller,
                        maxLines: 2,
                        decoration: InputDecoration(hintText: "댓글 달기")),
                  ),
                ),
                Container(
                  child: RaisedButton(
                    child: Text("댓글"),
                    onPressed: () async {
                      FirebaseUser user = await _auth.currentUser();
                      Fcubereply reply = Fcubereply(
                          commnttext: replycontroller.text,
                          cubeuuid: fcubequest.cubeuuid,
                          uid: user.uid,
                          bgroup: 0,
                          depth: 0,
                          commnttime: DateTime.now(),
                          sorts: 0);
                      Fcubereply result = await reply.makereply();
                      if (result != null) {
                        replycontroller.clear();
                        FcubereplyExtender1 replyitem =
                            FcubereplyExtender1.fromFcubereply(result,
                                nickname: GlobalStateContainer.of(context)
                                    .state
                                    .userInfoMain
                                    .nickname,
                                profilepicktureurl:
                                    GlobalStateContainer.of(context)
                                        .state
                                        .userInfoMain
                                        .profilepicktureurl);
                        replyExtenderlist.add(replyitem);
                      } else {
                        print("댓글 실패");
                      }
                    },
                  ),
                ),
              ],
            )),
        Container(
            key: _replykey,
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: replyExtenderlist.length,
              itemBuilder: (context, index) {
                return Container(
                    margin: EdgeInsets.only(
                        left: replyExtenderlist[index].depth > 0 ? 70 : 0),
                    child: Row(
                      children: <Widget>[
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                              replyExtenderlist[index].profilepicktureurl),
                        ),
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child:
                                        Text(replyExtenderlist[index].nickname),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.dashboard,
                                      size: 20,
                                    ),
                                    onPressed: () {},
                                  )
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Text(
                                        replyExtenderlist[index].commnttext),
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Text(
                                        DateFormat("yyyy-MM-dd HH:mm:ss")
                                            .format(replyExtenderlist[index]
                                                .commnttime
                                                .toUtc()
                                                .add(Duration(hours: 9)))),
                                  ),
                                  FlatButton(
                                    onPressed: () async {
                                      var response = await showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return replyDialog();
                                          });
                                      if (response != null) {
                                        FirebaseUser user =
                                            await _auth.currentUser();
                                        Fcubereply reply = new Fcubereply(
                                            bgroup:
                                                replyExtenderlist[index].bgroup,
                                            commnttext: response,
                                            cubeuuid: replyExtenderlist[index]
                                                .cubeuuid,
                                            depth: 1,
                                            uid: user.uid,
                                            commnttime: DateTime.now());
                                        FcubereplyExtender1 rereply =
                                            FcubereplyExtender1.fromFcubereply(
                                                reply,
                                                nickname:
                                                    GlobalStateContainer.of(
                                                            context)
                                                        .state
                                                        .userInfoMain
                                                        .nickname,
                                                profilepicktureurl:
                                                    GlobalStateContainer.of(
                                                            context)
                                                        .state
                                                        .userInfoMain
                                                        .profilepicktureurl);
                                        Fcubereply result =
                                            await rereply.makereply();
                                        if (result != null) {
                                          replyExtenderlist.insert(
                                              index + 1, rereply);
                                        }
                                      }
                                    },
                                    child: replyExtenderlist[index].depth > 0
                                        ? null
                                        : Text(
                                            "답글 달기",
                                            style: TextStyle(inherit: true),
                                          ),
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ));
              },
            ))
      ],
    ));
  }

  Widget makedetailcubes() {
    return Container(child: Text("박스 목록"));
    //예제 코드
    // if(contents.containsKey(FcubecontentType.startCubeLocation)){
    //    StartCubeLocation startcube = StartCubeLocation.fromJson(json.decode(contents[FcubecontentType.startCubeLocation].contentvalue));
    // }
  }

  Widget replyDialog() {
    TextEditingController replycontroller = TextEditingController();
    return Dialog(
      child: Container(
          height: 350,
          child: Column(
            children: <Widget>[
              Container(child: Text("댓글 달기")),
              Form(
                child: TextFormField(
                  controller: replycontroller,
                  decoration: InputDecoration(hintText: "댓글을 입력"),
                ),
              ),
              Row(
                children: <Widget>[
                  RaisedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("Close")),
                  RaisedButton(
                      onPressed: () {
                        Navigator.of(context).pop(replycontroller.text);
                      },
                      child: Text("OK")),
                ],
              )
            ],
          )),
    );
  }

  void onMapCreated(GoogleMapController controller) async {
    setState(() {});
    setmakers();
  }

  double getsiktycontentheight() {
    if (tabController.index == 0) {
      return richtextheightsize + replysize + 900;
    } else {
      return 300;
    }
  }

  void setmakers() async {
    BitmapDescriptor icon =
        await Fcube.getMarkerImage(fcubequest.cubeimage, 150);

    setState(() {
      makres.add(Marker(
          markerId: MarkerId("MainCube"),
          icon: icon,
          position: LatLng(fcubequest.latitude, fcubequest.longitude)));
    });
  }

  Widget selectSlidingUpPanel() {
    DateTime acttime =
        fcubequest.activationtime.toUtc().add(Duration(hours: 9));
    if (selectfinishtime == null) {
      selectfinishtime = DateTime.now();
    }
    if (fcubequest.cubestate == FcubeState.startWait &&
        ispanelopen &&
        currentupPanelmode == UpPanelMode.startedit) {
      return Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              child: RaisedButton(
                child: Icon(Icons.arrow_drop_down),
                onPressed: () async {
                  panelcontroller.close();
                  setState(() {});
                },
              ),
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  Container(
                    child: Text("종료일자"),
                  ),
                  Container(
                    child: RaisedButton(
                      onPressed: () {
                        DatePicker.showDatePicker(context,
                            currentTime: selectfinishtime, onConfirm: (date) {
                          if (date.difference(DateTime.now()).inSeconds < 0) {
                            print("지난 날짜");
                          } else {
                            selectfinishtime = date;
                          }
                          setState(() {});
                          print(date);
                        },
                            minTime: selectfinishtime,
                            maxTime: acttime.add(Duration(days: 7)),
                            locale: LocaleType.ko);
                      },
                      child: Text(
                          DateFormat("yyyy-MM-dd").format(selectfinishtime)),
                    ),
                  ),
                  Container(
                    child: RaisedButton(
                      onPressed: () {
                        DatePicker.showTimePicker(context,
                            currentTime: selectfinishtime,
                            locale: LocaleType.ko, onConfirm: (date) {
                          if (date.difference(DateTime.now()).inSeconds < 0) {
                            print("지난 날짜");
                          } else {
                            selectfinishtime = date;
                          }
                          setState(() {});
                          print(date);
                        });
                      },
                      child: Text(DateFormat("HH:mm").format(selectfinishtime)),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: RaisedButton(
                onPressed: () {
                  fcubequest.activationtime = selectfinishtime.toUtc();
                  fcubequest.cubestate = FcubeState.play;
                  fcubequest.updateCubeState();
                  panelcontroller.close();
                },
                child: Text("퀘스트 시작"),
              ),
            )
          ],
        ),
      );
    } else if (currentupPanelmode == UpPanelMode.settingedit &&
        ispanelopen &&
        getjoinmode() == FcubeJoinMode.administrator) {
      return FcubeQuestBottomNaviBar(
        fcube: fcubequest,
        onfuntionclick: (FcubeQuestBottomNaviFuncType value, Fcube cube) async {
          if (value == FcubeQuestBottomNaviFuncType.delete) {
            await cube.deletecube();
            Navigator.pop(context);
          }
        },
      );
    } else if (currentupPanelmode == UpPanelMode.startedit &&
        ispanelopen &&
        getjoinmode() == FcubeJoinMode.player &&
        myfcubs.length == 0) {
      String authmethod = json.decode(this
          .contents[FcubecontentType.authmethod]
          .contentvalue)["authmethod"];
      String authPicturedescription = json.decode(this
          .contents[FcubecontentType.authPicturedescription]
          .contentvalue)["authPicturedescription"];
      return Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                child: RaisedButton(
                  onPressed: () {
                    panelcontroller.close();
                  },
                  child: Icon(Icons.arrow_drop_down),
                ),
              ),
              Expanded(
                  child: ListView(
                children: <Widget>[
                  Container(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Text("현재 참가자수 : ${joinplayer.length} 명"),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Text(
                            "남은시간 : ${fcubequest.remindActiveTimetoString()}"),
                      ),
                    ],
                  )),
                  Divider(
                    color: Colors.black,
                  ),
                  Row(
                    children: <Widget>[
                      Image(
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                          image: AssetImage(FcubeAuthMethodType.toImagePath(
                              FcubeAuthMethodType.fromString(authmethod)))),
                      Column(
                        children: <Widget>[
                          Container(
                            child: Text("인증법 = $authmethod"),
                          ),
                          Container(
                            child: Text("인증 방법 설명 = $authPicturedescription"),
                          )
                        ],
                      )
                    ],
                  ),
                  Divider(
                    color: Colors.black,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                          child: Container(
                        child: Text("보상 보인트"),
                      )),
                      Container(
                        child: Text("${fcubequest.pointreward}"),
                      )
                    ],
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: RaisedButton(
                      onPressed: () async {
                        isjoininsertbtnloading = true;
                        setState(() {});
                        playerme = Fcubeplayer(
                            cubeuuid: fcubequest.cubeuuid,
                            uid: _currentuser.uid,
                            playstate: FcubeplayerState.playing);
                        //back android service start
                        if (await playerme.insertFcubePlayer() > 0) {
                          myfcubs = await FcubeplayerExtender1.selectPlayers(
                              playerme);
                          joinplayer = await FcubeplayerExtender1.selectPlayers(
                              findjoinplayer);
                          startservice();
                          isjoininsertbtnloading = false;
                          panelcontroller.close();
                          setState(() async {
                            await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    settings: RouteSettings(
                                        name: "QuestAdministratorPage"),
                                    builder: (context) {
                                      return QuestAdministratorPage(
                                          fcubequest: fcubequest);
                                    }));
                            await fcubequest.getwithupdatecubestate();
                          });
                        }
                      },
                      child: isjoininsertbtnloading
                          ? CircularProgressIndicator()
                          : Text("참가하기"),
                    ),
                  )
                ],
              ))
            ],
          ));
    } else {
      return null;
    }
  }

  startservice() async {
    try {
      await platform.invokeMethod<void>('connectservice');

      List<String> args = List<String>();
      Uri uri = Preference.httpurlbase(
          Preference.baseBackEndUrl, "/api/v1/Auth/updateCurrentPosition");
      args.add(uri.toString());
      args.add(_currentuser.uid);
      IdTokenResult token = await _currentuser.getIdToken();
      args.add(token.token);
      await platform.invokeMethod<void>('startLocationManager', args);
    } catch (ex) {
      print(ex);
    }
  }

  Widget makePlayerPanel() {
    return Container(
      child: ListView.builder(
        itemCount: joinplayer.length,
        itemBuilder: ((context, index) {
          FcubeplayerExtender1 jplay = joinplayer[index];
          DateTime starttime = jplay.starttime.add(Duration(hours: 9));
          DateFormat("yyyy-MM-dd HH:mm:ss").format(starttime);
          String playstate;
          if (jplay.playstate == FcubeplayerState.playing) {
            playstate = "진행중";
          } else {
            playstate = "대기중";
          }
          return Container(
            child: FlatButton(
              onPressed: () {},
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundImage: NetworkImage(jplay.profilepicktureurl),
                      ),
                      Expanded(
                        child: Container(
                          child: Column(
                            children: <Widget>[
                              Container(
                                child: Text("${jplay.nickname}"),
                              ),
                              Container(
                                child: Text(
                                    "${DateFormat("yyyy-MM-dd HH:mm:ss").format(starttime)}"),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        child: Text(playstate),
                      )
                    ],
                  ),
                  Divider(
                    color: Colors.black,
                  )
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  getSlidingUpPanelmaxheight() {
    if (currentupPanelmode == UpPanelMode.startedit) {
      return MediaQuery.of(context).size.height * 0.8;
    } else if (currentupPanelmode == UpPanelMode.settingedit) {
      return MediaQuery.of(context).size.height * 0.4;
    } else {
      return MediaQuery.of(context).size.height * 0.8;
    }
  }

  @override
  Widget build(BuildContext context) {
    final GoogleMap googleMap = GoogleMap(
      gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
        new Factory<OneSequenceGestureRecognizer>(
          () => new EagerGestureRecognizer(),
        ),
      ].toSet(),
      initialCameraPosition: initialCameraPosition,
      onMapCreated: onMapCreated,
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
      markers: makres,
    );
    if (_richtextkey.currentContext != null) {
      RenderBox renderbox = _richtextkey.currentContext.findRenderObject();
      richtextheightsize = renderbox.size.height;
    }
    if (_replykey.currentContext != null) {
      RenderBox renderbox = _replykey.currentContext.findRenderObject();
      replysize = renderbox.size.height;
    }
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        actions: <Widget>[
          Container(
            child: IconButton(
              icon: Icon(Icons.share),
              onPressed: () {},
            ),
          ),
          getjoinmode() == FcubeJoinMode.administrator
              ? Container(
                  child: IconButton(
                    icon: Icon(Icons.settings),
                    onPressed: () {
                      if (panelcontroller.isPanelOpen()) {
                        panelcontroller.close();
                      } else {
                        currentupPanelmode = UpPanelMode.settingedit;
                        panelcontroller.open();
                      }
                    },
                  ),
                )
              : Container()
        ],
      ),
      body: isloading
          ? Center(child: CircularProgressIndicator())
          : SlidingUpPanel(
              maxHeight: getSlidingUpPanelmaxheight(),
              minHeight: 70,
              controller: panelcontroller,
              isDraggable: isSlidingUpPanelDrag,
              onPanelOpened: () {
                ispanelopen = true;
                isSlidingUpPanelDrag = true;
                setState(() {});
              },
              onPanelClosed: () {
                ispanelopen = false;
                isSlidingUpPanelDrag = false;
                setState(() {});
              },
              panel: Container(
                child: selectSlidingUpPanel(),
              ),
              collapsed: isscrolling
                  ? Container()
                  : makebottomNavi(fcubequest.cubestate),
              renderPanelSheet: false,
              body: Stack(children: <Widget>[
                ListView(
                  controller: listviewcontroller,
                  children: <Widget>[
                    StickyHeader(
                      header: Container(
                          height: MediaQuery.of(context).size.height * 0.1,
                          child: ListTile(
                              contentPadding: EdgeInsets.all(0),
                              leading: Image(
                                image: AssetImage(fcubequest.cubeimage),
                              ),
                              title: Text(fcubequest.cubename),
                              subtitle: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Text(fcubequest.placeaddress),
                                  ),
                                  Container(
                                    width: 50,
                                  ),
                                  Text("$currentdistancediff m")
                                ],
                              ))),
                      content: Container(
                          height: MediaQuery.of(context).size.height * 0.35,
                          child: googleMap),
                    ),
                    StickyHeader(
                        header: Container(
                          color: Colors.grey,
                          height: 50,
                          child: TabBar(
                            controller: tabController,
                            indicatorColor: Colors.black,
                            tabs: <Widget>[
                              Tab(text: '상세정보'),
                              Tab(text: '박스'),
                              Tab(text: '참가자(${joinplayer.length})'),
                            ],
                          ),
                        ),
                        content: Container(
                            height: getsiktycontentheight(),
                            child: TabBarView(
                              controller: tabController,
                              children: <Widget>[
                                makedetailcontent(),
                                Container(
                                  child: Text("456"),
                                ),
                                makePlayerPanel()
                              ],
                            ))),
                  ],
                ),
              ]),
            ),
    );
  }
}
