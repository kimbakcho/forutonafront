import 'package:meta/meta.dart';
import 'package:forutonafront/FBall/Dto/FBallJoinReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';

import 'IssueBallUseCaseOp.dart';

abstract class IssueBallUseCaseIp {
  Future<int> ballHit({@required FBallReqDto reqDto,@required IssueBallUseCaseOp op});
  Future<int> joinBall({@required FBallJoinReqDto reqDto});
  Future<FBallResDto> selectBall({@required String ballUuid,@required IssueBallUseCaseOp op});
  Future<int> deleteBall({@required String ballUuid,@required IssueBallUseCaseOp op});
}