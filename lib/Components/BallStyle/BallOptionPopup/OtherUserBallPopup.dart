import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/Components/BallListUp/BallListMediator.dart';
import 'package:forutonafront/Components/BallStyle/BallOptionButton/BallBasicOptionButton.dart';
import 'package:forutonafront/Components/BallStyle/BallOptionButton/NoInterestBallAddAction.dart';
import 'package:forutonafront/AppBis/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';

import 'BallOptionBallNameWidget.dart';
import 'BallOptionPopup.dart';

class OtherUserBallPopup implements BallOptionWidget {
  final FBallResDto ballResDto;
  final BallListMediator ballListMediator;

  OtherUserBallPopup(
      {@required this.ballResDto, @required this.ballListMediator});

  @override
  Widget child(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
          child: Container(
        width: 220,
        height: 264,
        child: Column(
          children: <Widget>[
            BallOptionBallNameWidget(ballName: ballResDto.ballName),
            Divider(thickness: 1, height: 1, color: Color(0xffE4E7E8)),
            BallBasicOptionButton(ballText: "공유하기"),
            Divider(thickness: 1, height: 1, color: Color(0xffE4E7E8)),
            BallBasicOptionButton(
              ballText: "관심없음",
              ballOptionButtonAction: NoInterestBallAddAction(
                noInterestBallUseCaseInputPort: sl(),
                ballListMediator: ballListMediator,
                fBallResDto: ballResDto
              ),
            ),
            Divider(thickness: 1, height: 1, color: Color(0xffE4E7E8)),
            BallBasicOptionButton(ballText: "즐겨찾기에저장"),
            Divider(thickness: 1, height: 1, color: Color(0xffE4E7E8)),
            BallBasicOptionButton(
              ballText: "신고",
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
