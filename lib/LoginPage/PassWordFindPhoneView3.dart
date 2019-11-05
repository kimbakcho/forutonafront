import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/Auth/UserInfoMain.dart';
import 'package:forutonafront/LoginPage/LoginPageView.dart';

class PassWordFindPhoneView3 extends StatefulWidget {
  UserInfoMain userinfo;
  PassWordFindPhoneView3({Key key, this.userinfo}) : super(key: key);

  @override
  _PassWordFindPhoneView3State createState() {
    return _PassWordFindPhoneView3State(userinfo);
  }
}

class _PassWordFindPhoneView3State extends State<PassWordFindPhoneView3> {
  _PassWordFindPhoneView3State(this.userinfo);
  UserInfoMain userinfo;
  var _formkey = GlobalKey<FormState>();
  var _passWordFindPhoneView3State = GlobalKey<ScaffoldState>();
  TextEditingController pwcontroller = TextEditingController();
  TextEditingController pwcheckcontroller = TextEditingController();
  Future<void> _ackAlert(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: const Text('패스워드를 변경하였습니다.'),
          actions: <Widget>[
            FlatButton(
              child: Text('확인'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _passWordFindPhoneView3State,
      appBar: AppBar(
        actions: <Widget>[
          Container(
            padding: EdgeInsets.all(10),
            child: RaisedButton(
              onPressed: () async {
                if (_formkey.currentState.validate()) {
                  userinfo.password = pwcontroller.text;
                  int result =
                      await UserInfoMain.passwrodChangefromphone(userinfo);
                  if (result == 0) {
                    SnackBar snakbar = SnackBar(
                      content: Text("변경에 실패 하였습니다."),
                      duration: Duration(seconds: 1),
                    );
                    _passWordFindPhoneView3State.currentState
                        .showSnackBar(snakbar);
                  } else {
                    await _ackAlert(context);
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) {
                      return LoginPageView();
                    }), ModalRoute.withName('/'));
                  }
                }
              },
              child: Text("완료"),
            ),
          )
        ],
      ),
      body: Form(
        key: _formkey,
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
              child: TextFormField(
                obscureText: true,
                decoration: InputDecoration(hintText: "새 패스워드"),
                controller: pwcontroller,
                onChanged: (value) {
                  _formkey.currentState.validate();
                },
                validator: (value) {
                  return UserInfoMain.validatePassword(value);
                },
              ),
            ),
            Container(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
              child: TextFormField(
                obscureText: true,
                controller: pwcheckcontroller,
                decoration: InputDecoration(hintText: "새 패스워드 확인"),
                onChanged: (value) {
                  _formkey.currentState.validate();
                },
                validator: (value) {
                  if (value != pwcontroller.text) {
                    return "패스워드가 틀립니다.";
                  } else {
                    return null;
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
