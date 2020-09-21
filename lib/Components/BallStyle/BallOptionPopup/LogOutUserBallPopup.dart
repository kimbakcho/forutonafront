import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'BallOptionPopup.dart';

class LogOutUserBallPopup implements BallOptionWidget {
  @override
  Widget child(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
          child: Container(
            padding: EdgeInsets.all(16),
            width: 180,
        height: 100,
        child: Text("로그인 하셔야 됩니다."),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(15.0))
            ),
      )),
    );
  }
}
