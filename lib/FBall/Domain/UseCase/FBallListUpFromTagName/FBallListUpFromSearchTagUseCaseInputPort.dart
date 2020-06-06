import 'package:flutter/material.dart';
import 'package:forutonafront/FBall/Dto/FBallListUpFromTagNameReqDto.dart';

import 'FBallListUpFromSearchTagUseCaseOutputPort.dart';

abstract class FBallListUpFromSearchTagNameUseCaseInputPort {
  ballListUpFromSearchTagName({@required FBallListUpFromTagNameReqDto reqDto});
  addBallListUpFromSearchTagNameListener({@required FBallListUpFromSearchTagNameUseCaseOutputPort outputPort});
  addBallListUpFromSearchTagNameTotalCountListener({@required FBallListUpFromSearchTagNameUseCaseOutputPort outputPort});
}