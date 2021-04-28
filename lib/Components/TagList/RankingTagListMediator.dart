
import 'package:forutonafront/Common/Page/Dto/PageWrap.dart';
import 'package:forutonafront/Common/PageableDto/Pageable.dart';
import 'package:forutonafront/Common/SearchCollectMediator/SearchCollectMediator.dart';
import 'package:forutonafront/AppBis/Tag/Domain/UseCase/TagRankingUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/Tag/Dto/TagRankingResDto.dart';
import 'package:injectable/injectable.dart';

abstract class RankingTagListMediator
    extends SearchCollectMediator<TagRankingResDto> {

  TagRankingUseCaseInputPort? tagRankingUseCaseInputPort;

}

@Injectable(as: RankingTagListMediator)
class RankingTagListMediatorImpl extends RankingTagListMediator {

  TagRankingUseCaseInputPort? tagRankingUseCaseInputPort;


  @override
  bool isNullSearchUseCase() {
    if (tagRankingUseCaseInputPort == null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<PageWrap<TagRankingResDto>> searchUseCase(Pageable pageable) async {
    // currentSearchPosition = searchPosition;
    var list = await tagRankingUseCaseInputPort!.search();
    return PageWrap<TagRankingResDto>(content: list,
        first: true,
        last: true,
        empty: false,
        size: 10,
        totalPages: 1,
        totalElements: 10);
  }

}
