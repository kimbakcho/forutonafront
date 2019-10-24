import 'package:flutter/material.dart';

class PrivateAgreeView extends StatefulWidget {
  PrivateAgreeView({Key key}) : super(key: key);

  @override
  _PrivateAgreeViewState createState() => _PrivateAgreeViewState();
}

class _PrivateAgreeViewState extends State<PrivateAgreeView> {
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
          margin: EdgeInsets.all(20),
          child: Text("불라부라"),
        ));
  }
}
