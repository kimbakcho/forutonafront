import 'package:forutonafront/FBall/Dto/FBallResDto.dart';

abstract class FBallUseCaseOutputPort {
  void onBallHit();
  void onSelectBall(FBallResDto fBallResDto);
  void onDeleteBall();
  void onInsertBall(FBallResDto fBallResDto);
  void onUpdateBall() {}
}