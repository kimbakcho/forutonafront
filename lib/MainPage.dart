import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:forutonafront/Auth/UserInfoMain.dart';
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

  @override
  void initState() {
    super.initState();
    naviitme = HomeNaviInter();

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

  // loginButton1() {
  //   return FutureBuilder(
  //       future: this.login_fetchData(),
  //       builder: (context, snapshot) {
  //         switch (snapshot.connectionState) {
  //           case ConnectionState.none:

  //           case ConnectionState.waiting:

  //           case ConnectionState.active:
  //             return CircularProgressIndicator();
  //             break;
  //           case ConnectionState.done:

  //             return Container();
  //             break;
  //         }
  //       });
  // }

  // login_fetchData() async {
  //   return this._memoizer.runOnce(() async {
  //     FirebaseUser currentuser = await _auth.currentUser();
  //     return currentuser;
  //   });
  // }

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
                    child: Center(
                      child: HomeNavi(
                        parentitem: naviitme,
                        onclickbutton: () => {},
                      ),
                    ),
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
            child: RaisedButton(
                child: Text("tset"),
                onPressed: () async {
                  UserInfoMain.uploadWithGetProfileimage();
                })));
  }
}
