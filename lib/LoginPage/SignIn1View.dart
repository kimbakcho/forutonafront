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
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          titleSpacing: 0,
          elevation: 0,
          leading: Container(
            child: FlatButton(
              child: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
        //SneckBar 로인해서 Builder로 Context 넘겨줌
        body: new Builder(builder: (context) {
          return Container(
            child: ListView(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: Text("환영합니다!",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  alignment: Alignment(0, 0),
                ),
                Container(
                    alignment: Alignment(0, 0),
                    child: Text("포루투나 회원이 되기 위해서는 약관 동의가 필요합니다!")),
                Container(
                  margin: EdgeInsets.fromLTRB(30, 30, 30, 15),
                  padding: EdgeInsets.fromLTRB(10, 0, 5, 0),
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(5.0)),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          "전체 동의",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
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
                ),
                Divider(
                  color: Colors.black,
                  indent: 30,
                  endIndent: 30,
                ),
                Container(
                    margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                    padding: EdgeInsets.all(0),
                    child: Row(children: <Widget>[
                      Expanded(
                          child: Container(
                        child: GestureDetector(
                          child: Text("포루투나 이용약관 동의",
                              style: TextStyle(
                                color: Color(0xFF4b4f98),
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
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          value: userInfo.forutonaagree == 1 ? true : false,
                          onChanged: (bool value) {
                            setState(() {
                              userInfo.forutonaagree = value ? 1 : 0;
                            });
                          })
                    ])),
                Container(
                    margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: Row(children: <Widget>[
                      Expanded(
                          child: Container(
                        child: GestureDetector(
                          child: Text("개인 정보 수집이용 동의",
                              style: TextStyle(
                                color: Color(0xFF4b4f98),
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
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        value: userInfo.privateagree == 1 ? true : false,
                        onChanged: (bool value) {
                          setState(() {
                            userInfo.privateagree = value ? 1 : 0;
                          });
                        },
                      )
                    ])),
                Container(
                    margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: Row(children: <Widget>[
                      Expanded(
                          child: Container(
                        child: GestureDetector(
                          child: Text("위치정보 활용 동의",
                              style: TextStyle(
                                color: Color(0xFF4b4f98),
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
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        value: userInfo.positionagree == 1 ? true : false,
                        onChanged: (bool value) {
                          setState(() {
                            userInfo.positionagree = value ? 1 : 0;
                          });
                        },
                      )
                    ])),
                Container(
                    padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: Row(children: <Widget>[
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
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          value: userInfo.martketingagree == 1 ? true : false,
                          onChanged: (bool value) {
                            setState(() {
                              userInfo.martketingagree = value ? 1 : 0;
                            });
                          })
                    ])),
                Container(
                    padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: Row(children: <Widget>[
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
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          value: userInfo.agelimitagree == 1 ? true : false,
                          onChanged: (bool value) {
                            setState(() {
                              userInfo.agelimitagree = value ? 1 : 0;
                            });
                          })
                    ])),
                Container(
                  alignment: Alignment(0, 0),
                  child: Text(
                    "포루투나는 만 14세 미만 아동의 회원가입을 제한하고 있습니다.",
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ),
                Container(
                    margin: EdgeInsets.fromLTRB(30, 30, 30, 0),
                    height: 60,
                    child: RaisedButton(
                        color: Theme.of(context).primaryColor,
                        child: Text(
                          '다음',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
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
                        }))
              ],
            ),
          );
        }));
  }
}
