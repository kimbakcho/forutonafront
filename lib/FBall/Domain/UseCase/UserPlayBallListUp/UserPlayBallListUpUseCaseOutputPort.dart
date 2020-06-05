import 'package:forutonafront/FBall/Dto/UserBall/UserToMakeBallResDto.dart';
import 'package:forutonafront/FBall/Dto/UserBall/UserToPlayBallResDto.dart';

abstract class UserPlayBallListUpUseCaseOutputPort {
  onBallPlayerListUp(List<UserToPlayBallResDto> userToPlayBallResDtos);
}