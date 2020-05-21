import 'package:forutonafront/Common/FDio.dart';
import 'package:forutonafront/Common/Geolocation/DistanceDisplayUtil.dart';
import 'package:forutonafront/FBall/Dto/UserBall/UserBallResDto.dart';
import 'package:forutonafront/FBall/Dto/UserBall/UserToPlayBallReqDto.dart';
import 'package:forutonafront/FBall/Dto/UserBall/UserToPlayBallResDto.dart';
import 'package:forutonafront/FBall/Dto/UserBall/UserToPlayBallResWrapDto.dart';
import 'package:forutonafront/FBall/Dto/UserBall/UserToPlayBallSelectReqDto.dart';
import 'package:geolocator/geolocator.dart';

class FBallPlayerRepository {
  Future<UserToPlayBallResWrapDto> getUserToPlayBallList(
      UserToPlayBallReqDto reqDto) async {
    FDio dio = new FDio("nonetoken");
    var response = await dio.get("/v1/FBallPlayer/UserToPlayBallList",
        queryParameters: reqDto.toJson());
    var userToPlayBallResWrapDto =
        UserToPlayBallResWrapDto.fromJson(response.data);
    var position = await Geolocator().getLastKnownPosition();
    for (var ball in userToPlayBallResWrapDto.contents) {
      ball.distanceWithMapCenter = await Geolocator().distanceBetween(
          ball.latitude, ball.longitude, position.latitude, position.longitude);
      ball.distanceDisplayText =
          DistanceDisplayUtil.changeDisplayStr(ball.distanceWithMapCenter);
    }
    return userToPlayBallResWrapDto;
  }

  Future<UserToPlayBallResDto> getUserToPlayBall(
      UserToPlayBallSelectReqDto reqDto) async {
    FDio dio = new FDio("nonetoken");
    var response = await dio.get("/v1/FBallPlayer/UserToPlayBall",
        queryParameters: reqDto.toJson());
    var resDto = UserToPlayBallResDto.fromJson(response.data);
    var position = await Geolocator().getLastKnownPosition();
    resDto.distanceWithMapCenter = await Geolocator().distanceBetween(
        resDto.latitude,
        resDto.longitude,
        position.latitude,
        position.longitude);
    resDto.distanceDisplayText =
        DistanceDisplayUtil.changeDisplayStr(resDto.distanceWithMapCenter);
    return resDto;
  }
}
