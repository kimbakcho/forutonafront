import 'package:forutonafront/AppBis/Tag/Dto/TagRankingResDto.dart';

abstract class TagRankingUseCaseInputPort {
  Future<List<TagRankingResDto>> search();
}