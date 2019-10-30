import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:forutonafront/Auth/UserInfoMain.dart';
import 'package:forutonafront/globals.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';

import 'MainPage/Component/HomeNavi.dart';
import 'MainPage/Component/HomeNaviInter.dart';
import 'LoginPage/LoginPageView.dart';

import 'package:flutter_kakao_login/flutter_kakao_login.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'Preference.dart';

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

    FirebaseAuth.instance.onAuthStateChanged.listen((firebaseUser) {
      currentuser = firebaseUser;
      if (firebaseUser == null) {
        print("test");

        setState(() {});
      } else {
        print(firebaseUser.uid);
        setState(() {});
      }
    });
  }

  Widget loginButton() {
    if (currentuser == null) {
      return Text(
        "Log in",
        style: TextStyle(fontSize: 15),
      );
    } else {
      return Text(
        "Log on",
        style: TextStyle(fontSize: 15),
      );
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

                      try {
                        bool value = await FlutterNaverLogin.isLoggedIn;
                        if (value) {
                          NaverAccessToken token =
                              await FlutterNaverLogin.currentAccessToken;
                          String token1 = token.accessToken;

                          // await FlutterNaverLogin.logOut();
                        }
                        print(value);
                      } catch (ex) {
                        print(ex.toString());
                      }
                    },
                  ),
                )
              ],
            )),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: DrawerHeader(
                    child: Center(child: Text('여기에 사진')),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                    ),
                  )),
              Container(
                height: 30,
                child: FlatButton(
                  child: Container(
                    alignment: Alignment(-1, 0),
                    child: Text("프로필 수정"),
                  ),
                  onPressed: () {},
                ),
              ),
              Divider(
                color: Colors.black,
              ),
              Container(
                height: 30,
                child: FlatButton(
                  child: Container(
                    alignment: Alignment(-1, 0),
                    child: Text("포인트 상세내역"),
                  ),
                  onPressed: () {},
                ),
              ),
              Divider(
                color: Colors.black,
              ),
              Container(
                height: 30,
                child: FlatButton(
                  child: Container(
                    alignment: Alignment(-1, 0),
                    child: Text("설정"),
                  ),
                  onPressed: () {},
                ),
              ),
              Divider(
                color: Colors.black,
              ),
              Container(
                height: 30,
                child: FlatButton(
                  child: Container(
                    alignment: Alignment(-1, 0),
                    child: Text("고객센터"),
                  ),
                  onPressed: () {},
                ),
              ),
              Divider(
                color: Colors.black,
              ),
            ],
          ),
        ),
        body: Container(
            child: RaisedButton(
                child: Text("tset"),
                onPressed: () async {
                  UserInfoMain.uploadWithGetProfileimage();
                })));
  }
}
