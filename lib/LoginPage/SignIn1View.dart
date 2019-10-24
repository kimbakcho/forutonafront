import 'package:flutter/material.dart';

class SignInView extends StatefulWidget {
  SignInView({Key key}) : super(key: key);

  @override
  _SignInViewState createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
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
        child: ListView(
          children: <Widget>[],
        ),
      ),
    );
  }
}
