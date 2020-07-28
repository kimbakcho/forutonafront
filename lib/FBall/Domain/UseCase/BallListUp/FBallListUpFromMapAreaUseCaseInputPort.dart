import 'package:flutter/cupertino.dart';
import 'package:forutonafront/FBall/Domain/Repository/FBallRepository.dart';
import 'package:forutonafront/FBall/Dto/BallFromMapAreaReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class FBallListUpFromMapAreaUseCaseInputPort {
  Future<List<FBallResDto>> ballListUpFromMapArea({@required BallFromMapAreaReqDto reqDto,@required FBallListUpFromMapAreaUseCaseOutputPort outputPort});
}

abstract class FBallListUpFromMapAreaUseCaseOutputPort {
  void onBallListUpFromMapArea(List<FBallResDto> resDtos, LatLng northeastLat , LatLng southwestLat);
}

class FBallListUpFromMapAreaUseCase
    implements FBallListUpFromMapAreaUseCaseInputPort {
  FBallRepository _fBallRepository;

  FBallListUpFromMapAreaUseCase({@required FBallRepository fBallRepository})
      : _fBallRepository = fBallRepository;

  Future<List<FBallResDto>> ballListUpFromMapArea(
      {@required BallFromMapAreaReqDto reqDto,
        @required FBallListUpFromMapAreaUseCaseOutputPort outputPort}) async {
    var fBallListUpWrap =
    await _fBallRepository.ballListUpFromMapArea(reqDto: reqDto);
    var result =
    fBallListUpWrap.balls.map((x) => FBallResDto.fromFBall(x)).toList();
    outputPort.onBallListUpFromMapArea(
        result,
        LatLng(reqDto.northeastLat, reqDto.northeastLng),
        LatLng(reqDto.southwestLat, reqDto.southwestLng));
    return result;
  }
}