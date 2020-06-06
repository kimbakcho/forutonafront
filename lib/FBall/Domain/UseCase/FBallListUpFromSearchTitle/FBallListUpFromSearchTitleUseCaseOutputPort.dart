import 'package:forutonafront/FBall/Data/Entity/FBall.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';

abstract class FBallListUpFromSearchTitleUseCaseOutputPort {
  onBallListUpFromSearchTitle(List<FBallResDto> fBallResDtoList);
  onBallListUpFromSearchTitleBallTotalCount(int count);
}