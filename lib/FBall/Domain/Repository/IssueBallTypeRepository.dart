import 'package:forutonafront/FBall/Data/Entity/FBall.dart';
import 'package:forutonafront/FBall/Dto/FBallInsertReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallJoinReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallReqDto.dart';

abstract class IssueBallTypeRepository {
  Future<int> deleteBall(FBallReqDto reqDto);
  Future<int> insertBall(FBallInsertReqDto reqDto);
  Future<FBall> selectBall(FBallReqDto fBallReqDto);
  Future<int> updateBall(FBallInsertReqDto reqDto);
  Future<int> joinBall(FBallJoinReqDto reqDto);
  Future<int> ballHit(FBallReqDto reqDto);
}