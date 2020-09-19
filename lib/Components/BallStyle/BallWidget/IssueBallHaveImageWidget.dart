import 'package:flutter/material.dart';
import 'package:forutonafront/FBall/Domain/UseCase/BallDisPlayUseCase/BallDisPlayUseCase.dart';
import 'package:forutonafront/FBall/Domain/UseCase/BallDisPlayUseCase/IssueBallDisPlayUseCase.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';

import 'BallBigImagePanelWidget.dart';
import 'IssueBallTopBar.dart';

class IssueBallHaveImageWidget extends StatelessWidget {
  final FBallResDto fBallResDto;
  final BallDisPlayUseCase issueBallDisPlayUseCase;

  IssueBallHaveImageWidget({Key key, this.fBallResDto})
      : issueBallDisPlayUseCase = IssueBallDisPlayUseCase(fBallResDto: fBallResDto),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          IssueBallTopBar(issueBallDisPlayUseCase: issueBallDisPlayUseCase),
          BallBigImagePanelWidget(ballDisPlayUseCase: issueBallDisPlayUseCase),
          //TODO
          //user Profile Bar 개발 필요.
        ],
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
          border: Border.all(color: Color(0xff454F63))),
    );
  }
}
