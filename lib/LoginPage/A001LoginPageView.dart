import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter/services.dart';
import 'package:forutonafront/LoginPage/A007PasswordfindView.dart';

class A001LoginPageView extends StatefulWidget {
  A001LoginPageView({Key key}) : super(key: key);

  @override
  _A001LoginPageViewState createState() {
    return _A001LoginPageViewState();
  }
}

class _A001LoginPageViewState extends State<A001LoginPageView> {
  bool iskeyboardshow = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  double cardsize = null;
  @override
  void initState() {
    super.initState();
    KeyboardVisibilityNotification().addNewListener(
      onChange: (bool visible) {
        setState(() {
          this.iskeyboardshow = visible;
        });
      },
    );
  }

  Widget makemaincard() {
    return Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Color(0xFFE4E7E8),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.00),
                topRight: Radius.circular(16.00))),
        child: Column(children: <Widget>[
          SizedBox(
            height: 32,
          ),
          Container(
            height: 50,
            margin: EdgeInsets.fromLTRB(32, 0, 32, 21),
            child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                  hintText: "아이디(이메일 주소)",
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                )),
          ),
          Container(
            height: 50,
            margin: EdgeInsets.fromLTRB(32, 0, 32, 21),
            child: TextFormField(
                controller: passController,
                obscureText: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                  hintText: "비밀번호 입력",
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                )),
          ),
          Container(
            height: 43.00,
            margin: EdgeInsets.fromLTRB(32, 0, 32, 32),
            decoration: BoxDecoration(
              color: Color(0xff78849e),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0.00, 12.00),
                  color: Color(0xff455b63).withOpacity(0.10),
                  blurRadius: 16,
                ),
              ],
              borderRadius: BorderRadius.circular(12.00),
            ),
            child: FlatButton(
                onPressed: () async {
                  try {
                    await _auth.signInWithEmailAndPassword(
                        email: emailController.text,
                        password: passController.text);
                    Navigator.popUntil(context, ModalRoute.withName('/'));
                  } catch (value) {
                    PlatformException excode = value as PlatformException;
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(16.0),
                            ),
                            title: Container(
                              child: Text("로그인 실패",
                                  style: TextStyle(
                                    fontFamily: "NotoSansKR",
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                    color: Color(0xff000000),
                                  )),
                            ),
                            content: Container(
                                height: 110,
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      child: Text(excode.message),
                                    ),
                                    SizedBox(height: 16),
                                    Container(
                                        child: FlatButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text(
                                            "확인",
                                            style: TextStyle(
                                                fontFamily: "NotoSansKR",
                                                fontSize: 15,
                                                color: Theme.of(context)
                                                    .primaryColor),
                                          ),
                                        ),
                                        height: 36.00,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                          color: Color(0xff454f63),
                                          borderRadius:
                                              BorderRadius.circular(12.00),
                                        )),
                                  ],
                                )),
                          );
                        });
                    return;
                  }
                },
                child: Container(
                    child: Center(
                        child: Text(
                  "로그인",
                  style: TextStyle(
                      fontFamily: 'NotoSansKR',
                      fontSize: 15,
                      color: Colors.white),
                )))),
          ),
          !iskeyboardshow
              ? Container(
                  margin: EdgeInsets.fromLTRB(32, 0, 32, 45),
                  child: GestureDetector(
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          "혹시 비밀번호를 분실하셧나요?",
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontFamily: 'NotoSansKR',
                            fontSize: 13,
                            color: Color(0xFFFF4F9A),
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return A007PasswordfindView();
                        }));
                      }))
              : Container(),
          !iskeyboardshow
              ? Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 17),
                  child: Text(
                    "소셜계정으로 로그인하기",
                    style: TextStyle(
                      fontFamily: 'NotoSansKR',
                      fontSize: 13,
                      color: Color(0xFF78849E),
                    ),
                  ),
                )
              : Container(),
          !iskeyboardshow
              ? Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(right: 30),
                        height: 36,
                        width: 36,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    "assets/MainImage/facebookicon.png"))),
                        child: FlatButton(
                          child: Container(),
                          onPressed: () {},
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 30),
                        height: 36,
                        width: 36,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    "assets/MainImage/kakaotalkicon.png"))),
                        child: FlatButton(
                          child: Container(),
                          onPressed: () {},
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
                          onPressed: () {},
                        ),
                      )
                    ],
                  ))
              : Container()
        ]));
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
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            titleSpacing: 0.0,
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
            title: Container(
                alignment: Alignment.centerLeft,
                child: !iskeyboardshow
                    ? Text("")
                    : Text("로그인하기",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'NotoSansKR',
                            fontWeight: FontWeight.w700,
                            fontSize: 24))),
            elevation: 0,
          ),
          body: Container(
            child: Column(
              children: <Widget>[
                !iskeyboardshow
                    ? Container(
                        alignment: Alignment.center,
                        child: Text(
                          "로그인하기",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'NotoSansKR',
                              fontWeight: FontWeight.w700,
                              fontSize: 24),
                        ),
                      )
                    : Container(),
                SizedBox(
                  height: 10,
                ),
                !iskeyboardshow
                    ? Container(
                        alignment: Alignment.center,
                        child: Text(
                          "라드볼을 만들기 위해서는 로그인이 필요합니다.",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'NotoSansKR',
                              fontSize: 13),
                        ),
                      )
                    : Container(),
                !iskeyboardshow
                    ? SizedBox(
                        height: 56,
                      )
                    : Container(),
                Expanded(
                  child: makemaincard(),
                ),
              ],
            ),
          )),
    );
  }
}
