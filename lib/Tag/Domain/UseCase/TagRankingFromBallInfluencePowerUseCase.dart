import 'package:flutter/material.dart';
import 'package:forutonafront/Tag/Domain/Repository/TagRepository.dart';
import 'package:forutonafront/Tag/Dto/TagRankingResDto.dart';
import 'package:forutonafront/Tag/Dto/TagRankingFromBallInfluencePowerReqDto.dart';

abstract class TagRankingFromBallInfluencePowerUseCaseInputPort {
  Future<List<TagRankingResDto>> reqTagRankingFromBallInfluencePower(TagRankingFromBallInfluencePowerReqDto reqDto,TagRankingFromBallInfluencePowerUseCaseOutputPort outputPort);
}

abstract class TagRankingFromBallInfluencePowerUseCaseOutputPort {
  void onTagRankingFromBallInfluencePower(List<TagRankingResDto> tagRankingDtos);
}

class TagRankingFromBallInfluencePowerUseCase
    implements TagRankingFromBallInfluencePowerUseCaseInputPort {
  TagRepository tagRepository;

  TagRankingFromBallInfluencePowerUseCase({@required this.tagRepository})
      : assert(tagRepository != null);

  @override
  Future<List<TagRankingResDto>> reqTagRankingFromBallInfluencePower(
      TagRankingFromBallInfluencePowerReqDto reqDto,
      TagRankingFromBallInfluencePowerUseCaseOutputPort outputPort) async {
    List<TagRankingResDto> fBallTagRankings =
        await tagRepository.getFTagRankingFromBallInfluencePower(reqDto);
    outputPort.onTagRankingFromBallInfluencePower(fBallTagRankings);
    return fBallTagRankings;
  }
}
