import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:forutonafront/Auth/UserInfoMain.dart';
import 'package:forutonafront/HomePage/HomePageView.dart';
import 'package:forutonafront/MakePage/MakePageView.dart';
import 'package:forutonafront/PlayPage/PlayPageView.dart';
import 'package:forutonafront/globals.dart';

import 'MainPage/Component/HomeNavi.dart';
import 'MainPage/Component/HomeNaviInter.dart';
import 'LoginPage/LoginPageView.dart';

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
  List<Widget> mainSwipeList = List<Widget>();
  MakePageView makePageView = MakePageView();
  HomePageView homePageView = HomePageView();
  PlayPageView playPageView = PlayPageView();
  SwiperCustomPagination pagenation = SwiperCustomPagination(
      builder: (BuildContext context, SwiperPluginConfig config) {
    return new Container();
  });
  SwiperController swipercontroller = SwiperController();

  Swiper swiper;

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
        GolobalStateContainer.of(context).state.userInfoMain = null;
        setState(() {});
      } else {
        GolobalStateContainer.of(context).state.userInfoMain =
            await UserInfoMain.getUserInfoMain(firebaseUser);
        print(GolobalStateContainer.of(context).state.userInfoMain.uid);
        setState(() {});
      }
    });
  }

  Widget loginButton() {
    if (GolobalStateContainer.of(context).state.userInfoMain == null) {
      return Text(
        "Log in",
        style: TextStyle(fontSize: 15),
      );
    } else {
      return Container(
          child: CircleAvatar(
        backgroundImage: NetworkImage(GolobalStateContainer.of(context)
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
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return LoginPageView();
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
