import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/Auth/UserInfoMain.dart';
import 'package:forutonafront/LoginPage/PassWordFindPhoneView2.dart';

class PassWordFindPhoneView1 extends StatefulWidget {
  PassWordFindPhoneView1({Key key}) : super(key: key);

  @override
  _PassWordFindPhoneView1State createState() => _PassWordFindPhoneView1State();
}

class _PassWordFindPhoneView1State extends State<PassWordFindPhoneView1> {
  final _formKey = GlobalKey<FormState>();
  var _passWordFindPhoneView1State = new GlobalKey<ScaffoldState>();
  TextEditingController emailcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _passWordFindPhoneView1State,
      appBar: AppBar(
        title: Text("패스워드 찾기"),
        actions: <Widget>[
          Container(
            padding: EdgeInsets.all(10),
            child: RaisedButton(
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                  List<String> ids = await FirebaseAuth.instance
                      .fetchSignInMethodsForEmail(email: emailcontroller.text);
                  if (ids.length == 0) {
                    SnackBar snack = SnackBar(
                        content: Text("ID가 없습니다"),
                        duration: Duration(seconds: 1));
                    _passWordFindPhoneView1State.currentState
                        .showSnackBar(snack);
                  } else {
                    UserInfoMain userinfo =
                        await UserInfoMain.getUsePasswordFindPhoneInfoByemail(
                            emailcontroller.text);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return PassWordFindPhoneView2(userinfo: userinfo);
                    }));
                  }
                }
              },
              child: Text("다음"),
            ),
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            child: Text("FORUTONA 계정(이메일 주소)을 입력해주세요"),
            alignment: Alignment(0, 0),
          ),
          Form(
            key: _formKey,
            child: Container(
              margin: EdgeInsets.fromLTRB(30, 10, 30, 10),
              child: TextFormField(
                  controller: emailcontroller,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(hintText: "이메일 주소 입력"),
                  onChanged: (value) {
                    _formKey.currentState.validate();
                  },
                  validator: (value) {
                    return UserInfoMain.validateEmail(value);
                  }),
            ),
          )
        ],
      ),
    );
  }
}
