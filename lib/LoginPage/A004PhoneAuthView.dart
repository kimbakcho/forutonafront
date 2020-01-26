import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:forutonafront/Auth/UserInfoMain.dart';
import 'package:forutonafront/Common/LoadingOverlay%20.dart';
import 'package:forutonafront/LoginPage/A005SignIn2View.dart';
import 'package:forutonafront/LoginPage/A006SignIn3View.dart';
import 'package:forutonafront/LoginPage/Component/SnsLoginDataLogic.dart';
import 'package:forutonafront/Preference.dart';
import 'package:international_phone_input/international_phone_input.dart';
import 'package:loading/indicator/ball_scale_indicator.dart';
import 'package:loading/loading.dart';

import 'package:sms_receiver/sms_receiver.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class A004PhoneAuthView extends StatefulWidget {
  A004PhoneAuthView({this.userinfomain, Key key}) : super(key: key);
  final UserInfoMain userinfomain;
  @override
  _A004PhoneAuthViewState createState() {
    return _A004PhoneAuthViewState(userinfomain: userinfomain);
  }
}

class _A004PhoneAuthViewState extends State<A004PhoneAuthView> {
  _A004PhoneAuthViewState({this.userinfomain});
  UserInfoMain userinfomain;
  var uuid = new Uuid();
  String currentuuid = "";
  String phoneNumber = "";
  SmsReceiver _smsReceiver;
  StreamSubscription periodicSub;
  TextEditingController phoneauthnumbercontroller = TextEditingController();
  bool iscanrequest = true;
  int authtimelimit = 0;
  bool iskeyboardshow = false;
  bool isloading = false;
  onPhoneNumberChange(
      String phoneText, String number, String selectedItemcode) {
    userinfomain.phonenumber = number;
    userinfomain.isocode = selectedItemcode;
  }

  void onSmsReceived(String message) {
    setState(() {
      int find = message.indexOf(':');
      String code = message.substring(find + 1, find + 7);
      phoneauthnumbercontroller.text = code;
    });
  }

  @override
  void initState() {
    super.initState();
    currentuuid = uuid.v4();
    userinfomain.uid = currentuuid;
    _smsReceiver = SmsReceiver(onSmsReceived, onTimeout: onTimeout);
    KeyboardVisibilityNotification().addNewListener(
      onChange: (bool visible) {
        setState(() {
          this.iskeyboardshow = visible;
        });
      },
    );
  }

  void onTimeout() {
    setState(() {});
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
        setState(() {
          authtimelimit = 300 - count;
          iscanrequest = true;
        });
      }
      setState(() {
        authtimelimit = 300 - count;
      });
    });

    periodicSub.onDone(() {
      setState(() {});
    });
    _smsReceiver.startListening();
  }

  showjoinedAlret() async {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(16.0),
              ),
              content: Container(
                height: 110,
                child: Column(children: <Widget>[
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "이미 가입하였습니다.",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'NotoSansKR',
                          fontSize: 20),
                    ),
                  ),
                  Container(
                      height: 30,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Color(0xff454f63),
                        borderRadius: BorderRadius.circular(12.00),
                      ),
                      child: FlatButton(
                          onPressed: () {
                            Navigator.popUntil(
                                context, ModalRoute.withName('/'));
                          },
                          child: Text("확인",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontFamily: 'NotoSansKR',
                                  fontSize: 14))))
                ]),
              ));
        });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if (periodicSub != null) {
      periodicSub.cancel();
    }
  }

  Future<bool> checkhaveuid(UserInfoMain userinfo) async {
    var uri = Preference.httpurloption(
        Preference.baseBackEndUrl, '/api/v1/Auth/GetUid', {
      'Uid': userinfo.uid,
    });
    var response = await http.get(uri);
    String getuid = response.body;
    if (userinfo.uid == getuid) {
      return true;
    } else {
      return false;
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
            title: !iskeyboardshow
                ? Text("")
                : Text("가입하기",
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
            child: Column(
              children: <Widget>[
                !iskeyboardshow
                    ? Container(
                        alignment: Alignment.center,
                        child: Text("가입하기",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'NotoSansKR',
                                fontSize: 24)),
                      )
                    : Container(),
                SizedBox(
                  height: 13,
                ),
                !iskeyboardshow
                    ? Container(
                        alignment: Alignment.center,
                        child: Text("먼저,휴대폰 인증이 필요합니다.",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'NotoSansKR',
                                fontSize: 13)),
                      )
                    : Container(),
                SizedBox(height: 17),
                Expanded(
                  child: Container(
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
                          margin: EdgeInsets.fromLTRB(32, 0, 32, 0),
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
                        SizedBox(
                          height: 21,
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(32, 0, 32, 0),
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
                                            UserInfoMain.requestAuthPhoneNumber(
                                                currentuuid,
                                                userinfomain.phonenumber,
                                                userinfomain.isocode);
                                            isloading = false;
                                            setState(() {});
                                            _startListening();
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
                                    )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 21,
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
                          child: FlatButton(
                            onPressed: () async {
                              // Navigator.push(context,
                              //     MaterialPageRoute(builder: (context) {
                              //   return A005SignIn2View(
                              //     userinfomain: userinfomain,
                              //   );
                              // }));
                              isloading = true;
                              setState(() {});

                              userinfomain.phoneauthcheckcode =
                                  await UserInfoMain
                                      .requestAuthVerificationPhoneNumber(
                                          currentuuid,
                                          userinfomain.phonenumber,
                                          phoneauthnumbercontroller.text);
                              if (userinfomain.phoneauthcheckcode != 'false') {
                                userinfomain.phonenumber =
                                    userinfomain.phonenumber;
                                periodicSub.cancel();
                                if (userinfomain.snsservice ==
                                    SnsLoginDataLogic.email) {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return A005SignIn2View(
                                      userinfomain: userinfomain,
                                    );
                                  }));
                                } else if (userinfomain.snsservice ==
                                    SnsLoginDataLogic.facebook) {
                                  bool loginresult =
                                      await SnsLoginDataLogic.snsLogins(
                                          SnsLoginDataLogic.facebook,
                                          userinfomain);
                                  if (loginresult) {
                                    if (await checkhaveuid(userinfomain)) {
                                      showjoinedAlret();
                                    } else {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(builder: (context) {
                                        return A006SignIn3View(
                                            userinfomain: userinfomain);
                                      }));
                                    }
                                  }
                                } else if (userinfomain.snsservice ==
                                    SnsLoginDataLogic.naver) {
                                  bool loginresult =
                                      await SnsLoginDataLogic.snsLogins(
                                          SnsLoginDataLogic.naver,
                                          userinfomain);
                                  if (loginresult) {
                                    if (await checkhaveuid(userinfomain)) {
                                      showjoinedAlret();
                                    } else {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(builder: (context) {
                                        return A006SignIn3View(
                                            userinfomain: userinfomain);
                                      }));
                                    }
                                  }
                                } else if (userinfomain.snsservice ==
                                    SnsLoginDataLogic.kakao) {
                                  bool loginresult =
                                      await SnsLoginDataLogic.snsLogins(
                                          SnsLoginDataLogic.kakao,
                                          userinfomain);
                                  if (loginresult) {
                                    if (await checkhaveuid(userinfomain)) {
                                      showjoinedAlret();
                                    } else {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(builder: (context) {
                                        return A006SignIn3View(
                                            userinfomain: userinfomain);
                                      }));
                                    }
                                  }
                                }
                                isloading = false;
                                setState(() {});
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
                            child: Text(
                              "인증번호 확인",
                              style: TextStyle(
                                  color: iscanrequest
                                      ? Colors.white
                                      : Theme.of(context).primaryColor,
                                  fontFamily: 'NotoSansKR',
                                  fontSize: 15),
                            ),
                          ),
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
                        )
                      ])),
                ),
              ],
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Container(
            height: 10,
            child: LinearProgressIndicator(
              value: 0.5,
              backgroundColor: Color(0xffCCCCCC),
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF39F999)),
            ),
          ),
        ),
      ),
    );
  }
}
