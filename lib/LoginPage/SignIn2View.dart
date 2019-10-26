import 'package:flutter/material.dart';
import 'package:forutonafront/Auth/UserInfo.dart';

import 'SignIn3View.dart';

class SignIn2View extends StatefulWidget {
  SignIn2View({Key key, @required this.signitem}) : super(key: key);
  final UserInfo signitem;

  @override
  _SignIn2ViewState createState() => _SignIn2ViewState();
}

class _SignIn2ViewState extends State<SignIn2View> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController passCheckController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      body: Container(
        margin: EdgeInsets.fromLTRB(
            20, MediaQuery.of(context).size.height * 0.1, 20, 20),
        child: ListView(
          children: <Widget>[
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                  hintText: 'ID(Email)',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)))),
              onChanged: (String value) {
                this.widget.signitem.email = value;
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
                      borderRadius: BorderRadius.all(Radius.circular(10.0)))),
              onChanged: (String value) {
                this.widget.signitem.password = value;
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
                      borderRadius: BorderRadius.all(Radius.circular(10.0)))),
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
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return SignIn3View(
                            signitem: this.widget.signitem,
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
      ),
    );
  }
}
