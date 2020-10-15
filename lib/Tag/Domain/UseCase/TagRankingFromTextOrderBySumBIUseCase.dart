import 'package:forutonafront/Tag/Domain/Repository/TagRepository.dart';
import 'package:forutonafront/Tag/Dto/TagRankingFromTextReqDto.dart';
import 'package:forutonafront/Tag/Dto/TagRankingResDto.dart';

import 'TagRankingUseCaseInputPort.dart';

class TagRankingFromTextOrderBySumBIUseCase
    implements TagRankingUseCaseInputPort {

  final TagRepository tagRepository;
  final TagRankingFromTextReqDto reqDto;

  TagRankingFromTextOrderBySumBIUseCase({this.tagRepository, this.reqDto});

  @override
  Future<List<TagRankingResDto>> search() async {
    List<TagRankingResDto> fBallTagRankings =
    await tagRepository.findByTagRankingFromTextOrderBySumBI(
        tagRankingFromTextReqDto: reqDto);
    return fBallTagRankings;
  }

}