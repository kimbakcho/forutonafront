import 'package:flutter/material.dart';

class PositionAgreeView extends StatefulWidget {
  PositionAgreeView({Key key}) : super(key: key);

  @override
  _PositionAgreeViewState createState() => _PositionAgreeViewState();
}

class _PositionAgreeViewState extends State<PositionAgreeView> {
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
