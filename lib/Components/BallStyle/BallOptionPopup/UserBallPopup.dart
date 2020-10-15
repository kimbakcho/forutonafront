import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/Components/BallStyle/BallOptionButton/BallBasicOptionButton.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';


import 'BallOptionBallNameWidget.dart';
import 'BallOptionPopup.dart';

class UserBallPopup implements BallOptionWidget {
  final FBallResDto ballResDto;

  UserBallPopup(this.ballResDto);

  @override
  Widget child(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
          child: Container(
        width: 220,
        height: 214,
        child: Column(
          children: <Widget>[
            BallOptionBallNameWidget(ballName: ballResDto.ballName),
            Divider(thickness: 1, height: 1, color: Color(0xffE4E7E8)),
            BallBasicOptionButton(ballText: "공유하기"),
            Divider(thickness: 1, height: 1, color: Color(0xffE4E7E8)),
            BallBasicOptionButton(ballText: "수정 하기"),
            Divider(thickness: 1, height: 1, color: Color(0xffE4E7E8)),
            BallBasicOptionButton(
              ballText: "삭제하기",
              textColor: Color(0xffFE5252),
            )
          ],
        ),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
      )),
    );
  }
}
