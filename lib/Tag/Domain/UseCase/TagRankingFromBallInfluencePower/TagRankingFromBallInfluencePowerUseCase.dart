import 'package:flutter/material.dart';
import 'package:forutonafront/Tag/Data/DataSource/FBallTagRemoteDataSource.dart';
import 'package:forutonafront/Tag/Data/Repository/TagRepositoryImpl.dart';
import 'package:forutonafront/Tag/Domain/Repository/TagRepository.dart';
import 'package:forutonafront/Tag/Dto/TagRankingDto.dart';
import 'package:forutonafront/Tag/Dto/TagRankingFromBallInfluencePowerReqDto.dart';

import 'TagRankingFromBallInfluencePowerUseCaseInputPort.dart';
import 'TagRankingFromBallInfluencePowerUseCaseOutputPort.dart';


class TagRankingFromBallInfluencePowerUseCase implements TagRankingFromBallInfluencePowerUseCaseInputPort{
  TagRepository tagRepository;
  TagRankingFromBallInfluencePowerUseCaseOutputPort outputPort;
  TagRankingFromBallInfluencePowerUseCase({@required this.tagRepository,@required this.outputPort});

  @override
  Future<void> reqTagRankingFromBallInfluencePower({@required TagRankingFromBallInfluencePowerReqDto reqDto}) async {
    var fBallTagRankingWrap = await tagRepository.getFTagRankingFromBallInfluencePower(reqDto);
    var results = fBallTagRankingWrap.contents.map((x) => TagRankingDto.fromTagRanking(x)).toList();
    outputPort.onTagRankingFromBallInfluencePower(results);
    return results;
  }

}