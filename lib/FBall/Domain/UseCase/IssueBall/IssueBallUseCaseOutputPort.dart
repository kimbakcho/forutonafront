import 'package:forutonafront/FBall/Dto/FBallResDto.dart';

abstract class IssueBallUseCaseOutputPort{
  void onBallHit();
  void onSelectBall(FBallResDto fBallResDto);
  void onDeleteBall();
  void onInsertBall(FBallResDto fBallResDto);
  void onUpdateBall() {}
}