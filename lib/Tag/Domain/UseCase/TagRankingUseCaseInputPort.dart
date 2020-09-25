import 'package:forutonafront/Tag/Dto/TagRankingResDto.dart';

abstract class TagRankingUseCaseInputPort {
  Future<List<TagRankingResDto>> search();
}