import 'package:flutter/cupertino.dart';
import 'package:forutonafront/Tag/Dto/FBallTagResDto.dart';

import 'TagFromBallUuidUseCaseOutputPort.dart';

abstract class TagFromBallUuidUseCaseInputPort {
  Future<List<FBallTagResDto>> getTagFromBallUuid(
      {@required String ballUuid, TagFromBallUuidUseCaseOutputPort outputPort});
}
