import 'package:forutonafront/Common/Page/Dto/PageWrap.dart';
import 'package:forutonafront/Common/PageableDto/Pageable.dart';
import 'package:forutonafront/FBall/Domain/Repository/FBallPlayerRepository.dart';
import 'package:forutonafront/FBall/Domain/UseCase/BallListUp/FBallListUpUseCaseInputPort.dart';
import 'package:forutonafront/FBall/Dto/FBallPlayerResDto.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';

class FBallListUpUserPlayBall implements FBallListUpUseCaseInputPort {
  String playerUid;
  final FBallPlayerRepository _fBallPlayerRepository;

  FBallListUpUserPlayBall(
      this.playerUid, FBallPlayerRepository fBallPlayerRepository)
      : _fBallPlayerRepository = fBallPlayerRepository;

  @override
  Future<PageWrap<FBallResDto>> search(Pageable pageable,
      {FBallListUpUseCaseOutputPort outputPort}) async {
    PageWrap<FBallPlayerResDto> pageWrap =
        await _fBallPlayerRepository.getUserPlayBallList(playerUid, pageable);
    var contentList = pageWrap.content.map((e) => e.ballUuid).toList();
    PageWrap<FBallResDto> pageFBallResDto = PageWrap<FBallResDto>(
        pageable: pageWrap.pageable,
        size: pageWrap.size,
        sort: pageWrap.sort,
        empty: pageWrap.empty,
        first: pageWrap.first,
        last: pageWrap.last,
        number: pageWrap.number,
        numberOfElements: pageWrap.numberOfElements,
        totalElements: pageWrap.totalElements,
        totalPages: pageWrap.totalPages,
        content: contentList);

    return pageFBallResDto;
  }
}
