import 'package:flutter/cupertino.dart';
import 'package:forutonafront/Tag/Dto/RelationTagRankingFromTagNameReqDto.dart';
import 'package:forutonafront/Tag/Dto/TagRankingDto.dart';

import 'RelationTagRankingFromTagNameOrderByBallPowerUseCaseOutputPort.dart';

abstract class RelationTagRankingFromTagNameOrderByBallPowerUseCaseInputPort {
  Future<List<TagRankingDto>> searchRelationTagRankingFromTagNameOrderByBallPower(
      {@required RelationTagRankingFromTagNameReqDto reqDto,RelationTagRankingFromTagNameOrderByBallPowerUseCaseOutputPort outputPort});
}