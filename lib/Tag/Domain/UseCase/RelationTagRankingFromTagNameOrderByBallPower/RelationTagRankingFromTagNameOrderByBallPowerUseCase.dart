import 'package:flutter/cupertino.dart';
import 'package:forutonafront/Tag/Domain/Repository/TagRepository.dart';
import 'package:forutonafront/Tag/Dto/TagRankingResDto.dart';
import 'RelationTagRankingFromTagNameOrderByBallPowerUseCaseInputPort.dart';
import 'RelationTagRankingFromTagNameOrderByBallPowerUseCaseOutputPort.dart';

class RelationTagRankingFromTagNameOrderByBallPowerUseCase
    implements RelationTagRankingFromTagNameOrderByBallPowerUseCaseInputPort {
  TagRepository _tagRepository;

  RelationTagRankingFromTagNameOrderByBallPowerUseCase(
      {TagRepository tagRepository})
      : _tagRepository = tagRepository;

  @override
  Future<List<TagRankingResDto>>
      searchRelationTagRankingFromTagNameOrderByBallPower(
          {@required String searchTag,
          RelationTagRankingFromTagNameOrderByBallPowerUseCaseOutputPort
              outputPort}) async {
    List<TagRankingResDto> tagRankingResDots = await _tagRepository
        .getRelationTagRankingFromTagNameOrderByBallPower(searchTag);

    outputPort.onRelationTagRankingFromTagNameOrderByBallPower(tagRankingResDots);
    return tagRankingResDots;
  }
}
