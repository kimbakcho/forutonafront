import 'package:forutonafront/Common/FDio.dart';
import 'package:forutonafront/Common/Geolocation/DistanceDisplayUtil.dart';
import 'package:forutonafront/FBall/Dto/BallFromMapAreaReqDto.dart';
import 'package:forutonafront/FBall/Dto/BallNameSearchReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallListUpReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallListUpWrapDto.dart';
import 'package:forutonafront/FBall/Dto/UserToMakerBallReqDto.dart';
import 'package:forutonafront/FBall/Dto/UserToMakerBallResWrapDto.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class FBallRepository {

  /// 지도로 부터 사각형 양끝단을 받아 BackEnd 로 부터 범위 검색
  Future<FBallListUpWrapDto> listUpBallFromMapArea(BallFromMapAreaReqDto reqDto) async {
    FDio dio = new FDio("nonetoken");
    var response =
        await dio.get("/v1/FBall/BallListUpFromMapArea", queryParameters: reqDto.toJson());
    var fBallListUpWrapDto = FBallListUpWrapDto.fromJson(response.data);
    var position = await Geolocator().getLastKnownPosition();
    for (var ball in fBallListUpWrapDto.balls) {
      ball.distanceWithMapCenter = await Geolocator().distanceBetween(
          ball.latitude, ball.longitude, position.latitude, position.longitude);
      ball.distanceDisplayText = DistanceDisplayUtil.changeDisplayStr(ball.distanceWithMapCenter);
    }
    return fBallListUpWrapDto;
  }

  Future<FBallListUpWrapDto> listUpBallFromSearchText(BallNameSearchReqDto reqDto) async {
    FDio dio = new FDio("nonetoken");
    var response =
        await dio.get("/v1/FBall/BallListUpFromSearchText", queryParameters: reqDto.toJson());
    var fBallListUpWrapDto = FBallListUpWrapDto.fromJson(response.data);
    var position = await Geolocator().getLastKnownPosition();
    for (var ball in fBallListUpWrapDto.balls) {
      ball.distanceWithMapCenter = await Geolocator().distanceBetween(
          ball.latitude, ball.longitude, position.latitude, position.longitude);
      ball.distanceDisplayText = DistanceDisplayUtil.changeDisplayStr(ball.distanceWithMapCenter);
    }
    return fBallListUpWrapDto;
  }

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

  /**
   * User가 만든 Ball을 찾음.
   */
  Future<UserToMakerBallResWrapDto> getUserToMakerBalls(UserToMakerBallReqDto reqDto) async {
    FDio dio = new FDio("nonetoken");
    var response =
      await dio.get("/v1/FBall/UserToMakerBalls", queryParameters: reqDto.toJson());
    var userToMakerBallResWrapDto = UserToMakerBallResWrapDto.fromJson(response.data);
    var position = await Geolocator().getLastKnownPosition();
    for (var ball in userToMakerBallResWrapDto.contents) {
      ball.distanceWithMapCenter = await Geolocator().distanceBetween(
          ball.latitude, ball.longitude, position.latitude, position.longitude);
      ball.distanceDisplayText = DistanceDisplayUtil.changeDisplayStr(ball.distanceWithMapCenter);
    }
    return userToMakerBallResWrapDto;
  }

}
