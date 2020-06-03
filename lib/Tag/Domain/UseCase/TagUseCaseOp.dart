import 'package:forutonafront/Tag/Dto/TagRankingDto.dart';

abstract class TagUseCaseOp {
  void onTagRanking(List<TagRankingDto> tagRankingDtos);
}