import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/Auth/UserInfoMain.dart';
import 'package:forutonafront/Common/LoadingOverlay.dart';
import 'package:forutonafront/LoginPage/A009PhoneAuthSetp2.dart';
import 'package:forutonafront/LoginPage/Component/VaildTextFromField.dart';
import 'package:loading/indicator/ball_scale_indicator.dart';
import 'package:loading/loading.dart';

class A008PhoneAuthStep1 extends StatefulWidget {
  A008PhoneAuthStep1({Key key}) : super(key: key);

  @override
  _A008PhoneAuthStep1State createState() => _A008PhoneAuthStep1State();
}

class _A008PhoneAuthStep1State extends State<A008PhoneAuthStep1> {
  bool isnext = false;
  VaildTextFromFieldItem emailvailditem;
  bool isloading = false;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    emailvailditem = VaildTextFromFieldItem(
        inputtype: TextInputType.emailAddress,
        onchange: (value) {
          if (value.length > 0) {
            isnext = true;
          } else {
            isnext = false;
          }
          if (emailvailditem.validator(value) == null) {
          } else {}
          setState(() {});
        },
        obscureText: false,
        validator: (value) {
          Pattern pattern =
              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
          RegExp regex = new RegExp(pattern);
          if (!regex.hasMatch(value))
            return '이메일 형식이 아닙니다.';
          else
            return null;
        },
        hintText: "아이디(이메일 주소)");
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
      child: LoadingOverlay(
        isLoading: isloading,
        progressIndicator: Loading(
            indicator: BallScaleIndicator(),
            size: 100.0,
            color: Theme.of(context).accentColor),
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              automaticallyImplyLeading: false,
              titleSpacing: 0.0,
              title: Text("휴대폰 인증하기",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Noto Sans CJK KR',
                      fontSize: 20)),
              leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
              actions: <Widget>[
                isnext
                    ? Container(
                        alignment: Alignment.centerRight,
                        margin: EdgeInsets.only(right: 16),
                        child: Container(
                          height: 37.00,
                          width: 67.00,
                          decoration: BoxDecoration(
                              color: Color(0xFF454F63),
                              border: Border.all(
                                width: 2.00,
                                color: Theme.of(context).primaryColor,
                              ),
                              borderRadius: BorderRadius.circular(30.00)),
                          child: FlatButton(
                              child: Text(
                                "다음",
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontFamily: 'Noto Sans CJK KR',
                                    fontSize: 16),
                              ),
                              onPressed: () async {
                                if (!_formKey.currentState.validate()) {
                                  return;
                                }
                                isloading = true;
                                setState(() {});
                                UserInfoMain userInfoMain = UserInfoMain();
                                userInfoMain.email = emailvailditem.text;

                                List<String> authitems = await FirebaseAuth
                                    .instance
                                    .fetchSignInMethodsForEmail(
                                        email: userInfoMain.email);
                                isloading = false;
                                setState(() {});
                                if (authitems.length > 0) {
                                  userInfoMain.uid =
                                      await UserInfoMain.getEmailtoUid(
                                          userInfoMain.email);
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) {
                                    return A009PhoneAuthSetp2(
                                        userInfoMain: userInfoMain);
                                  }));
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                new BorderRadius.circular(16.0),
                                          ),
                                          title: Container(
                                            child: Text("계정 정보 오류",
                                                style: TextStyle(
                                                  fontFamily:
                                                      "Noto Sans CJK KR",
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 20,
                                                  color: Color(0xff000000),
                                                )),
                                          ),
                                          content: Container(
                                            height: 80,
                                            child: Column(
                                              children: <Widget>[
                                                Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                      "입력하신 정보와 일치하는 계정이 없습니다.",
                                                      style: TextStyle(
                                                        fontFamily:
                                                            "Noto Sans CJK KR",
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        fontSize: 14,
                                                        color:
                                                            Color(0xff454f63),
                                                      )),
                                                ),
                                                SizedBox(
                                                  height: 21,
                                                ),
                                                Container(
                                                    child: FlatButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: Text("확인",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "Noto Sans CJK KR",
                                                                fontSize: 15,
                                                                color: Theme.of(
                                                                        context)
                                                                    .primaryColor))),
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    height: 36.00,
                                                    decoration: BoxDecoration(
                                                      color: Color(0xff454f63),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12.00),
                                                    ))
                                              ],
                                            ),
                                          ),
                                        );
                                      });
                                }
                              }),
                        ))
                    : Container(
                        alignment: Alignment.centerRight,
                        margin: EdgeInsets.only(right: 16),
                        child: Container(
                          height: 37.00,
                          width: 67.00,
                          decoration: BoxDecoration(
                              border: Border.all(
                                width: 2.00,
                                color: Color(0xffcccccc),
                              ),
                              borderRadius: BorderRadius.circular(30.00)),
                          child: FlatButton(
                            child: Text(
                              "다음",
                              style: TextStyle(
                                  color: Color(0xff999999),
                                  fontFamily: 'Noto Sans CJK KR',
                                  fontSize: 16),
                            ),
                            onPressed: () async {},
                          ),
                        ))
              ],
            ),
            backgroundColor: Colors.transparent,
            body: Container(
                child: Column(children: <Widget>[
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Color(0xFFE4E7E8),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16.00),
                          topRight: Radius.circular(16.00))),
                  child: ListView(
                    shrinkWrap: true,
                    children: <Widget>[
                      SizedBox(
                        height: 32,
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(32, 0, 0, 32),
                        alignment: Alignment.centerLeft,
                        child: Text("현재 사용중이신 계정 이메일 주소를\n입력해주세요.",
                            style: TextStyle(
                              fontFamily: "Noto Sans CJK KR",
                              fontSize: 14,
                              color: Color(0xff78849e),
                            )),
                      ),
                      Container(
                          height: 150,
                          margin: EdgeInsets.fromLTRB(32, 0, 32, 0),
                          width: MediaQuery.of(context).size.width,
                          child: Form(
                            key: _formKey,
                            child: VaildTextFromField(
                              item: emailvailditem,
                            ),
                          ))
                    ],
                  ),
                ),
              )
            ])),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: Container(
              height: 10,
              child: LinearProgressIndicator(
                value: 0.34,
                backgroundColor: Color(0xffCCCCCC),
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF39F999)),
              ),
            )),
      ),
    );
  }
}
