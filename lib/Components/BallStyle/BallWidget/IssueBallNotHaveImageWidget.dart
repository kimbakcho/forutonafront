import 'package:flutter/material.dart';
import 'package:forutonafront/Components/BallListUp/BallListMediator.dart';
import 'package:forutonafront/FBall/Domain/UseCase/BallDisPlayUseCase/BallDisPlayUseCase.dart';
import 'package:forutonafront/FBall/Domain/UseCase/BallDisPlayUseCase/IssueBallDisPlayUseCase.dart';

class IssueBallNotHaveImageWidget extends StatelessWidget {
  final int index;
  final BallDisPlayUseCase issueBallDisPlayUseCase;
  final BallListMediator ballListMediator;

  IssueBallNotHaveImageWidget({Key key, this.index, this.ballListMediator})
      : issueBallDisPlayUseCase = IssueBallDisPlayUseCase(
            fBallResDto: ballListMediator.ballList[index]),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(issueBallDisPlayUseCase.ballName()),
    );
  }
}
