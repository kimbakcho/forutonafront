import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:forutonafront/Auth/UserInfoMain.dart';
import 'package:forutonafront/LoginPage/Component/SnsLoginDataLogic.dart';
import 'SignIn3View.dart';

class SignIn2View extends StatefulWidget {
  SignIn2View({Key key, @required this.userinfo}) : super(key: key);
  final UserInfoMain userinfo;

  @override
  _SignIn2ViewState createState() => _SignIn2ViewState();
}

class _SignIn2ViewState extends State<SignIn2View> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController passCheckController = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  var _signIn2ViewscaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _signIn2ViewscaffoldKey,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          titleSpacing: 0,
          leading: Container(
            padding: EdgeInsets.all(10),
            child: RaisedButton(
              child: Text("<"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          actions: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              width: 80,
              child: RaisedButton(
                child: Text('다음'),
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    List<String> idlists =
                        await _auth.fetchSignInMethodsForEmail(
                            email: emailController.text);
                    if (idlists.length > 0) {
                      final snackBar = SnackBar(
                        content: Text("이미 ID가 있습니다."),
                        duration: Duration(milliseconds: 1000),
                      );
                      _signIn2ViewscaffoldKey.currentState
                          .showSnackBar(snackBar);
                      return;
                    }
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return SignIn3View(
                        loginpage: SnsLoginDataLogic.email,
                        userinfo: this.widget.userinfo,
                      );
                    }));
                  } else {
                    final snackBar = SnackBar(
                      content: Text("양식을 체크해주세요."),
                      duration: Duration(milliseconds: 1000),
                    );
                    _signIn2ViewscaffoldKey.currentState.showSnackBar(snackBar);
                  }
                },
              ),
            )
          ],
        ),
        body: new Builder(builder: (context) {
          return Container(
              child: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(border: Border.all(width: 1)),
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: Center(
                    child: Icon(
                      Icons.picture_in_picture,
                      size: 70,
                    ),
                  ),
                ),
                Container(
                  height: 50,
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          child: Stack(
                        children: <Widget>[
                          TextFormField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                hintText: 'ID(Email)',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0)))),
                            onChanged: (String value) {
                              this.widget.userinfo.email = value;
                              _formKey.currentState.validate();
                              setState(() {});
                            },
                            validator: (value) {
                              return UserInfoMain.validateEmail(value);
                            },
                          ),
                          Positioned(
                              right: 10,
                              top: 15,
                              child: UserInfoMain.validateEmail(
                                          this.widget.userinfo.email) ==
                                      null
                                  ? Icon(Icons.check)
                                  : Container())
                        ],
                      ))
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(20, 10, 10, 0),
                  child:
                      Text("아이디는 실제 사용 하는 이메일을 작성해주세요. \n패스워드는 분식시 복구에 사용됩니다."),
                ),
                Container(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          child: Stack(
                        children: <Widget>[
                          TextFormField(
                            obscureText: true,
                            controller: passController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                hintText: 'password',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0)))),
                            onChanged: (String value) {
                              this.widget.userinfo.password = value;
                              _formKey.currentState.validate();
                              setState(() {});
                            },
                            validator: (value) {
                              return UserInfoMain.validatePassword(value);
                            },
                          ),
                          Positioned(
                              right: 10,
                              top: 15,
                              child: UserInfoMain.validatePassword(
                                          this.widget.userinfo.password) ==
                                      null
                                  ? Icon(Icons.check)
                                  : Container())
                        ],
                      ))
                    ],
                  ),
                ),
                Container(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          child: Stack(
                        children: <Widget>[
                          TextFormField(
                            obscureText: true,
                            controller: passCheckController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                hintText: 'password Check',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0)))),
                            onChanged: (String value) {
                              _formKey.currentState.validate();
                              setState(() {});
                            },
                            validator: (value) {
                              if (value != this.widget.userinfo.password) {
                                return "check password";
                              }
                              return null;
                            },
                          ),
                          Positioned(
                              right: 10,
                              top: 15,
                              child: this.widget.userinfo.password ==
                                      passCheckController.text
                                  ? Icon(Icons.check)
                                  : Container())
                        ],
                      ))
                    ],
                  ),
                ),
              ],
            ),
          ));
        }));
  }
}
