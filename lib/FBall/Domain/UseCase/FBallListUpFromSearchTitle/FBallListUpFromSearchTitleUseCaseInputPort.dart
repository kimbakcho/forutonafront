import 'package:flutter/cupertino.dart';
import 'package:forutonafront/FBall/Dto/FBallListUpFromSearchTitleReqDto.dart';

import 'FBallListUpFromSearchTitleUseCaseOutputPort.dart';

abstract class FBallListUpFromSearchTitleUseCaseInputPort{
  ballListUpFromSearchTitle({@required FBallListUpFromSearchTitleReqDto reqDto});
  addBallListUpFromSearchTitleListener({@required FBallListUpFromSearchTitleUseCaseOutputPort outputPort});
  addBallListUpFromSearchTitleTotalCountListener({@required FBallListUpFromSearchTitleUseCaseOutputPort outputPort});
}