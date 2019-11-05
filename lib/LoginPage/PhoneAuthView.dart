import 'dart:async';

import 'package:flutter/material.dart';
import 'package:forutonafront/Auth/UserInfoMain.dart';
import 'package:international_phone_input/international_phone_input.dart';
import 'package:uuid/uuid.dart';
import 'SignIn2View.dart';
import 'package:sms_receiver/sms_receiver.dart';
import 'package:intl/intl.dart';

class PhoneAuthView extends StatefulWidget {
  PhoneAuthView({Key key, this.userinfo}) : super(key: key);
  final UserInfoMain userinfo;
  @override
  _PhoneAuthViewState createState() {
    return _PhoneAuthViewState(userinfo);
  }
}

class _PhoneAuthViewState extends State<PhoneAuthView> {
  _PhoneAuthViewState(this.userinfo);
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

  void onPhoneNumberChange(
      String number, String internationalizedPhoneNumber, String isoCode) {
    setState(() {
      currenetinternationalizedPhoneNumber = internationalizedPhoneNumber;
      phoneNumber = number;
      phoneIsoCode = isoCode;
    });
  }

  String _textContent = 'Waiting for messages...';
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
      _textContent = message;
      print(_textContent);
    });
  }

  void onTimeout() {
    setState(() {
      _textContent = "Timeout!!!";
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
                    child: InternationalPhoneInput(
                        onPhoneNumberChange: onPhoneNumberChange,
                        initialPhoneNumber: phoneNumber,
                        hintText: "번호를 입력해주세요.",
                        errorText: "양식에 맞지 않습니다.",
                        initialSelection: "KR"),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: RaisedButton(
                    onPressed: iscanrequest
                        ? () async {
                            UserInfoMain.requestAuthPhoneNumber(currentuuid,
                                currenetinternationalizedPhoneNumber);
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
                          currenetinternationalizedPhoneNumber,
                          phoneauthnumbercontroller.text);
                  if (userinfo.phoneauthcheckcode != 'false') {
                    userinfo.phonenumber = currenetinternationalizedPhoneNumber;
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return SignIn2View(
                        userinfo: userinfo,
                      );
                    }));
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