import 'package:flutter/material.dart';
import 'package:forutonafront/FBall/Dto/FBallListUpFromTagNameReqDto.dart';

import 'FBallListUpFromSearchTagUseCaseOutputPort.dart';

abstract class FBallListUpFromSearchTagNameUseCaseInputPort {
  ballListUpFromSearchTagName(
      {@required FBallListUpFromTagNameReqDto reqDto,
      FBallListUpFromSearchTagNameUseCaseOutputPort outputPort});
}
