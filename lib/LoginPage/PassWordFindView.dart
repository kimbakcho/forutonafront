import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/LoginPage/PassWordFindPhoneView1.dart';

import 'PassWordFindEmailView.dart';

class PassWordFindView extends StatefulWidget {
  PassWordFindView({Key key}) : super(key: key);

  @override
  _PassWordFindViewState createState() => _PassWordFindViewState();
}

class _PassWordFindViewState extends State<PassWordFindView> {
  TextEditingController _emailtextcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("비밀번호 찾기"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 20,
                    ),
                    Container(
                      alignment: Alignment(0, 0),
                      child: Text("휴대폰 인증 하기"),
                    ),
                    Container(
                        height: 100,
                        alignment: Alignment(0, 0),
                        child: Icon(
                          Icons.picture_in_picture_alt,
                          size: 50,
                        )),
                    Container(
                      child: Text("계정에 등록된 휴대폰 번호를 인증하고 \n패스워드를 변경 합니다."),
                    ),
                    Container(
                      height: 30,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: RaisedButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return PassWordFindPhoneView1();
                          }));
                        },
                        child: Text("휴대폰 인증하기"),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Divider(
              thickness: 5,
              indent: 10,
              endIndent: 10,
            ),
            Expanded(
              child: Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 20,
                    ),
                    Container(
                      alignment: Alignment(0, 0),
                      child: Text("이메일주소(계정) 인증하기"),
                    ),
                    Container(
                        height: 100,
                        alignment: Alignment(0, 0),
                        child: Icon(
                          Icons.picture_in_picture_alt,
                          size: 50,
                        )),
                    Container(
                      child: Text("계정에 등록된 이메일 주소를 인증하고 \n패스워드를 변경 합니다."),
                    ),
                    Container(
                      height: 30,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: RaisedButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return PassWordFindEmailView();
                          }));
                        },
                        child: Text("이메일주소 인증하기"),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
