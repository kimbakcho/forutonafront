import 'package:after_init/after_init.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:forutonafront/Common/FCubeGeoSearchUtil.dart';
import 'package:forutonafront/Common/GeoSearchUtil.dart';
import 'package:forutonafront/HomePage/HomePageView.dart';
import 'package:forutonafront/MainPage/Component/BCD001NaviAnimationController.dart';
import 'package:forutonafront/MakePage/C001MakePageView.dart';
import 'package:forutonafront/MakePage/Component/FcubeExtender1.dart';
import 'package:forutonafront/MakePage/Component/FcubeSearch.dart';
import 'package:forutonafront/PlayPage/D001PlayPageView.dart';

import 'package:forutonafront/globals.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:permission_handler/permission_handler.dart';

class BCD001MainPage extends StatefulWidget {
  BCD001MainPage({Key key}) : super(key: key);

  @override
  _BCD001MainPageState createState() => _BCD001MainPageState();
}

class _BCD001MainPageState extends State<BCD001MainPage> with AfterInitMixin {
  BCD001NaviAnimationController navicontroller;
  Widget loginBtn;
  Widget snsBtn;
  Swiper swiper;

  var geolocator = Geolocator();
  Position currentposition;
  SwiperController swipercontroller = SwiperController();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  SwiperCustomPagination pagenation = SwiperCustomPagination(
      builder: (BuildContext context, SwiperPluginConfig config) {
    return new Container();
  });
  var locationOptions =
      LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 2);
  int currentoffset = 0;
  Widget loginButton() {
    if (GlobalStateContainer.of(context).state.userInfoMain == null) {
      return FlatButton(
        padding: EdgeInsets.fromLTRB(0, 0, 16, 0),
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Container(
          child: Text(
            "로그인",
            style: TextStyle(
              fontSize: 14,
              fontFamily: "Noto Sans CJK KR",
              color: Color(0xffFF4F9A),
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      );
    } else {
      return Container(
        margin: EdgeInsets.fromLTRB(16, 0, 0, 0),
        width: 42,
        height: 42,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
                image: GlobalStateContainer.of(context)
                            .state
                            .userInfoMain
                            .profilepicktureurl
                            .length ==
                        0
                    ? AssetImage("assets/basicprofileimage.png")
                    : NetworkImage(GlobalStateContainer.of(context)
                        .state
                        .userInfoMain
                        .profilepicktureurl),
                fit: BoxFit.cover)),
        child: FlatButton(
          onPressed: () {},
          shape: CircleBorder(),
          child: Container(),
        ),
      );
    }
  }

  Widget snsActionbutton() {
    if (GlobalStateContainer.of(context).state.userInfoMain == null) {
      return FlatButton(
        padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Text(
          "가입",
          style: TextStyle(
            fontSize: 14,
            fontFamily: "Noto Sans CJK KR",
            color: Color(0xff3497FD),
            decoration: TextDecoration.underline,
          ),
        ),
      );
    } else {
      return Container(
        margin: EdgeInsets.fromLTRB(0, 0, 16, 0),
        width: 42,
        height: 42,
        child: FlatButton(
          onPressed: () async {
            FirebaseUser userinfo = await FirebaseAuth.instance.currentUser();
            if (userinfo != null) {
              await FirebaseAuth.instance.signOut();
            }
            GlobalStateContainer.of(context).state.userInfoMain = null;
            Navigator.of(context).pop();
            setState(() {});
          },
          shape: CircleBorder(),
          child: Container(),
        ),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
                image: AssetImage("assets/MainImage/connections.png"),
                fit: BoxFit.cover)),
      );
    }
  }

  initPlayViewCubelist() async {
    FCubeGeoSearchUtil searchitem = FCubeGeoSearchUtil.fromGeoSearchUtil(
        GeoSearchUtil(
            distance: 5000,
            latitude:
                GlobalStateContainer.of(context).state.currentposition.latitude,
            longitude: GlobalStateContainer.of(context)
                .state
                .currentposition
                .longitude,
            limit: 10,
            offset: 0),
        cubescope: 0,
        cubestate: 1,
        activationtime: DateTime.now());
    GlobalStateContainer.of(context).setfcubeListUtilisLoading(true);
    GlobalStateContainer.of(context).addfcubeplayerListUtilcubeList(
        await FcubeExtender1.findNearDistanceCube(searchitem));
    GlobalStateContainer.of(context).setfcubeListUtilisLoading(false);
  }

  initgeopermisstion() async {
    await PermissionHandler().requestPermissions(
        [PermissionGroup.location, PermissionGroup.locationAlways]);
    PermissionStatus permissition = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.location);
    if (permissition == PermissionStatus.granted) {
      await initgeolocation();
      initPlayViewCubelist();
    } else {
      Future.delayed(Duration.zero, () {
        showDialog(
            context: context,
            builder: (context) {
              return Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Text("해당 서비스 이용이 어렵습니다."),
                    ),
                    Container(
                        child: RaisedButton(
                      child: Text("Close"),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ))
                  ],
                ),
              );
            });
      });
    }
  }

  Future<void> initgeolocation() async {
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
      GlobalStateContainer.of(context).updateCurrnetPosition(currentposition);
      GlobalStateContainer.of(context)
          .updateCubeListupdatedistancewithme(currentposition);
      GlobalStateContainer.of(context)
          .updatePlayViewCubeListupdatedistancewithme(currentposition);

      GlobalStateContainer.of(context).setmainInitialCameraPosition(
          CameraPosition(
              target:
                  LatLng(currentposition.latitude, currentposition.longitude),
              zoom: 16));
    });

    currentposition = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    if (currentposition == null) {
      currentposition = await Geolocator()
          .getLastKnownPosition(desiredAccuracy: LocationAccuracy.high);
    }
    GlobalStateContainer.of(context).updateCurrnetPosition(currentposition);
    if (GlobalStateContainer.of(context).state.userInfoMain != null) {
      GlobalStateContainer.of(context)
          .updateCubeListupdatedistancewithme(currentposition);
    }
    GlobalStateContainer.of(context)
        .updatePlayViewCubeListupdatedistancewithme(currentposition);
    GlobalStateContainer.of(context).updateCurrentAddress(currentposition);
    return;
  }

  C001MakePageView c001makePageView;
  D001PlayPageView playPageView;
  HomePageView homePageView;
  D001Controller d001controller;
  @override
  void initState() {
    super.initState();
    c001makePageView = new C001MakePageView();
    d001controller = D001Controller();
    playPageView = new D001PlayPageView(d001controller: d001controller);
    homePageView = new HomePageView();
    loginBtn = Container();
    snsBtn = Container();
    navicontroller =
        BCD001NaviAnimationController(onChangeNaviPostion: onChangeNaviPostion);
    swiper = new Swiper(
        onIndexChanged: swiperonindexchange,
        controller: swipercontroller,
        index: 1,
        itemCount: 3,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return c001makePageView;
          } else if (index == 1) {
            return homePageView;
          } else if (index == 2) {
            return playPageView;
          } else {
            return Container();
          }
        });
    currentoffset = swiper.index;
  }

  swiperonindexchange(value) {
    if (navicontroller.tapSource == "Swiper") {
      if (value == (swiper.itemCount - 1) && currentoffset == 0) {
        navicontroller.processValue = navicontroller.processValue + 0.5;
      } else if (value == 0 && currentoffset == (swiper.itemCount - 1)) {
        navicontroller.processValue = navicontroller.processValue - 0.5;
      } else if (currentoffset > value) {
        navicontroller.processValue = navicontroller.processValue + 0.5;
      } else {
        navicontroller.processValue = navicontroller.processValue - 0.5;
      }
    }
    if (value == 2) {
      d001controller.selecttimerstart();
    } else {
      d001controller.selecttimerstop();
    }
    currentoffset = value;
  }

  @override
  void didInitState() async {
    loginBtn = loginButton();
    snsBtn = snsActionbutton();
    if (GlobalStateContainer.of(context).state.userInfoMain != null) {
      GlobalStateContainer.of(context).resetcubeListUtilcubeList();
      GlobalStateContainer.of(context).setfcubeListUtilisLoading(true);
      setState(() {});
      GlobalStateContainer.of(context).addfcubeListUtilcubeList(
          await FcubeExtender1.getusercubes(FcubeSearch(
              limit: 10, offset: 0, isdesc: true, orderby: "MakeTime")));
      initgeopermisstion();
      GlobalStateContainer.of(context).setfcubeListUtilisLoading(false);
      setState(() {});
      String fcmtoken = await _firebaseMessaging.getToken();
      GlobalStateContainer.of(context).state.userInfoMain.fcmtoken = fcmtoken;
      await GlobalStateContainer.of(context)
          .state
          .userInfoMain
          .updateFCMtoken();
    }
    setState(() {});
  }

  onChangeNaviPostion(NaviPosition currentposition) {
    if (navicontroller.tapSource == "Appbar") {
      print(currentposition);
      if (currentposition == NaviPosition.make) {
        swipercontroller.move(0);
      } else if (currentposition == NaviPosition.home) {
        swipercontroller.move(1);
      } else if (currentposition == NaviPosition.paly) {
        swipercontroller.move(2);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          titleSpacing: 0.0,
          title: Row(
            children: <Widget>[
              loginBtn,
              Expanded(
                  flex: 3,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.center,
                    child: Container(
                        height: 42,
                        width: 128,
                        child: GestureDetector(
                            onTapUp: (TapUpDetails value) {
                              navicontroller.tapSource = "Appbar";
                              double cellsize = 128.0 / 3;
                              if (value.localPosition.dx < (cellsize * 1.0)) {
                                navicontroller.processValue =
                                    navicontroller.processValue + 0.5;
                              } else if (value.localPosition.dx >
                                      (cellsize * 1.0) &&
                                  value.localPosition.dx < (cellsize * 2.0)) {
                              } else if (value.localPosition.dx >
                                  (cellsize * 2.0)) {
                                navicontroller.processValue =
                                    navicontroller.processValue - 0.5;
                              }
                            },
                            child: FlareActor(
                              "assets/Rive/navi.flr",
                              fit: BoxFit.fitWidth,
                              animation: "play",
                              artboard: "navi",
                              controller: navicontroller,
                            ))),
                  )),
              snsBtn
            ],
          ),
        ),
        body: Container(
          child: GestureDetector(
            onPanDown: (value) {
              navicontroller.tapSource = "Swiper";
            },
            child: swiper,
          ),
        ));
  }
}
