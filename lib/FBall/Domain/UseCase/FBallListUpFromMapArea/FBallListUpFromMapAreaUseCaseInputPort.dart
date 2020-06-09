import 'package:flutter/cupertino.dart';
import 'package:forutonafront/FBall/Dto/BallFromMapAreaReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';

import 'FBallListUpFromMapAreaUseCaseOutputPort.dart';

abstract class FBallListUpFromMapAreaUseCaseInputPort {
  Future<List<FBallResDto>> ballListUpFromMapArea({@required BallFromMapAreaReqDto reqDto,@required FBallListUpFromMapAreaUseCaseOutputPort outputPort});
}