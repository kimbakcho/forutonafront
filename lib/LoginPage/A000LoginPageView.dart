import 'package:flutter/material.dart';
import 'package:forutonafront/Auth/UserInfoMain.dart';
import 'package:forutonafront/LoginPage/A001LoginPageView.dart';
import 'package:forutonafront/LoginPage/A002SignIn1View.dart';
import 'package:forutonafront/LoginPage/Component/SignInItem.dart';
import 'package:forutonafront/LoginPage/Component/SnsLoginDataLogic.dart';

class A000LoginPageView extends StatefulWidget {
  A000LoginPageView({Key key}) : super(key: key);

  _A000LoginPageViewState createState() => _A000LoginPageViewState();
}

class _A000LoginPageViewState extends State<A000LoginPageView> {
  bool isjoinflowflag = false;
  UserInfoMain userInfoMain = new UserInfoMain();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color(0xFF606060), Color(0xFF0E1014)]),
            image: DecorationImage(
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.5), BlendMode.dstATop),
                fit: BoxFit.cover,
                image: AssetImage("assets/MainImage/map-846083_1920.png"))),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
              child: Column(
            children: <Widget>[
              SizedBox(
                height: 80,
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  "lladball",
                  style: TextStyle(
                      color: Colors.white, fontFamily: "Gibson", fontSize: 33),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  "우리의 세상을 흥미롭게!",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: "NotoSansKR",
                      fontSize: 20),
                ),
              ),
              Expanded(
                child: Container(),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    !isjoinflowflag
                        ? Container(
                            height: 43.00,
                            margin: EdgeInsets.fromLTRB(32, 0, 32, 0),
                            decoration: BoxDecoration(
                              color: Color(0xff454f63),
                              border: Border.all(
                                width: 1.00,
                                color: Color(0xff39f999),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(0.00, 3.00),
                                  color: Color(0xff000000).withOpacity(0.16),
                                  blurRadius: 6,
                                ),
                              ],
                              borderRadius: BorderRadius.circular(7.00),
                            ),
                            child: FlatButton(
                                onPressed: () {
                                  isjoinflowflag = !isjoinflowflag;
                                  setState(() {});
                                  // Navigator.of(context).push(
                                  //     MaterialPageRoute(builder: (context) {
                                  //   return A002SignIn1View();
                                  // }));
                                },
                                child: Container(
                                    child: Center(
                                        child: Text(
                                  "회원가입",
                                  style: TextStyle(
                                      fontFamily: 'NotoSansKR',
                                      fontSize: 14,
                                      color: Color(0xff39F999)),
                                )))),
                          )
                        : Container(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  height: 43.00,
                                  margin: EdgeInsets.fromLTRB(32, 0, 32, 0),
                                  decoration: BoxDecoration(
                                    color: Color(0xff454f63),
                                    border: Border.all(
                                      width: 1.00,
                                      color: Color(0xff39f999),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        offset: Offset(0.00, 3.00),
                                        color:
                                            Color(0xff000000).withOpacity(0.16),
                                        blurRadius: 6,
                                      ),
                                    ],
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(7.0),
                                      topRight: Radius.circular(7.0),
                                    ),
                                  ),
                                  child: FlatButton(
                                      onPressed: () {
                                        isjoinflowflag = !isjoinflowflag;
                                        setState(() {});
                                        // Navigator.of(context).push(
                                        //     MaterialPageRoute(
                                        //         builder: (context) {
                                        //   return A002SignIn1View();
                                        // }));
                                      },
                                      child: Container(
                                          child: Center(
                                              child: Text(
                                        "회원가입",
                                        style: TextStyle(
                                            fontFamily: 'NotoSansKR',
                                            fontSize: 14,
                                            color: Color(0xff39F999)),
                                      )))),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xffffffff).withOpacity(0.80),
                                    boxShadow: [
                                      BoxShadow(
                                        offset: Offset(0.00, 3.00),
                                        color:
                                            Color(0xff000000).withOpacity(0.13),
                                        blurRadius: 6,
                                      ),
                                    ],
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(12.00),
                                      bottomRight: Radius.circular(12.00),
                                    ),
                                  ),
                                  width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsets.fromLTRB(32, 0, 32, 0),
                                  child: Column(
                                    children: <Widget>[
                                      SizedBox(height: 31),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        margin:
                                            EdgeInsets.fromLTRB(31, 0, 31, 0),
                                        decoration: BoxDecoration(
                                          color: Color(0xff78849e),
                                          boxShadow: [
                                            BoxShadow(
                                              offset: Offset(0.00, 12.00),
                                              color: Color(0xff455b63)
                                                  .withOpacity(0.10),
                                              blurRadius: 16,
                                            ),
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(12.00),
                                        ),
                                        child: FlatButton(
                                            onPressed: () {
                                              userInfoMain.snsservice =
                                                  SnsLoginDataLogic.email;
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) {
                                                return A002SignIn1View(
                                                    userinfomain: userInfoMain);
                                              }));
                                            },
                                            child: Text("이메일로 가입하기",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: 'NotoSansKR',
                                                    fontSize: 14))),
                                      ),
                                      SizedBox(height: 51),
                                      Container(
                                          child: new Text(
                                        "소셜계정으로 가입하기",
                                        style: TextStyle(
                                          fontFamily: "NotoSansKR",
                                          fontSize: 14,
                                          color: Color(0xff78849e),
                                        ),
                                      )),
                                      SizedBox(height: 17),
                                      Container(
                                          margin:
                                              EdgeInsets.fromLTRB(0, 0, 0, 31),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Container(
                                                margin:
                                                    EdgeInsets.only(right: 30),
                                                height: 36,
                                                width: 36,
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        image: AssetImage(
                                                            "assets/MainImage/facebookicon.png"))),
                                                child: FlatButton(
                                                  child: Container(),
                                                  onPressed: () {
                                                    userInfoMain.snsservice =
                                                        SnsLoginDataLogic
                                                            .facebook;
                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                            builder: (context) {
                                                      return A002SignIn1View(
                                                          userinfomain:
                                                              userInfoMain);
                                                    }));
                                                  },
                                                ),
                                              ),
                                              Container(
                                                margin:
                                                    EdgeInsets.only(right: 30),
                                                height: 36,
                                                width: 36,
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        image: AssetImage(
                                                            "assets/MainImage/kakaotalkicon.png"))),
                                                child: FlatButton(
                                                  child: Container(),
                                                  onPressed: () {
                                                    userInfoMain.snsservice =
                                                        SnsLoginDataLogic.kakao;
                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                            builder: (context) {
                                                      return A002SignIn1View(
                                                          userinfomain:
                                                              userInfoMain);
                                                    }));
                                                  },
                                                ),
                                              ),
                                              Container(
                                                height: 36,
                                                width: 36,
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        image: AssetImage(
                                                            "assets/MainImage/navericon.png"))),
                                                child: FlatButton(
                                                  child: Container(),
                                                  onPressed: () {
                                                    userInfoMain.snsservice =
                                                        SnsLoginDataLogic.naver;
                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                            builder: (context) {
                                                      return A002SignIn1View(
                                                          userinfomain:
                                                              userInfoMain);
                                                    }));
                                                  },
                                                ),
                                              )
                                            ],
                                          ))
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                    SizedBox(height: 21),
                    Container(
                        child: GestureDetector(
                            child: Container(
                              alignment: Alignment.center,
                              child: Text(
                                "이미 회원이신가요? 로그인하기",
                                style: TextStyle(
                                  fontFamily: 'NotoSansKR',
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            onTap: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return A001LoginPageView();
                              }));
                            })),
                    SizedBox(height: 21),
                    Container(
                        child: GestureDetector(
                            child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        "나중에하기",
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontFamily: 'NotoSansKR',
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ))),
                    SizedBox(height: 27),
                  ],
                ),
              )
            ],
          )),
        ));
  }
}
