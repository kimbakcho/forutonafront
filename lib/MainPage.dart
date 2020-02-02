import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:forutonafront/Auth/UserInfoMain.dart';
import 'package:forutonafront/Common/FCubeGeoSearchUtil.dart';
import 'package:forutonafront/Common/GeoSearchUtil.dart';
import 'package:forutonafront/HomePage/HomePageView.dart';
import 'package:forutonafront/LoginPage/A000LoginPageView.dart';
import 'package:forutonafront/MakePage/Component/FcubeExtender1.dart';
import 'package:forutonafront/MakePage/Component/FcubeSearch.dart';
import 'package:forutonafront/MakePage/MakePageView.dart';
import 'package:forutonafront/PlayPage/PlayPageView.dart';
import 'package:forutonafront/globals.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'MainPage/Component/HomeNavi.dart';
import 'MainPage/Component/HomeNaviInter.dart';
import 'package:flutter_kakao_login/flutter_kakao_login.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'MainpageDarwer.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key}) : super(key: key);

  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  HomeNaviInter naviitme;
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser currentuser;
  HomeNavi homenavi;
  var geolocator = Geolocator();
  var locationOptions =
      LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 2);
  List<Widget> mainSwipeList = List<Widget>();
  MakePageView makePageView = MakePageView();
  HomePageView homePageView = HomePageView();
  PlayPageView playPageView = PlayPageView();
  SwiperCustomPagination pagenation = SwiperCustomPagination(
      builder: (BuildContext context, SwiperPluginConfig config) {
    return new Container();
  });
  SwiperController swipercontroller = SwiperController();
  Position currentposition;
  Swiper swiper;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      new FlutterLocalNotificationsPlugin();
  @override
  void initState() {
    super.initState();
    naviitme = HomeNaviInter();
    mainSwipeList.add(makePageView);
    mainSwipeList.add(homePageView);
    mainSwipeList.add(playPageView);
    swiper = new Swiper(
      itemBuilder: (BuildContext context, int index) {
        return mainSwipeList[index];
      },
      index: 1,
      itemCount: mainSwipeList.length,
      pagination: pagenation,
      controller: swipercontroller,
      onIndexChanged: (index) {
        if (index == 0) {
          homenavi.setPosition(HomeNaviInter.makeMode);
        } else if (index == 1) {
          homenavi.setPosition(HomeNaviInter.homeMode);
        } else if (index == 2) {
          homenavi.setPosition(HomeNaviInter.palyMode);
        }
      },
    );
    homenavi = HomeNavi(
      parentitem: naviitme,
      onclickbutton: (String btnmode) => {
        if (btnmode == HomeNaviInter.makeMode)
          {swipercontroller.move(0)}
        else if (btnmode == HomeNaviInter.homeMode)
          {swipercontroller.move(1)}
        else if (btnmode == HomeNaviInter.palyMode)
          {swipercontroller.move(2)}
      },
    );

    FirebaseAuth.instance.onAuthStateChanged.listen((firebaseUser) async {
      currentuser = firebaseUser;
      if (firebaseUser == null) {
        GlobalStateContainer.of(context).state.userInfoMain = null;
        GlobalStateContainer.of(context).setfcubeListUtilisLoading(false);
        GlobalStateContainer.of(context).resetcubeListUtilcubeList();
        initgeopermisstion();
        setState(() {});
      } else {
        //isnewuser를 하는 이유는 SignIn3View 에서 UserInfoMain.insertUserInfo(userinfo); 를
        //하기전에 상태 변경 해당  메소드로 들어와 insert 되기 전에 DB에서
        // UserInfoMain.getUserInfoMain(firebaseUser) 를 막기 위함이다.
        if (GlobalStateContainer.of(context).state.isnewuser == true) {
          GlobalStateContainer.of(context).state.isnewuser = false;
        } else {
          GlobalStateContainer.of(context).state.userInfoMain =
              await UserInfoMain.getUserInfoMain(firebaseUser);
          print(GlobalStateContainer.of(context).state.userInfoMain.uid);
          setState(() {});
        }
        GlobalStateContainer.of(context).resetcubeListUtilcubeList();
        Future.delayed(Duration.zero, () async {
          GlobalStateContainer.of(context).setfcubeListUtilisLoading(true);

          GlobalStateContainer.of(context).addfcubeListUtilcubeList(
              await FcubeExtender1.getusercubes(FcubeSearch(limit: 10,offset: 0,isdesc: true,orderby: "MakeTime")));

          initgeopermisstion();

          GlobalStateContainer.of(context).setfcubeListUtilisLoading(false);
        });
        String fcmtoken = await _firebaseMessaging.getToken();
        GlobalStateContainer.of(context).state.userInfoMain.fcmtoken = fcmtoken;
        await GlobalStateContainer.of(context)
            .state
            .userInfoMain
            .updateFCMtoken();
      }
    });
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        var androidPlatformChannelSpecifics = AndroidNotificationDetails(
            'com.wing.forutonafront/mainnnoti', 'forutona', 'forutona',
            importance: Importance.High,
            priority: Priority.High,
            ticker: 'ticker');
        var iOSPlatformChannelSpecifics = IOSNotificationDetails();
        var platformChannelSpecifics = NotificationDetails(
            androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
        await _flutterLocalNotificationsPlugin.show(
            0, 'plain title', 'plain body', platformChannelSpecifics,
            payload: 'item x');
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(
            sound: true, badge: true, alert: true, provisional: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
    _firebaseMessaging.getToken().then((String token) async {});
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = IOSInitializationSettings();
    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
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
    await PermissionHandler().requestPermissions(
        [PermissionGroup.location, PermissionGroup.locationAlways]);
    PermissionStatus permissition = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.location);
    if (permissition == PermissionStatus.granted) {
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
      if (currentuser != null) {
        GlobalStateContainer.of(context)
            .updateCubeListupdatedistancewithme(currentposition);
      }
      GlobalStateContainer.of(context)
          .updatePlayViewCubeListupdatedistancewithme(currentposition);
      GlobalStateContainer.of(context).updateCurrentAddress(currentposition);
      return;
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

  Widget loginButton() {
    if (GlobalStateContainer.of(context).state.userInfoMain == null) {
      return Text(
        "Log in",
        style: TextStyle(fontSize: 15),
      );
    } else {
      return Container(
          child: CircleAvatar(
        backgroundImage: GlobalStateContainer.of(context)
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
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            titleSpacing: 0,
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height * 0.076,
                  decoration: BoxDecoration(
                      border: Border.all(
                    color: Colors.black54,
                    width: 1.0,
                  )),
                  margin: EdgeInsets.all(0),
                  padding: EdgeInsets.all(0),
                  child: Builder(builder: (context) {
                    return FlatButton(
                      child: loginButton(),
                      onPressed: () {
                        if (currentuser == null) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  settings: RouteSettings(name: "A000"),
                                  builder: (context) {
                                    return A000LoginPageView();
                                  }));
                        } else {
                          Scaffold.of(context).openDrawer();
                        }
                      },
                    );
                  }),
                ),
                Expanded(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.076,
                    decoration: BoxDecoration(
                        border: Border.all(
                      color: Colors.black54,
                      width: 1.0,
                    )),
                    child: Center(child: homenavi),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.076,
                  decoration: BoxDecoration(
                      border: Border.all(
                    color: Colors.black54,
                    width: 1.0,
                  )),
                  margin: EdgeInsets.all(0),
                  padding: EdgeInsets.all(0),
                  child: FlatButton(
                    child: Text(
                      "Join",
                      style: TextStyle(fontSize: 15),
                    ),
                    onPressed: () async {
                      FirebaseUser userinfo = await _auth.currentUser();
                      if (userinfo != null) {
                        await _auth.signOut();
                      }
                      if (await FlutterKakaoLogin().isLoggedIn) {
                        await FlutterKakaoLogin().logOut();
                      }
                      if (await FacebookLogin().isLoggedIn) {
                        await FacebookLogin().logOut();
                      }
                    },
                  ),
                )
              ],
            )),
        drawer: MainpageDarwer(),
        body: Container(
          padding: EdgeInsets.all(0),
          margin: EdgeInsets.all(0),
          child: swiper,
        ));
  }
}
