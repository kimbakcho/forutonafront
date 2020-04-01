import 'package:forutonafront/Common/FDio.dart';
import 'package:forutonafront/Common/Geolocation/DistanceDisplayUtil.dart';
import 'package:forutonafront/FBall/Dto/FBallListUpReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallListUpWrapDto.dart';
import 'package:geolocator/geolocator.dart';

class FBallRepository {
  Future<FBallListUpWrapDto> listUpBall(FBallListUpReqDto reqDto) async {
    FDio dio = new FDio("nonetoken");
    var response =
        await dio.get("/v1/FBall/BallListUp", queryParameters: reqDto.toJson());
    var fBallListUpWrapDto = FBallListUpWrapDto.fromJson(response.data);
    var position = await Geolocator().getLastKnownPosition();
    for (var ball in fBallListUpWrapDto.balls) {
      ball.distanceWithMapCenter = await Geolocator().distanceBetween(
          ball.latitude, ball.longitude, position.latitude, position.longitude);
      ball.distanceDisplayText = DistanceDisplayUtil.changeDisplayStr(ball.distanceWithMapCenter);
    }
    return fBallListUpWrapDto;
  }
}
