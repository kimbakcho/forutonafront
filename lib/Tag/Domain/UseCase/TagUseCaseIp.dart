import 'package:flutter/cupertino.dart';
import 'package:forutonafront/Tag/Dto/TagRankingDto.dart';
import 'package:forutonafront/Tag/Dto/TagRankingReqDto.dart';

import 'TagUseCaseOp.dart';

abstract class TagUseCaseIp {
  Future<List<TagRankingDto>> getTagRanking({@required TagRankingReqDto reqDto,@required TagUseCaseOp op});
}