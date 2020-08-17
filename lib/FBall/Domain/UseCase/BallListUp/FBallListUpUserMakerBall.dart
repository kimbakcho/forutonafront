import 'package:forutonafront/Common/Page/Dto/PageWrap.dart';
import 'package:forutonafront/Common/PageableDto/Pageable.dart';
import 'package:forutonafront/FBall/Domain/Repository/FBallRepository.dart';
import 'package:forutonafront/FBall/Domain/UseCase/BallListUp/FBallListUpUseCaseInputPort.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';

class FBallListUpUserMakerBall implements FBallListUpUseCaseInputPort {
  final FBallRepository _fBallRepository;

  String makerUid;

  FBallListUpUserMakerBall({this.makerUid, FBallRepository fBallRepository})
      : _fBallRepository = fBallRepository;

  @override
  Future<PageWrap<FBallResDto>> search(Pageable pageable,
      {FBallListUpUseCaseOutputPort outputPort}) async {
    PageWrap<FBallResDto> pageWrap = await _fBallRepository
        .searchUserToMakerBalls(makerUid: makerUid, pageable: pageable);
    executeOutPort(outputPort, pageWrap);
    return pageWrap;
  }
  void executeOutPort(
      FBallListUpUseCaseOutputPort outputPort, PageWrap<FBallResDto> pageWrap) {
    if (outputPort != null) {
      outputPort.searchResult(pageWrap);
    }
  }
  
}
