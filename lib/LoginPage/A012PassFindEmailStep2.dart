import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:forutonafront/Auth/UserInfoMain.dart';
import 'package:forutonafront/Common/LoadingOverlay.dart';
import 'package:loading/indicator/ball_scale_indicator.dart';
import 'package:loading/loading.dart';

class A012PassFindEmailStep2 extends StatefulWidget {
  A012PassFindEmailStep2({this.userInfoMain, Key key}) : super(key: key);
  final UserInfoMain userInfoMain;

  @override
  _A012PassFindEmailStep2State createState() {
    return _A012PassFindEmailStep2State(userInfoMain: userInfoMain);
  }
}

class _A012PassFindEmailStep2State extends State<A012PassFindEmailStep2> {
  _A012PassFindEmailStep2State({this.userInfoMain});
  UserInfoMain userInfoMain;
  bool isloading = false;
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
                title: Text("패스워드 설정 메일 발송",
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
                    )),
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
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 32,
                        ),
                        Container(
                            margin: EdgeInsets.fromLTRB(32, 0, 32, 0),
                            alignment: Alignment.centerLeft,
                            child: RichText(
                              text: TextSpan(
                                  text: "${userInfoMain.email}",
                                  style: TextStyle(
                                    fontFamily: "Noto Sans CJK KR",
                                    fontSize: 14,
                                    color: Color(0xff3497FD),
                                  ),
                                  children: [
                                    TextSpan(
                                        text:
                                            "로 패스워드를 재설정하실 수 있는 \n 메일을 발송하였습니다.",
                                        style: TextStyle(
                                          fontFamily: "Noto Sans CJK KR",
                                          fontSize: 14,
                                          color: Color(0xff78849e),
                                        ))
                                  ]),
                            )),
                        SizedBox(
                          height: 21,
                        ),
                        Container(
                          height: 52.00,
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.fromLTRB(32, 0, 32, 0),
                          decoration: BoxDecoration(
                            color: Color(0xff454f63),
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0.00, 4.00),
                                color: Color(0xff455b63).withOpacity(0.08),
                                blurRadius: 16,
                              ),
                            ],
                            borderRadius: BorderRadius.circular(12.00),
                          ),
                          child: FlatButton(
                            onPressed: () {
                              Navigator.of(context).popUntil((value) {
                                return value.settings.name == "A001";
                              });
                            },
                            child: Text("로그인 페이지로 이동",
                                style: TextStyle(
                                  fontFamily: "Noto Sans CJK KR",
                                  fontSize: 15,
                                  color: Color(0xff39f999),
                                )),
                          ),
                        ),
                        SizedBox(
                          height: 32,
                        ),
                        Container(
                            margin: EdgeInsets.fromLTRB(32, 0, 32, 45),
                            child: GestureDetector(
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "혹시 인증 메일을 받지 못하셨나요?",
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      fontFamily: 'Noto Sans CJK KR',
                                      fontSize: 13,
                                      color: Color(0xFFFF4F9A),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                new BorderRadius.circular(16.0),
                                          ),
                                          title: Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text("인증메일을 받지 못하셨나요?",
                                                style: TextStyle(
                                                  fontFamily:
                                                      "Noto Sans CJK KR",
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 20,
                                                  color: Color(0xff000000),
                                                )),
                                          ),
                                          contentPadding: EdgeInsets.fromLTRB(
                                              16, 16, 16, 0),
                                          content: Container(
                                            height: 200,
                                            child: Column(
                                              children: <Widget>[
                                                Container(
                                                  child: Text(
                                                      "이메일을 올바르게 입력하셨는지 다시 한번 확\n인해 보세요.\n\n스팸편지함 혹은 휴지통을 확인해 보세요.\n메일 서비스에 따라 도착하기까지 다소 시간이 \n걸릴 수 있습니다.",
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
                                                Divider(),
                                                Row(
                                                  children: <Widget>[
                                                    Expanded(
                                                      child: FlatButton(
                                                        padding:
                                                            EdgeInsets.all(0),
                                                        onPressed: () async {
                                                          Navigator.of(context)
                                                              .pop();
                                                          isloading = true;
                                                          setState(() {});
                                                          await FirebaseAuth
                                                              .instance
                                                              .sendPasswordResetEmail(
                                                                  email:
                                                                      userInfoMain
                                                                          .email);
                                                          isloading = false;
                                                          Fluttertoast.showToast(
                                                              msg: "재전송 하였습니다.",
                                                              toastLength: Toast
                                                                  .LENGTH_SHORT,
                                                              gravity:
                                                                  ToastGravity
                                                                      .BOTTOM,
                                                              timeInSecForIos:
                                                                  1,
                                                              backgroundColor:
                                                                  Color(
                                                                      0xff454F63),
                                                              textColor:
                                                                  Colors.white,
                                                              fontSize: 12.0);
                                                          setState(() {});
                                                        },
                                                        child: Text(
                                                          "재발송",
                                                          style: TextStyle(
                                                            fontFamily:
                                                                "Noto Sans CJK KR",
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 15,
                                                            color: Color(
                                                                0xffff4f9a),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: FlatButton(
                                                        padding:
                                                            EdgeInsets.all(0),
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: Text(
                                                          "닫기",
                                                          style: TextStyle(
                                                            fontFamily:
                                                                "Noto Sans CJK KR",
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 15,
                                                            color: Color(
                                                                0xff454f63),
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      });
                                }))
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
                  value: 1,
                  backgroundColor: Color(0xffCCCCCC),
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF39F999)),
                ),
              ))),
    );
  }
}
