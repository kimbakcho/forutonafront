import 'package:flutter/material.dart';
import 'package:forutonafront/FBall/Domain/UseCase/BallDisPlayUseCase/IssueBallDisPlayUseCase.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';

class IssueBallNotHaveImageWidget extends StatelessWidget {
  final FBallResDto fBallResDto;
  final IssueBallDisPlayUseCase issueBallDisPlayUseCase;

  IssueBallNotHaveImageWidget({Key key, this.fBallResDto})
        : issueBallDisPlayUseCase = IssueBallDisPlayUseCase(fBallResDto: fBallResDto), super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(issueBallDisPlayUseCase.ballName()),
    );
  }
}
