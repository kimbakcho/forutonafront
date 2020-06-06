import 'package:forutonafront/FBall/Dto/FBallResDto.dart';

abstract class FBallListUpFromSearchTagNameUseCaseOutputPort {
  onBallListUpFromSearchTagName(List<FBallResDto> fBallResDtoList);
  onBallListUpFromSearchTagNameBallTotalCount(int count);
}