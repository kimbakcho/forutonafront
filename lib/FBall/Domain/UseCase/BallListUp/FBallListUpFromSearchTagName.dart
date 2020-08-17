import 'package:forutonafront/Common/Page/Dto/PageWrap.dart';
import 'package:forutonafront/Common/PageableDto/Pageable.dart';
import 'package:forutonafront/FBall/Domain/Repository/FBallRepository.dart';
import 'package:forutonafront/FBall/Domain/UseCase/BallListUp/FBallListUpUseCaseInputPort.dart';
import 'package:forutonafront/FBall/Dto/FBallListUpFromTagNameReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';

class FBallListUpFromSearchTagName implements FBallListUpUseCaseInputPort {
  FBallListUpFromTagNameReqDto reqDto;
  final FBallRepository _fBallRepository;

  FBallListUpFromSearchTagName(this.reqDto, {FBallRepository fBallRepository})
      : _fBallRepository = fBallRepository;

  @override
  Future<PageWrap<FBallResDto>> search(Pageable pageable,
      {FBallListUpUseCaseOutputPort outputPort}) async {
    PageWrap<FBallResDto> pageWrap = await _fBallRepository.listUpFromTagName(
        reqDto: reqDto, pageable: pageable);
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
