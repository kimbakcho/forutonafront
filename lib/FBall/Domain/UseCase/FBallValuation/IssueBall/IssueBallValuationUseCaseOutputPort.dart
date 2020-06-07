import 'package:forutonafront/FBall/Dto/FBallValuation/FBallValuationResDto.dart';

abstract class IssueBallValuationUseCaseOutputPort {
  onDeleteFBallValuation(int deletePoint);

  onFBallValuation(FBallValuationResDto fBallValuationResDto);
  onSave(FBallValuationResDto fBallValuationResDto);
}