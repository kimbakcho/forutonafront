import 'package:flutter/material.dart';
import 'package:forutonafront/Auth/UserInfoMain.dart';
import 'package:forutonafront/LoginPage/Component/SnsLoginDataLogic.dart';

import 'package:forutonafront/LoginPage/ForutonaAgreeView.dart';
import 'package:forutonafront/LoginPage/PhoneAuthView.dart';

import 'PrivateAgreeView.dart';

import 'SignIn3View.dart';

class SignInView extends StatefulWidget {
  final String loginpage;
  final UserInfoMain userinfo;
  SignInView({Key key, this.loginpage, this.userinfo}) : super(key: key);

  @override
  _SignInViewState createState() {
    return _SignInViewState(loginpage, userinfo);
  }
}

class _SignInViewState extends State<SignInView> {
  String loginpage;
  UserInfoMain userInfo;
  _SignInViewState(this.loginpage, this.userInfo);

  bool _allCheckvalue = false;
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
        //SneckBar 로인해서 Builder로 Context 넘겨줌
        body: new Builder(builder: (context) {
          return Container(
            margin: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height * 0.1, 20, 20),
            child: ListView(
              children: <Widget>[
                Container(
                    child: Text("환영합니다!. \n포루투나 회원이 되기 위해서는 약관 동의가 필요해요!")),
                Container(height: 20),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text("전체 동의"),
                    ),
                    Checkbox(
                      value: _allCheckvalue,
                      onChanged: (bool value) {
                        setState(() {
                          _allCheckvalue = value;
                          userInfo.forutonaagree = value ? 1 : 0;
                          userInfo.privateagree = value ? 1 : 0;
                          userInfo.positionagree = value ? 1 : 0;
                          userInfo.martketingagree = value ? 1 : 0;
                          userInfo.agelimitagree = value ? 1 : 0;
                        });
                      },
                    )
                  ],
                ),
                Divider(
                  indent: 5,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                        child: Container(
                      child: GestureDetector(
                        child: Text("포루투나 이용약관 동의",
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                            )),
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return ForutonaAgreeView();
                          }));
                        },
                      ),
                    )),
                    Checkbox(
                      value: userInfo.forutonaagree == 1 ? true : false,
                      onChanged: (bool value) {
                        setState(() {
                          userInfo.forutonaagree = value ? 1 : 0;
                        });
                      },
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                        child: Container(
                      child: GestureDetector(
                        child: Text("개인 정보 수집이용 동의",
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                            )),
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return PrivateAgreeView();
                          }));
                        },
                      ),
                    )),
                    Checkbox(
                      value: userInfo.privateagree == 1 ? true : false,
                      onChanged: (bool value) {
                        setState(() {
                          userInfo.privateagree = value ? 1 : 0;
                        });
                      },
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                        child: Container(
                      child: GestureDetector(
                        child: Text("위치정보 활용 동의",
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                            )),
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return PrivateAgreeView();
                          }));
                        },
                      ),
                    )),
                    Checkbox(
                      value: userInfo.positionagree == 1 ? true : false,
                      onChanged: (bool value) {
                        setState(() {
                          userInfo.positionagree = value ? 1 : 0;
                        });
                      },
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                        child: Container(
                      child: GestureDetector(
                        child: Text(
                          "마케팅 정보 메일 SMS 수신 동의(선택)",
                        ),
                        onTap: () {},
                      ),
                    )),
                    Checkbox(
                      value: userInfo.martketingagree == 1 ? true : false,
                      onChanged: (bool value) {
                        setState(() {
                          userInfo.martketingagree = value ? 1 : 0;
                        });
                      },
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                        child: Container(
                      child: GestureDetector(
                        child: Text(
                          "만 14세 이상입니다.",
                        ),
                        onTap: () {},
                      ),
                    )),
                    Checkbox(
                      value: userInfo.agelimitagree == 1 ? true : false,
                      onChanged: (bool value) {
                        setState(() {
                          userInfo.agelimitagree = value ? 1 : 0;
                        });
                      },
                    )
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      SizedBox(
                        width: 80,
                        child: RaisedButton(
                          child: Text('다음'),
                          onPressed: () async {
                            if (userInfo.forutonaagree == 1 &&
                                userInfo.privateagree == 1 &&
                                userInfo.positionagree == 1 &&
                                userInfo.agelimitagree == 1) {
                              if (loginpage == SnsLoginDataLogic.email) {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return PhoneAuthView(userinfo: userInfo);
                                }));
                              } else {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return SignIn3View(
                                    loginpage: loginpage,
                                    userinfo: userInfo,
                                  );
                                }));
                              }
                            } else {
                              final snackBar = SnackBar(
                                content: Text("필수 항목이 체크 되지 않았습니다"),
                                duration: Duration(milliseconds: 1000),
                              );
                              Scaffold.of(context).showSnackBar(snackBar);
                            }
                          },
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        }));
  }
}
