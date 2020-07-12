import 'package:flutter/cupertino.dart';
import 'package:forutonafront/Tag/Domain/Repository/TagRepository.dart';
import 'package:forutonafront/Tag/Dto/RelationTagRankingFromTagNameReqDto.dart';
import 'package:forutonafront/Tag/Dto/TagRankingDto.dart';

import 'RelationTagRankingFromTagNameOrderByBallPowerUseCaseInputPort.dart';
import 'RelationTagRankingFromTagNameOrderByBallPowerUseCaseOutputPort.dart';

class RelationTagRankingFromTagNameOrderByBallPowerUseCase
    implements RelationTagRankingFromTagNameOrderByBallPowerUseCaseInputPort {
  TagRepository _tagRepository;

  RelationTagRankingFromTagNameOrderByBallPowerUseCase(
      {TagRepository tagRepository})
      : _tagRepository = tagRepository;

  @override
  Future<List<TagRankingDto>>
      searchRelationTagRankingFromTagNameOrderByBallPower(
          {@required RelationTagRankingFromTagNameReqDto reqDto,
          RelationTagRankingFromTagNameOrderByBallPowerUseCaseOutputPort
              outputPort}) async {
    var fBallTagRankingWrap = await _tagRepository
        .getRelationTagRankingFromTagNameOrderByBallPower(reqDto);
    var result = fBallTagRankingWrap.contents
        .map((x) => TagRankingDto.fromTagRanking(x))
        .toList();
    outputPort.onRelationTagRankingFromTagNameOrderByBallPower(result);
    return result;
  }
}
