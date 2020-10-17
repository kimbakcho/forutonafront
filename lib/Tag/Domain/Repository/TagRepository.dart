import 'package:flutter/cupertino.dart';
import 'package:forutonafront/Common/Page/Dto/PageWrap.dart';
import 'package:forutonafront/Common/PageableDto/Pageable.dart';
import 'package:forutonafront/Tag/Dto/FBallTagResDto.dart';
import 'package:forutonafront/Tag/Dto/TagRankingFromBallInfluencePowerReqDto.dart';
import 'package:forutonafront/Tag/Dto/TagRankingFromTextReqDto.dart';
import 'package:forutonafront/Tag/Dto/TagRankingResDto.dart';
import 'package:forutonafront/Tag/Dto/TextMatchTagBallReqDto.dart';

abstract class TagRepository {
  Future<List<TagRankingResDto>> getFTagRankingFromBallInfluencePower(
      TagRankingFromBallInfluencePowerReqDto reqDto);

  Future<List<TagRankingResDto>>
      getRelationTagRankingFromTagNameOrderByBallPower(String searchTag);

  Future<List<FBallTagResDto>> tagFromBallUuid(String ballUuid);

  Future<List<TagRankingResDto>> findByTagRankingFromTextOrderBySumBI(
      {@required TagRankingFromTextReqDto tagRankingFromTextReqDto});

  Future<PageWrap<FBallTagResDto>> findByTagItem(TextMatchTagBallReqDto reqDto,Pageable pageable);
}
