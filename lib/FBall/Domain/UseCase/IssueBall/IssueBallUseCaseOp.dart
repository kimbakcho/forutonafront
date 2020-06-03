import 'package:forutonafront/FBall/Dto/FBallResDto.dart';

abstract class IssueBallUseCaseOp{
  void onBallHit();
  void onSelectBall(FBallResDto fBallResDto);
  void onDeleteBall();
}