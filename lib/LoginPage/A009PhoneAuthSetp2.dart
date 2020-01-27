import 'dart:async';

import 'package:flutter/material.dart';
import 'package:forutonafront/Auth/UserInfoMain.dart';
import 'package:forutonafront/Common/LoadingOverlay%20.dart';
import 'package:forutonafront/LoginPage/A010PhoneAuthStep3.dart';
import 'package:international_phone_input/international_phone_input.dart';
import 'package:loading/indicator/ball_scale_indicator.dart';
import 'package:loading/loading.dart';
import 'package:sms_receiver/sms_receiver.dart';

class A009PhoneAuthSetp2 extends StatefulWidget {
  A009PhoneAuthSetp2({this.userInfoMain, key}) : super(key: key);
  final UserInfoMain userInfoMain;
  @override
  _A009PhoneAuthSetp2State createState() {
    return _A009PhoneAuthSetp2State(userInfoMain: userInfoMain);
  }
}

class _A009PhoneAuthSetp2State extends State<A009PhoneAuthSetp2> {
  _A009PhoneAuthSetp2State({this.userInfoMain});
  UserInfoMain userInfoMain;
  TextEditingController phoneauthnumbercontroller = TextEditingController();
  String phoneNumber = "";
  bool iscanrequest = true;
  int authtimelimit = 0;
  SmsReceiver _smsReceiver;
  StreamSubscription periodicSub;
  bool isloading = false;
  onPhoneNumberChange(
      String phoneText, String number, String selectedItemcode) {
    userInfoMain.phonenumber = number;
    userInfoMain.isocode = selectedItemcode;
  }

  void onSmsReceived(String message) {
    setState(() {
      int find = message.indexOf(':');
      String code = message.substring(find + 1, find + 7);
      phoneauthnumbercontroller.text = code;
    });
  }

  void _startListening() {
    if (periodicSub != null) {
      periodicSub.cancel();
    }
    iscanrequest = false;
    periodicSub = new Stream.periodic(const Duration(seconds: 1), (v) => v)
        .take(300)
        .listen((count) {
      if (count == 300) {
        authtimelimit = 300 - count;
        iscanrequest = true;
        setState(() {});
      }
      authtimelimit = 300 - count;
      setState(() {});
    });

    periodicSub.onDone(() {
      setState(() {});
    });
    _smsReceiver.startListening();
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
                        fontFamily: 'NotoSansKR',
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
                          margin: EdgeInsets.fromLTRB(32, 0, 32, 21),
                          child: InternationalPhoneInput(
                              onPhoneNumberChange: onPhoneNumberChange,
                              initialPhoneNumber: phoneNumber,
                              hintText: "휴대폰 번호 입력",
                              errorText: "양식에 맞지 않습니다.",
                              initialSelection: "KR"),
                          decoration: BoxDecoration(
                            color: Color(0xffffffff),
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0.00, 4.00),
                                color: Color(0xff455b63).withOpacity(0.08),
                                blurRadius: 16,
                              ),
                            ],
                            borderRadius: BorderRadius.circular(12.00),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(32, 0, 32, 21),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        controller: phoneauthnumbercontroller,
                                        decoration: InputDecoration(
                                            contentPadding: EdgeInsets.fromLTRB(
                                                16, 0, 16, 0),
                                            filled: true,
                                            fillColor: Colors.white,
                                            hintText: "인증번호 입력",
                                            hintStyle: TextStyle(
                                                color: Color(0xFF78849E),
                                                fontFamily: 'NotoSansKR',
                                                fontSize: 15),
                                            border: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(16)))))),
                              ),
                              iscanrequest
                                  ? Container(
                                      margin: EdgeInsets.fromLTRB(13, 0, 13, 0),
                                      height: 50.00,
                                      width: 111.00,
                                      child: FlatButton(
                                          padding: EdgeInsets.all(0),
                                          onPressed: () async {
                                            isloading = true;
                                            setState(() {});
                                            int result = await UserInfoMain
                                                .requestFindAuthPhoneNumber(
                                                    userInfoMain.uid,
                                                    userInfoMain.phonenumber,
                                                    userInfoMain.isocode);
                                            if (result == 1) {
                                              _startListening();
                                            } else {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            new BorderRadius
                                                                .circular(16.0),
                                                      ),
                                                      title: Container(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                            "휴대폰 번호 불일치",
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  "NotoSansKR",
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              fontSize: 20,
                                                              color: Color(
                                                                  0xff000000),
                                                            )),
                                                      ),
                                                      content: Container(
                                                        height: 140,
                                                        child: Column(
                                                          children: <Widget>[
                                                            Container(
                                                                child: Text(
                                                                    "입력하신 정보와 일치하는 계정이 없습니다.\n\n휴대폰 번호를 변경하셨다면, 이메일 인증으로\n패스워드를 찾아주세요.",
                                                                    style:
                                                                        TextStyle(
                                                                      fontFamily:
                                                                          "NotoSansKR",
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w300,
                                                                      fontSize:
                                                                          14,
                                                                      color: Color(
                                                                          0xff454f63),
                                                                    ))),
                                                            SizedBox(
                                                              height: 21,
                                                            ),
                                                            Container(
                                                              height: 36.00,
                                                              width:
                                                                  MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Color(
                                                                    0xff454f63),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            12.00),
                                                              ),
                                                              child: FlatButton(
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                },
                                                                child: Text(
                                                                    "확인",
                                                                    style:
                                                                        TextStyle(
                                                                      fontFamily:
                                                                          "NotoSansKR",
                                                                      fontSize:
                                                                          15,
                                                                      color: Color(
                                                                          0xff39f999),
                                                                    )),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  });
                                            }
                                            isloading = false;
                                            setState(() {});
                                          },
                                          child: Text(
                                            "인증번호 요청",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'NotoSansKR',
                                                fontSize: 15),
                                          )),
                                      decoration: BoxDecoration(
                                        color: Color(0xff3497fd),
                                        boxShadow: [
                                          BoxShadow(
                                            offset: Offset(0.00, 4.00),
                                            color: Color(0xff455b63)
                                                .withOpacity(0.08),
                                            blurRadius: 16,
                                          ),
                                        ],
                                        borderRadius:
                                            BorderRadius.circular(12.00),
                                      ),
                                    )
                                  : Container(
                                      margin: EdgeInsets.fromLTRB(13, 0, 13, 0),
                                      height: 50.00,
                                      width: 111.00,
                                      child: FlatButton(
                                          onPressed: () {},
                                          padding: EdgeInsets.all(0),
                                          child: Text(
                                            "인증번호 요청",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'NotoSansKR',
                                                fontSize: 15),
                                          )),
                                      decoration: BoxDecoration(
                                        color: Color(0xffB1B1B1),
                                        boxShadow: [
                                          BoxShadow(
                                            offset: Offset(0.00, 4.00),
                                            color: Color(0xffB1B1B1)
                                                .withOpacity(0.08),
                                            blurRadius: 16,
                                          ),
                                        ],
                                        borderRadius:
                                            BorderRadius.circular(12.00),
                                      ),
                                    ),
                            ],
                          ),
                        ),
                        Container(
                          child: RichText(
                            text: TextSpan(
                                text: "인증번호는 ",
                                children: [
                                  TextSpan(
                                      text: "${authtimelimit}초 ",
                                      style: TextStyle(
                                          color: Color(0xffFF4F9A),
                                          fontFamily: 'NotoSansKR',
                                          fontSize: 13)),
                                  TextSpan(
                                      text: "후에 다시 요청 하실수 있습니다.",
                                      style: TextStyle(
                                          color: Color(0xff454F63),
                                          fontFamily: 'NotoSansKR',
                                          fontSize: 13))
                                ],
                                style: TextStyle(
                                    color: Color(0xff454F63),
                                    fontFamily: 'NotoSansKR',
                                    fontSize: 13)),
                          ),
                        ),
                        SizedBox(
                          height: 21,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.fromLTRB(32, 0, 32, 0),
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
                              isloading = true;
                              setState(() {});
                              userInfoMain.phoneauthcheckcode =
                                  await UserInfoMain
                                      .requestAuthVerificationPhoneNumber(
                                          userInfoMain.uid,
                                          userInfoMain.phonenumber,
                                          phoneauthnumbercontroller.text);
                              isloading = false;
                              setState(() {});
                              if (userInfoMain.phoneauthcheckcode != 'false') {
                                periodicSub.cancel();
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) {
                                  return A010PhoneAuthStep3(
                                      userInfoMain: userInfoMain);
                                }));
                              } else {
                                showDialog(
                                    context: context,
                                    barrierDismissible: true,
                                    builder: (context) {
                                      return AlertDialog(
                                          content: Container(
                                              height: 110,
                                              child: Column(children: <Widget>[
                                                Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    "인증번호 불일치",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontFamily:
                                                            'NotoSansKR',
                                                        fontSize: 20),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 16,
                                                ),
                                                Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    "인증번호를 잘못 입력하셨습니다.",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontFamily:
                                                            'NotoSansKR',
                                                        fontSize: 14),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Container(
                                                    height: 30,
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    decoration: BoxDecoration(
                                                      color: Color(0xff454f63),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12.00),
                                                    ),
                                                    child: FlatButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: Text("확인",
                                                            style: TextStyle(
                                                                color: Theme.of(
                                                                        context)
                                                                    .primaryColor,
                                                                fontFamily:
                                                                    'NotoSansKR',
                                                                fontSize: 14))))
                                              ])));
                                    });
                              }
                            },
                            child: Text("인증번호 확인",
                                style: TextStyle(
                                  fontFamily: "NotoSansKR",
                                  fontSize: 15,
                                  color: iscanrequest
                                      ? Color(0xffffffff)
                                      : Theme.of(context).primaryColor,
                                )),
                          ),
                        )
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
                  value: 0.68,
                  backgroundColor: Color(0xffCCCCCC),
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF39F999)),
                ),
              )),
        ));
  }
}
