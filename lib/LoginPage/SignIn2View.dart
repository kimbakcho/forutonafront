import 'package:flutter/material.dart';
import 'package:forutonafront/Auth/UserInfo.dart' as forutona;
import 'package:firebase_auth/firebase_auth.dart';
import 'SignIn3View.dart';

class SignIn2View extends StatefulWidget {
  SignIn2View({Key key, @required this.userinfo}) : super(key: key);
  final forutona.UserInfo userinfo;

  @override
  _SignIn2ViewState createState() => _SignIn2ViewState();
}

class _SignIn2ViewState extends State<SignIn2View> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController passCheckController = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        ),
        body: new Builder(builder: (context) {
          return Container(
            margin: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height * 0.1, 20, 20),
            child: ListView(
              children: <Widget>[
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                      hintText: 'ID(Email)',
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0)))),
                  onChanged: (String value) {
                    this.widget.userinfo.email = value;
                  },
                ),
                Container(
                  height: 20,
                ),
                TextFormField(
                  obscureText: true,
                  controller: passController,
                  decoration: InputDecoration(
                      hintText: 'password',
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0)))),
                  onChanged: (String value) {
                    this.widget.userinfo.password = value;
                  },
                ),
                Container(
                  height: 20,
                ),
                TextFormField(
                  obscureText: true,
                  controller: passCheckController,
                  decoration: InputDecoration(
                      hintText: 'password',
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0)))),
                ),
                Container(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.only(right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      SizedBox(
                        width: 80,
                        child: RaisedButton(
                          child: Text('Next'),
                          onPressed: () async {
                            if (emailController.text.trim().length == 0) {
                              final snackBar = SnackBar(
                                content: Text("ID가 적히지 않았습니다."),
                                duration: Duration(milliseconds: 1000),
                              );
                              Scaffold.of(context).showSnackBar(snackBar);
                              return;
                            }
                            List<String> idlists =
                                await _auth.fetchSignInMethodsForEmail(
                                    email: emailController.text);
                            if (idlists.length > 0) {
                              final snackBar = SnackBar(
                                content: Text("이미 ID가 있습니다."),
                                duration: Duration(milliseconds: 1000),
                              );
                              Scaffold.of(context).showSnackBar(snackBar);
                              return;
                            }
                            if (passController.text.length <= 6) {
                              final snackBar = SnackBar(
                                content: Text("패스워드는 6자리 이상이여야 합니다."),
                                duration: Duration(milliseconds: 1000),
                              );
                              Scaffold.of(context).showSnackBar(snackBar);
                              return;
                            }
                            if (passController.text !=
                                passCheckController.text) {
                              final snackBar = SnackBar(
                                content: Text("패스워드가 맞지 않습니다."),
                                duration: Duration(milliseconds: 1000),
                              );
                              Scaffold.of(context).showSnackBar(snackBar);
                              return;
                            }
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return SignIn3View(
                                userinfo: this.widget.userinfo,
                              );
                            }));
                          },
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        }));
  }
}
