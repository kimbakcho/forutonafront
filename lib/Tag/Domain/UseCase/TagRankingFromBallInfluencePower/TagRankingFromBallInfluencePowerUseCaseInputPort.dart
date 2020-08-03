import 'package:flutter/cupertino.dart';
import 'package:forutonafront/Tag/Dto/TagRankingResDto.dart';
import 'package:forutonafront/Tag/Dto/TagRankingFromBallInfluencePowerReqDto.dart';

import 'TagRankingFromBallInfluencePowerUseCaseOutputPort.dart';

abstract class TagRankingFromBallInfluencePowerUseCaseInputPort {
  Future<List<TagRankingResDto>> reqTagRankingFromBallInfluencePower(TagRankingFromBallInfluencePowerReqDto reqDto,TagRankingFromBallInfluencePowerUseCaseOutputPort outputPort);
}