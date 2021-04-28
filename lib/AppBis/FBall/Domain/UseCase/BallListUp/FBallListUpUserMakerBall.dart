import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart';
import 'package:forutonafront/Common/Page/Dto/PageWrap.dart';
import 'package:forutonafront/Common/PageableDto/Pageable.dart';
import 'package:forutonafront/AppBis/FBall/Domain/Repository/FBallRepository.dart';
import 'package:forutonafront/AppBis/FBall/Domain/UseCase/BallListUp/FBallListUpUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/FBall/Dto/FBallResDto.dart';

class FBallListUpUserMakerBall implements FBallListUpUseCaseInputPort {
  final FBallRepository _fBallRepository;

  String makerUid;

  FBallListUpUserMakerBall(
      {required this.makerUid, required FBallRepository fBallRepository})
      : _fBallRepository = fBallRepository;

  @override
  Future<PageWrap<FBallResDto>> search(Pageable pageable,
      {FBallListUpUseCaseOutputPort? outputPort}) async {
    searchPosition = null;
    PageWrap<FBallResDto> pageWrap = await _fBallRepository
        .searchUserToMakerBalls(makerUid: makerUid, pageable: pageable);
    executeOutPort(outputPort!, pageWrap);
    return pageWrap;
  }

  void executeOutPort(
      FBallListUpUseCaseOutputPort outputPort, PageWrap<FBallResDto> pageWrap) {
    outputPort.searchResult(pageWrap);
  }

  @override
  Position? searchPosition;
}
