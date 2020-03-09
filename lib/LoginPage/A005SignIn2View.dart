import 'package:firebase_auth/firebase_auth.dart';
import 'package:forutonafront/Auth/UserInfoMain.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/Common/LoadingOverlay.dart';
import 'package:forutonafront/LoginPage/A006SignIn3View.dart';
import 'package:forutonafront/LoginPage/Component/VaildTextFromField.dart';
import 'package:loading/indicator/ball_scale_indicator.dart';
import 'package:loading/loading.dart';

class A005SignIn2View extends StatefulWidget {
  A005SignIn2View({this.userinfomain, Key key}) : super(key: key);
  final UserInfoMain userinfomain;

  @override
  _A005SignIn2ViewState createState() {
    return _A005SignIn2ViewState(userinfomain: this.userinfomain);
  }
}

class _A005SignIn2ViewState extends State<A005SignIn2View> {
  _A005SignIn2ViewState({this.userinfomain});
  UserInfoMain userinfomain;

  VaildTextFromFieldItem emailvailditem;
  VaildTextFromFieldItem pass1vailditem;
  VaildTextFromFieldItem pass2vailditem;

  bool isnext = false;

  bool isemailvaild = false;
  bool isloading = false;
  @override
  void initState() {
    super.initState();
    emailvailditem = VaildTextFromFieldItem(
        hintText: "아이디(이메일주소)",
        inputtype: TextInputType.emailAddress,
        obscureText: false,
        onchange: (value) {
          this.onchange(value);
        },
        validator: (value) {
          Pattern pattern =
              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
          RegExp regex = new RegExp(pattern);
          if (!regex.hasMatch(value))
            return '';
          else
            return null;
        });
    pass1vailditem = VaildTextFromFieldItem(
        hintText: "비밀번호 입력",
        onchange: (value) {
          this.onchange(value);
        },
        obscureText: true,
        validator: (value) {
          RegExp regExp = new RegExp(
              r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

          if (value.length < 8) {
            return "패스워드는 최소 8자 이상";
          } else if (regExp.hasMatch(value)) {
            return "영문 소문자,대문자,숫자,특수문자 중 3개 이상 조합";
          } else {
            return null;
          }
        });
    pass2vailditem = VaildTextFromFieldItem(
        hintText: "비밀번호 확인",
        onchange: (value) {
          this.onchange(value);
        },
        obscureText: true,
        validator: (value) {
          if (pass1vailditem.text != value) {
            return "패스워드가 다릅니다.";
          } else {
            return null;
          }
        });
  }

  onchange(value) {
    if (emailvailditem.validator(emailvailditem.text) == null &&
        pass1vailditem.validator(pass1vailditem.text) == null &&
        pass2vailditem.validator(pass2vailditem.text) == null) {
      isnext = true;
      setState(() {});
    } else {
      isnext = false;
      setState(() {});
    }
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
                  title: Text("가입하기",
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
                                    isloading = true;
                                    setState(() {});
                                    userinfomain.email = emailvailditem.text;
                                    userinfomain.password = pass1vailditem.text;
                                    List<String> authitems = await FirebaseAuth
                                        .instance
                                        .fetchSignInMethodsForEmail(
                                            email: userinfomain.email);
                                    isloading = false;
                                    setState(() {});
                                    if (authitems.length > 0) {
                                      isemailvaild = true;
                                      setState(() {});
                                    } else {
                                      isemailvaild = false;
                                      setState(() {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return A006SignIn3View(
                                              userinfomain: userinfomain);
                                        }));
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
                  child: Column(
                    children: <Widget>[
                      Expanded(
                          child: Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  color: Color(0xFFE4E7E8),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(16.00),
                                      topRight: Radius.circular(16.00))),
                              child:
                                  ListView(shrinkWrap: true, children: <Widget>[
                                SizedBox(
                                  height: 32,
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(32, 0, 32, 21),
                                  child: Text(
                                    "아이디는 실제 사용하시는 이메일로 작성해주세요. \n 패스워드 분실시 복구에 사용됩니다.",
                                    style: TextStyle(
                                      fontFamily: "Noto Sans CJK KR",
                                      fontSize: 14,
                                      color: Color(0xff78849e),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(32, 0, 32, 0),
                                  height: 50,
                                  child:
                                      VaildTextFromField(item: emailvailditem),
                                ),
                                !isemailvaild
                                    ? SizedBox(
                                        height: 21,
                                      )
                                    : Container(
                                        alignment: Alignment.centerLeft,
                                        margin:
                                            EdgeInsets.fromLTRB(48, 10, 0, 21),
                                        child: Text("*이미 존재하는 아이디 입니다.",
                                            style: TextStyle(
                                              fontFamily: "Noto Sans CJK KR",
                                              fontSize: 14,
                                              color: Color(0xffff4f9a),
                                            )),
                                      ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(32, 0, 32, 0),
                                  height: 50,
                                  child:
                                      VaildTextFromField(item: pass1vailditem),
                                ),
                                SizedBox(
                                  height: 21,
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(32, 0, 32, 21),
                                  height: 50,
                                  child:
                                      VaildTextFromField(item: pass2vailditem),
                                )
                              ])))
                    ],
                  ),
                ),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerDocked,
                floatingActionButton: Container(
                  height: 10,
                  child: LinearProgressIndicator(
                    value: 0.75,
                    backgroundColor: Color(0xffCCCCCC),
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Color(0xFF39F999)),
                  ),
                ))));
  }
}
