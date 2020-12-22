import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart';
import 'package:forutonafront/Common/Page/Dto/PageWrap.dart';
import 'package:forutonafront/Common/PageableDto/Pageable.dart';
import 'package:forutonafront/AppBis/FBall/Domain/Repository/FBallRepository.dart';
import 'package:forutonafront/AppBis/FBall/Domain/UseCase/BallListUp/FBallListUpUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/FBall/Dto/FBallListUpFromBIReqDto.dart';
import 'package:forutonafront/AppBis/FBall/Dto/FBallResDto.dart';

class ListUpBallListUpOrderByBI implements FBallListUpUseCaseInputPort {
  final FBallRepository _fBallRepository;

  FBallListUpFromBIReqDto listUpReqDto;

  ListUpBallListUpOrderByBI(
      {this.listUpReqDto, FBallRepository fBallRepository})
      : _fBallRepository = fBallRepository;

  @override
  Future<PageWrap<FBallResDto>> search(Pageable pageable,
      {FBallListUpUseCaseOutputPort outputPort}) async {
    searchPosition = Position(
        latitude: listUpReqDto.mapCenterLatitude,
        longitude: listUpReqDto.mapCenterLongitude);
    PageWrap<FBallResDto> pageWrap = await _fBallRepository.findByBallOrderByBI(
        listUpReqDto: listUpReqDto, pageable: pageable);
    executeOutPort(outputPort, pageWrap);
    return pageWrap;
  }

  void executeOutPort(
      FBallListUpUseCaseOutputPort outputPort, PageWrap<FBallResDto> pageWrap) {
    if (outputPort != null) {
      outputPort.searchResult(pageWrap);
    }
  }

  @override
  Position searchPosition;
}
