import 'package:forutonafront/FBall/Dto/IssueBallInsertReqDto.dart';
import 'package:forutonafront/FBall/Dto/IssueBallUpdateReqDto.dart';
import 'package:forutonafront/ICodePage/IM001/BallImageItemDto.dart';
import 'package:meta/meta.dart';
import 'package:forutonafront/FBall/Dto/FBallJoinReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';

import 'IssueBallUseCaseOutputPort.dart';

abstract class IssueBallUseCaseInputPort {
  Future<int> ballHit({@required FBallReqDto reqDto,@required IssueBallUseCaseOutputPort outputPort});
  Future<int> joinBall({@required FBallJoinReqDto reqDto});
  Future<FBallResDto> selectBall({@required String ballUuid,@required IssueBallUseCaseOutputPort outputPort});
  Future<int> deleteBall({@required String ballUuid,@required IssueBallUseCaseOutputPort outputPort});
  Future<List<BallImageItemDto>> ballImageListUpLoadAndFillUrls({@required List<BallImageItemDto> refSrcList});
  Future<int> insertBall({@required IssueBallInsertReqDto reqDto,@required IssueBallUseCaseOutputPort outputPort});
  Future<int> updateBall({@required IssueBallUpdateReqDto reqDto,@required IssueBallUseCaseOutputPort outputPort});
}