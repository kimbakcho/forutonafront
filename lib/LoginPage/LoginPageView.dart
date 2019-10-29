import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:forutonafront/Auth/UserInfo.dart' as forutona;
import 'package:forutonafront/Preference.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'Component/SnsLoginDataLogic.dart';
import 'SignIn1View.dart';

class LoginPageView extends StatefulWidget {
  LoginPageView({Key key}) : super(key: key);

  _LoginPageViewState createState() => _LoginPageViewState();
}

class _LoginPageViewState extends State<LoginPageView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          titleSpacing: 0,
          leading: Container(
            padding: EdgeInsets.all(10),
            child: RaisedButton(
              child: Text("<"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
        body: new Builder(builder: (context) {
          return Container(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height * 0.1, 20, 10),
            child: ListView(
              children: <Widget>[
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                      hintText: 'ID(Email)',
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0)))),
                ),
                Container(
                  height: 10,
                ),
                TextFormField(
                  obscureText: true,
                  controller: passController,
                  decoration: InputDecoration(
                      hintText: 'password',
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0)))),
                ),
                Container(
                  height: 20,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.09,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0)),
                    child: Text(
                      "Log-in",
                      style: TextStyle(fontSize: 25),
                    ),
                    onPressed: () async {
                      await _auth
                          .signInWithEmailAndPassword(
                              email: emailController.text,
                              password: passController.text)
                          .catchError((value) {
                        print(value);
                        if (value.toString().indexOf("ERROR_WRONG_PASSWORD") >=
                            0) {
                          final snackBar = SnackBar(
                            content: Text("PassWord가 잘못 되었습니다."),
                            duration: Duration(milliseconds: 1000),
                          );
                          Scaffold.of(context).showSnackBar(snackBar);
                          return;
                        } else if (value
                                .toString()
                                .indexOf("ERROR_USER_NOT_FOUND") >=
                            0) {
                          final snackBar = SnackBar(
                            content: Text("User를 찾을수 없습니다."),
                            duration: Duration(milliseconds: 1000),
                          );
                          Scaffold.of(context).showSnackBar(snackBar);
                          return;
                        }
                      });

                      Navigator.popUntil(context, ModalRoute.withName('/'));
                    },
                  ),
                ),
                Container(
                  height: 20,
                ),
                Container(
                  alignment: Alignment(1, 0),
                  child: GestureDetector(
                    child: Text(
                      "아직 회원이 아니신가요?",
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.blue),
                    ),
                    onTap: () async {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        var userinfo = new forutona.UserInfo();
                        return SignInView(
                            userinfo: userinfo, loginpage: "Email");
                      }));
                    },
                  ),
                ),
                Container(
                  height: 20,
                ),
                Container(
                  alignment: Alignment(1, 0),
                  child: GestureDetector(
                    child: Text("혹시, 패스워드를 잃어버렸나요?",
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.blue)),
                    onTap: () {},
                  ),
                ),
                Container(
                  height: 30,
                ),
                Divider(
                  thickness: 3,
                ),
                Container(
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0)),
                    child: Text(
                      "네이버 로그인",
                      style: TextStyle(fontSize: 25),
                    ),
                    onPressed: () async {
                      var userinfo = new forutona.UserInfo();
                      bool loginresult = await SnsLoginDataLogic.snsLogins(
                          SnsLoginDataLogic.naver, userinfo);
                      if (!loginresult) {
                        return;
                      }
                      var queryParameters = {
                        'Uid': userinfo.uid,
                      };
                      var uri = Preference.httpurloption(
                          Preference.baseBackEndUrl,
                          '/api/v1/Auth/GetUid',
                          queryParameters);
                      var response = await http.get(uri);
                      String getuid = response.body;

                      if (userinfo.uid == getuid) {
                        String customtoken =
                            await forutona.UserInfo.getCustomToken(userinfo);
                        await _auth.signInWithCustomToken(token: customtoken);
                        Navigator.popUntil(context, ModalRoute.withName('/'));
                      } else {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return SignInView(
                            userinfo: userinfo,
                            loginpage: SnsLoginDataLogic.naver,
                          );
                        }));
                      }
                    },
                  ),
                ),
                Container(
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0)),
                    child: Text("KaKao 로그인", style: TextStyle(fontSize: 25)),
                    onPressed: () async {
                      var userinfo = new forutona.UserInfo();
                      bool loginresult = await SnsLoginDataLogic.snsLogins(
                          SnsLoginDataLogic.kakao, userinfo);
                      if (!loginresult) {
                        return;
                      }
                      var queryParameters = {
                        'Uid': userinfo.uid,
                      };
                      var uri = Preference.httpurloption(
                          Preference.baseBackEndUrl,
                          '/api/v1/Auth/GetUid',
                          queryParameters);
                      var response = await http.get(uri);
                      String getuid = response.body;

                      if (userinfo.uid == getuid) {
                        String customtoken =
                            await forutona.UserInfo.getCustomToken(userinfo);
                        await _auth.signInWithCustomToken(token: customtoken);
                        Navigator.popUntil(context, ModalRoute.withName('/'));
                      } else {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return SignInView(
                            userinfo: userinfo,
                            loginpage: SnsLoginDataLogic.kakao,
                          );
                        }));
                      }
                    },
                  ),
                ),
                Container(
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0)),
                    child: Text("FaceBook 로그인", style: TextStyle(fontSize: 25)),
                    onPressed: () async {
                      var userinfo = new forutona.UserInfo();
                      bool loginresult = await SnsLoginDataLogic.snsLogins(
                          SnsLoginDataLogic.facebook, userinfo);
                      if (!loginresult) {
                        return;
                      }
                      var queryParameters = {
                        'Uid': userinfo.uid,
                      };
                      var uri = Preference.httpurloption(
                          Preference.baseBackEndUrl,
                          '/api/v1/Auth/GetUid',
                          queryParameters);
                      var response = await http.get(uri);
                      String getuid = response.body;
                      if (userinfo.uid == getuid) {
                        String customtoken =
                            await forutona.UserInfo.getCustomToken(userinfo);
                        await _auth.signInWithCustomToken(token: customtoken);
                        Navigator.popUntil(context, ModalRoute.withName('/'));
                      } else {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return SignInView(
                            userinfo: userinfo,
                            loginpage: SnsLoginDataLogic.facebook,
                          );
                        }));
                      }
                    },
                  ),
                )
              ],
            ),
          );
        }));
  }
}
