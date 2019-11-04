import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/Auth/UserInfoMain.dart';

class PassWordFindEmailView extends StatefulWidget {
  PassWordFindEmailView({Key key}) : super(key: key);

  @override
  _PassWordFindEmailViewState createState() => _PassWordFindEmailViewState();
}

class _PassWordFindEmailViewState extends State<PassWordFindEmailView> {
  final _formKey = GlobalKey<FormState>();
  var _passWordFindEmailViewState = new GlobalKey<ScaffoldState>();
  TextEditingController emailcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _passWordFindEmailViewState,
      appBar: AppBar(
        title: Text("이메일 인증"),
        actions: <Widget>[
          Container(
            padding: EdgeInsets.all(10),
            child: RaisedButton(
              child: Text("다음"),
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                  try {
                    await FirebaseAuth.instance
                        .sendPasswordResetEmail(email: emailcontroller.text);
                  } catch (ex) {
                    SnackBar snackbar = SnackBar(
                        content: Text(ex.toString()),
                        duration: Duration(milliseconds: 1000));
                    _passWordFindEmailViewState.currentState
                        .showSnackBar(snackbar);
                  }
                }
              },
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
