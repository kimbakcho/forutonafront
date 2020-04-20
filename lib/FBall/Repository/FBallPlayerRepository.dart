import 'package:forutonafront/Common/FDio.dart';
import 'package:forutonafront/Common/Geolocation/DistanceDisplayUtil.dart';
import 'package:forutonafront/FBall/Dto/UserToPlayBallReqDto.dart';
import 'package:forutonafront/FBall/Dto/UserToPlayBallResWrapDto.dart';
import 'package:geolocator/geolocator.dart';

class FBallPlayerRepository {
  Future<UserToPlayBallResWrapDto> getUserToPlayBallList(UserToPlayBallReqDto reqDto) async{
    FDio dio = new FDio("nonetoken");
    var response =
    await dio.get("/v1/FBallPlayer/UserToPlayBallList", queryParameters: reqDto.toJson());
    var userToPlayBallResWrapDto = UserToPlayBallResWrapDto.fromJson(response.data);
    var position = await Geolocator().getLastKnownPosition();
    for (var ball in userToPlayBallResWrapDto.contents) {
      ball.distanceWithMapCenter = await Geolocator().distanceBetween(
          ball.latitude, ball.longitude, position.latitude, position.longitude);
      ball.distanceDisplayText = DistanceDisplayUtil.changeDisplayStr(ball.distanceWithMapCenter);
    }
    return userToPlayBallResWrapDto;
  }

}