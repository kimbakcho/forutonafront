import 'package:flutter/material.dart';
import 'package:forutonafront/Tag/Domain/Repository/TagRepository.dart';
import 'package:forutonafront/Tag/Dto/TagRankingFromBallInfluencePowerReqDto.dart';
import 'package:forutonafront/Tag/Dto/TagRankingResDto.dart';

import 'TagRankingUseCaseInputPort.dart';

abstract class TagRankingFromBallInfluencePowerUseCaseOutputPort {
  void onTagRankingFromBallInfluencePower(
      List<TagRankingResDto> tagRankingDtos);
}

class TagRankingFromBallInfluencePowerUseCase
    implements TagRankingUseCaseInputPort {
  TagRepository tagRepository;
  TagRankingFromBallInfluencePowerReqDto reqDto;

  TagRankingFromBallInfluencePowerUseCase({
    @required this.tagRepository,
    @required this.reqDto,

  }) : assert(tagRepository != null);

  @override
  Future<List<TagRankingResDto>> search() async {
    List<TagRankingResDto> fBallTagRankings =
        await tagRepository.getFTagRankingFromBallInfluencePower(reqDto);
    return fBallTagRankings;
  }
}
