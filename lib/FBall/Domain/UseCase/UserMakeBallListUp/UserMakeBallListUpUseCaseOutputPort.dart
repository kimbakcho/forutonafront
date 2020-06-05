import 'package:forutonafront/FBall/Dto/UserBall/UserToMakeBallResDto.dart';

abstract class UserMakeBallListUpUseCaseOutputPort {
  onUserMakeBallListUp(List<UserToMakeBallResDto> userToMakerBallResDtos);
}