import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart';
import 'package:forutonafront/Common/Page/Dto/PageWrap.dart';
import 'package:forutonafront/Common/PageableDto/Pageable.dart';
import 'package:forutonafront/FBall/Domain/Repository/FBallRepository.dart';
import 'package:forutonafront/FBall/Domain/UseCase/BallListUp/FBallListUpUseCaseInputPort.dart';
import 'package:forutonafront/FBall/Dto/BallFromMapAreaReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:injectable/injectable.dart';

class FBallListUpFromMapArea implements FBallListUpUseCaseInputPort {
  final FBallRepository _fBallRepository;
  BallFromMapAreaReqDto reqDto;

  FBallListUpFromMapArea(this.reqDto, {FBallRepository fBallRepository})
      : _fBallRepository = fBallRepository;

  @override
  Future<PageWrap<FBallResDto>> search(Pageable pageable,
      {FBallListUpUseCaseOutputPort outputPort}) async {
    searchPosition = Position(longitude: reqDto.centerPointLng,latitude: reqDto.centerPointLat);
    PageWrap<FBallResDto> pageWrap = await _fBallRepository
        .ballListUpFromMapArea(reqDto: reqDto, pageable: pageable);
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
