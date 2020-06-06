import 'package:flutter/material.dart';
import 'package:forutonafront/Tag/Data/Repository/TagRepositoryImpl.dart';
import 'package:forutonafront/Tag/Domain/Repository/TagRepository.dart';
import 'package:forutonafront/Tag/Dto/TagRankingDto.dart';
import 'package:forutonafront/Tag/Dto/TagRankingFromBallInfluencePowerReqDto.dart';

import 'TagRankingFromBallInfluencePowerUseCaseInputPort.dart';
import 'TagRankingFromBallInfluencePowerUseCaseOutputPort.dart';


class TagRankingFromBallInfluencePowerUseCase implements TagRankingFromBallInfluencePowerUseCaseInputPort{

  TagRepository _tagRepository = TagRepositoryImpl();

  @override
  Future<List<TagRankingDto>> getTagRankingFromBallInfluencePower({@required TagRankingFromBallInfluencePowerReqDto reqDto,@required TagRankingFromBallInfluencePowerUseCaseOutputPort outputPort}) async {
    var fBallTagRankingWrap = await _tagRepository.getFTagRankingFromBallInfluencePower(reqDto);
    var results = fBallTagRankingWrap.contents.map((x) => TagRankingDto.fromTagRanking(x)).toList();
    outputPort.onTagRankingFromBallInfluencePower(results);
    return results;
  }

}