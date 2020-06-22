import 'package:flutter/cupertino.dart';
import 'package:forutonafront/Tag/Dto/TagRankingDto.dart';
import 'package:forutonafront/Tag/Dto/TagRankingFromBallInfluencePowerReqDto.dart';

import 'TagRankingFromBallInfluencePowerUseCaseOutputPort.dart';

abstract class TagRankingFromBallInfluencePowerUseCaseInputPort {
  Future<void> reqTagRankingFromBallInfluencePower(TagRankingFromBallInfluencePowerReqDto reqDto,TagRankingFromBallInfluencePowerUseCaseOutputPort outputPort);
}