import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:forutonafront/Common/Fcubeplayer.dart';
import 'package:forutonafront/Common/FcubeplayerExtender1.dart';
import 'package:forutonafront/Common/Fcubereply.dart';
import 'package:forutonafront/Common/FcubereplyExtender1.dart';
import 'package:forutonafront/MakePage/Component/CubeMakeRichTextEdit.dart';
import 'package:forutonafront/MakePage/Component/Fcube.dart';
import 'package:forutonafront/MakePage/Component/FcubeExtender1.dart';
import 'package:forutonafront/MakePage/Component/QuestCube/FcubeQuest.dart';
import 'package:forutonafront/MakePage/FcubeTypes.dart';
import 'package:forutonafront/MakePage/Fcubecontent.dart';
import 'package:forutonafront/globals.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:intl/intl.dart';
import 'package:zefyr/zefyr.dart';

class FcubeQuestDetailPage extends StatefulWidget {
  final FcubeExtender1 fcubeextender1;
  FcubeQuestDetailPage({Key key, this.fcubeextender1}) : super(key: key);

  @override
  _FcubeQuestDetailPageState createState() {
    return _FcubeQuestDetailPageState(fcubeextender1: fcubeextender1);
  }
}

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
  GoogleMapController _mapController;
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    tabController = TabController(length: 3, vsync: this);
    fcubequest = FcubeQuest.fromFcubeExtender1(fcubeextender1);
    fcubequest.cubeimage = "assets/MarkesImages/QuestCube.png";
    listviewcontroller.addListener(() async {
      heidBottomNavi();
    });
    init();
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

  init() async {
    initialCameraPosition = new CameraPosition(
        target: LatLng(fcubequest.latitude, fcubequest.longitude), zoom: 16);
    isloading = true;
    _currentuser = await FirebaseAuth.instance.currentUser();
    setState(() {});
    this.contents = await initFcubeQuest();
    initgeolocation();

    Fcubeplayer player =
        new Fcubeplayer(cubeuuid: fcubequest.cubeuuid, uid: _currentuser.uid);
    myfcubs = await FcubeplayerExtender1.selectPlayers(player);

    isloading = false;
    setState(() {});
    acttimetimer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {});
    });
    initreply();
    richtextview = CubeMakeRichTextEdit(
      custommode: "nomal",
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
      String uid = GolobalStateContainer.of(context).state.userInfoMain.uid;
      List<FcubecontentType> types = List<FcubecontentType>();
      types.add(FcubecontentType.startCubeLocation);
      types.add(FcubecontentType.finishCubeLocation);
      types.add(FcubecontentType.description);
      types.add(FcubecontentType.messagecubeLocations);
      types.add(FcubecontentType.checkincubeLocations);
      types.add(FcubecontentType.authmethod);
      types.add(FcubecontentType.authPicturedescription);
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
            DateTime.parse(fcubequest.activationtime).add(Duration(hours: 9));

        Duration avtibetime = activationtime
            .difference(DateTime.now().toUtc().add(Duration(hours: 9)));
        int actday = avtibetime.inSeconds ~/ (60 * 60 * 24);
        int acthour =
            (avtibetime.inSeconds - actday * 60 * 60 * 24) ~/ (60 * 60);
        int actmin =
            (avtibetime.inSeconds - actday * 60 * 60 * 24 - acthour * 3600) ~/
                (60);
        int actsec = avtibetime.inSeconds % 60;
        return Container(
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
                      child: Text("${actday}일 ${acthour}:${actmin}:${actsec}"),
                    ),
                    Expanded(
                        child: SizedBox(
                      width: 50,
                    )),
                    Container(
                      child: RaisedButton(
                        onPressed: () {},
                        child: Text("관리자 모드"),
                      ),
                    )
                  ],
                )));
      default:
        return null;
    }
  }

  Widget playerbottomNavi(FcubeState state) {
    //참가 했는지 Player 리스트 따와야함
    if (state == FcubeState.play && myfcubs.length == 0) {
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
                  setState(() {
                    if (myfcubs[0].hasgiveup > 0 || myfcubs[0].hasexit > 0) {
                      showDialog(
                          context: context,
                          builder: (bulder) {
                            return Column(
                              children: <Widget>[
                                Container(
                                  child: Text("퇴출이나 항복한 이력이 있습니다."),
                                ),
                                Container(
                                    child: RaisedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text("close"),
                                ))
                              ],
                            );
                          });
                    }
                  });
                },
                child: Text("참가 하기"),
              ),
            )),
      );
    }
  }

  Widget bottomNavi() {
    if (_currentuser.uid == fcubequest.uid) {
      return makebottomNavi(fcubequest.cubestate);
    } else {
      return playerbottomNavi(fcubequest.cubestate);
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
    DateTime activationtime =
        DateTime.parse(fcubequest.activationtime).add(Duration(hours: 9));

    Duration avtibetime = activationtime
        .difference(DateTime.now().toUtc().add(Duration(hours: 9)));

    int actday = avtibetime.inSeconds ~/ (60 * 60 * 24);
    int acthour = (avtibetime.inSeconds - actday * 60 * 60 * 24) ~/ (60 * 60);
    int actmin =
        (avtibetime.inSeconds - actday * 60 * 60 * 24 - acthour * 3600) ~/ (60);
    int actsec = avtibetime.inSeconds % 60;

    String stravtibetime = "${actday}일 ${acthour}:${actmin}:${actsec}";

    return Container(
        child: Column(
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
          height: getdescriptionheight() + 40,
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
                  child: Text("${stravtibetime}"),
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
                                nickname: GolobalStateContainer.of(context)
                                    .state
                                    .userInfoMain
                                    .nickname,
                                profilepicktureurl:
                                    GolobalStateContainer.of(context)
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
            height: replyheight(),
            child: ListView.builder(
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
                                                    GolobalStateContainer.of(
                                                            context)
                                                        .state
                                                        .userInfoMain
                                                        .nickname,
                                                profilepicktureurl:
                                                    GolobalStateContainer.of(
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
    setState(() {
      _mapController = controller;
    });
    setmakers();
  }

  double getdescriptionheight() {
    double setheight = 50;
    String tempdescription =
        jsonDecode(this.contents[FcubecontentType.description].contentvalue)[
            "description"];
    List<dynamic> description = jsonDecode(tempdescription);
    description.forEach((value) {
      Map values = value as Map;
      values.keys.forEach((key) {
        if (key == "insert") {
          String text = value[key];
          Iterable<Match> findn = text.allMatches("\n");
          setheight += findn.length * 50;
        } else if (key == "attributes") {
          if (value[key]["embed"]["type"] == "image") {
            setheight += 150;
          }
        }
      });
    });

    // if (description.length > 0) {
    //   return (description.length.toDouble() * 50);
    // } else {
    //   return 150;
    // }
    return setheight;
  }

  double getsiktycontentheight() {
    if (tabController.index == 0) {
      return getdescriptionheight() + 150 + 200 + 200 + 200 + 400;
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
    DateTime acttime = DateTime.parse(fcubequest.activationtime)
        .toUtc()
        .add(Duration(hours: 9));
    if (selectfinishtime == null) {
      selectfinishtime = DateTime.now();
    }
    if (fcubequest.cubestate == FcubeState.startWait && ispanelopen) {
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
                  fcubequest.activationtime =
                      selectfinishtime.toUtc().toIso8601String();
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
    } else {
      return null;
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
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          Container(
            child: IconButton(
              icon: Icon(Icons.share),
              onPressed: () {},
            ),
          ),
          Container(
            child: IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: isloading
          ? Center(child: CircularProgressIndicator())
          : SlidingUpPanel(
              controller: panelcontroller,
              isDraggable: isSlidingUpPanelDrag,
              onPanelOpened: () {
                ispanelopen = true;
              },
              onPanelClosed: () {
                ispanelopen = false;
              },
              panel: Container(
                child: selectSlidingUpPanel(),
              ),
              collapsed: isscrolling ? Container() : bottomNavi(),
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
                              Text("${currentdistancediff} m")
                            ],
                          ),
                        ),
                      ),
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
                              Tab(text: '참가자'),
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
                                Container(
                                  child: Text("789"),
                                ),
                              ],
                            )

                            // TabBarView(
                            //   controller: tabController,
                            //   children: <Widget>[
                            //     Text("11"),
                            //     Text("22"),
                            //     Text("44"),
                            //   ],
                            // ),
                            )),
                  ],
                ),
              ]),
            ),
    );
  }
}
