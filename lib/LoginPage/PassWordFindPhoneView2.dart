import 'dart:async';

import 'package:flutter/material.dart';
import 'package:forutonafront/Auth/UserInfoMain.dart';
import 'package:forutonafront/LoginPage/PassWordFindPhoneView3.dart';
import 'package:international_phone_input/international_phone_input.dart';
import 'package:uuid/uuid.dart';
import 'SignIn2View.dart';
import 'package:sms_receiver/sms_receiver.dart';
import 'package:intl/intl.dart';

class PassWordFindPhoneView2 extends StatefulWidget {
  UserInfoMain userinfo;
  PassWordFindPhoneView2({Key key, this.userinfo}) : super(key: key);

  @override
  _PassWordFindPhoneView2State createState() {
    return _PassWordFindPhoneView2State(userinfo);
  }
}

class _PassWordFindPhoneView2State extends State<PassWordFindPhoneView2> {
  _PassWordFindPhoneView2State(this.userinfo);
  var _passWordFindPhoneView2State = GlobalKey<ScaffoldState>();
  UserInfoMain userinfo;
  String phoneNumber;
  String phoneIsoCode;
  String confirmedNumber = '';
  String currenetinternationalizedPhoneNumber = "";
  TextEditingController phoneauthnumbercontroller = TextEditingController();
  var uuid = new Uuid();
  String currentuuid = "";
  Timer authtrytimer;
  StreamSubscription periodicSub;
  bool iscanrequest = true;
  String authtimelimit = "인증요청";

  SmsReceiver _smsReceiver;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    currentuuid = uuid.v4();

    _smsReceiver = SmsReceiver(onSmsReceived, onTimeout: onTimeout);
  }

  void onSmsReceived(String message) {
    setState(() {
      int find = message.indexOf(':');
      String code = message.substring(find + 1, find + 7);
      phoneauthnumbercontroller.text = code;
    });
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
      if (count == 5) {
        setState(() {
          iscanrequest = true;
        });
      }
      DateTime datetime =
          DateTime(0, 0, 0, 0, 5, 0).add(Duration(seconds: -1 * count));
      setState(() {
        authtimelimit = DateFormat("mm:ss").format(datetime);
      });
    });

    periodicSub.onDone(() {
      setState(() {
        authtimelimit = "인증요청";
      });
    });

    _smsReceiver.startListening();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _passWordFindPhoneView2State,
      appBar: AppBar(
        title: Text("인증"),
      ),
      body: Container(
        height: 500,
        child: ListView(
          children: <Widget>[
            Container(
              height: 20,
            ),
            Container(
              child: Center(
                child: Text(
                  "핸드폰 인증이 필요 합니다.",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    child: Text(userinfo.phonenumber),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: RaisedButton(
                    onPressed: iscanrequest
                        ? () async {
                            UserInfoMain.requestAuthPhoneNumber(
                                currentuuid, userinfo.phonenumber);
                            _startListening();
                          }
                        : null,
                    child: Text(authtimelimit),
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: phoneauthnumbercontroller,
                decoration: InputDecoration(hintText: "인증 번호를 입력 하세요."),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: RaisedButton(
                child: Text("완료"),
                onPressed: () async {
                  userinfo.phoneauthcheckcode =
                      await UserInfoMain.requestAuthVerificationPhoneNumber(
                          currentuuid,
                          userinfo.phonenumber,
                          phoneauthnumbercontroller.text);
                  if (userinfo.phoneauthcheckcode != 'false') {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return PassWordFindPhoneView3(userinfo: userinfo);
                    }));
                  } else {
                    SnackBar snackbar = SnackBar(
                      content: Text("인증번호가 틀렸습니다."),
                      duration: Duration(seconds: 1),
                    );
                    _passWordFindPhoneView2State.currentState
                        .showSnackBar(snackbar);
                  }
                  ;
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
