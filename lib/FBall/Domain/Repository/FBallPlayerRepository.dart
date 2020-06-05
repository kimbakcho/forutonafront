import 'package:forutonafront/FBall/Data/Entity/UserToPlayBall.dart';
import 'package:forutonafront/FBall/Data/Entity/UserToPlayBallWrap.dart';
import 'package:forutonafront/FBall/Dto/UserBall/UserToPlayBallReqDto.dart';
import 'package:forutonafront/FBall/Dto/UserBall/UserToPlayBallSelectReqDto.dart';

abstract class FBallPlayerRepository {
  Future<UserToPlayBallWrap> getUserPlayBallList(UserToPlayBallReqDto reqDto);
  Future<UserToPlayBall> getUserPlayBall(UserToPlayBallSelectReqDto reqDto);
}