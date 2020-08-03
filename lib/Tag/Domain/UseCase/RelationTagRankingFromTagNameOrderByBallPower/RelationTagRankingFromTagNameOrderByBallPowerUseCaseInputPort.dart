import 'package:flutter/cupertino.dart';
import 'package:forutonafront/Tag/Dto/TagRankingResDto.dart';

import 'RelationTagRankingFromTagNameOrderByBallPowerUseCaseOutputPort.dart';

abstract class RelationTagRankingFromTagNameOrderByBallPowerUseCaseInputPort {
  Future<List<TagRankingResDto>>
      searchRelationTagRankingFromTagNameOrderByBallPower(
          {@required String searchTag,
          RelationTagRankingFromTagNameOrderByBallPowerUseCaseOutputPort
              outputPort});
}
