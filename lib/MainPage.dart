import 'package:carousel_slider/carousel_slider.dart';
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

  int _swipecurrent = 1;
  CarouselSlider currentCarouselSlider;
  @override
  void initState() {
    super.initState();
    naviitme = HomeNaviInter();

    homenavi = HomeNavi(
      parentitem: naviitme,
      onclickbutton: (String btnmode) => {
        if (btnmode == HomeNaviInter.makeMode)
          {
            currentCarouselSlider.animateToPage(-1,
                duration: Duration(milliseconds: 300), curve: Curves.linear)
          }
        else if (btnmode == HomeNaviInter.homeMode)
          {
            currentCarouselSlider.animateToPage(0,
                duration: Duration(milliseconds: 300), curve: Curves.linear)
          }
        else if (btnmode == HomeNaviInter.palyMode)
          {
            currentCarouselSlider.animateToPage(1,
                duration: Duration(milliseconds: 300), curve: Curves.linear)
          }
      },
    );

    Future.delayed(Duration.zero, () {
      currentCarouselSlider = CarouselSlider(
        height: MediaQuery.of(context).size.height,
        viewportFraction: 1.0,
        initialPage: 1,
        items: mainSwipeList,
        onPageChanged: (index) {
          setState(() {
            if (index == 0) {
              homenavi.setPosition(HomeNaviInter.makeMode);
            } else if (index == 1) {
              homenavi.setPosition(HomeNaviInter.homeMode);
            } else if (index == 2) {
              homenavi.setPosition(HomeNaviInter.palyMode);
            }

            _swipecurrent = index;
          });
        },
      );
    });
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
    mainSwipeList.add(makePageView);
    mainSwipeList.add(homePageView);
    mainSwipeList.add(playPageView);
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
            child: currentCarouselSlider));
  }
}
