import 'package:flutter/material.dart';
import 'package:forutonafront/Tag/Data/Repository/TagRepositoryImpl.dart';
import 'package:forutonafront/Tag/Domain/Repository/ITagRepository.dart';
import 'package:forutonafront/Tag/Dto/TagRankingDto.dart';

import 'package:forutonafront/Tag/Dto/TagRankingReqDto.dart';

import 'TagUseCaseIp.dart';
import 'TagUseCaseOp.dart';

class TagUseCase implements TagUseCaseIp{

  ITagRepository _iTagRepository = TagRepositoryImpl();

  @override
  Future<List<TagRankingDto>> getTagRanking({@required TagRankingReqDto reqDto,@required TagUseCaseOp op}) async {
    var fBallTagRankingWrap = await _iTagRepository.getTagRanking(reqDto);
    var results = fBallTagRankingWrap.contents.map((x) => TagRankingDto.fromTagRanking(x)).toList();
    op.onTagRanking(results);
    return results;
  }

}