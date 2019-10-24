import 'package:flutter/material.dart';

class ForutonaAgreeView extends StatefulWidget {
  ForutonaAgreeView({Key key}) : super(key: key);

  @override
  _ForutonaAgreeViewState createState() => _ForutonaAgreeViewState();
}

class _ForutonaAgreeViewState extends State<ForutonaAgreeView> {
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
