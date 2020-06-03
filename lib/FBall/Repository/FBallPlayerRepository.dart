import 'package:forutonafront/Common/FDio.dart';
import 'package:forutonafront/FBall/Dto/UserBall/UserToPlayBallReqDto.dart';
import 'package:forutonafront/FBall/Dto/UserBall/UserToPlayBallResDto.dart';
import 'package:forutonafront/FBall/Dto/UserBall/UserToPlayBallResWrapDto.dart';
import 'package:forutonafront/FBall/Dto/UserBall/UserToPlayBallSelectReqDto.dart';


class FBallPlayerRepository {
  Future<UserToPlayBallResWrapDto> getUserToPlayBallList(
      UserToPlayBallReqDto reqDto) async {
    FDio dio = new FDio("nonetoken");
    var response = await dio.get("/v1/FBallPlayer/UserToPlayBallList",
        queryParameters: reqDto.toJson());
    var userToPlayBallResWrapDto =
        UserToPlayBallResWrapDto.fromJson(response.data);
    var position = await GeoLocationUtilUseCase().getCurrentWithLastPosition();
    for (var userJoinContent in userToPlayBallResWrapDto.contents) {
//      userJoinContent.fballResDto.distanceWithMapCenter = await Geolocator().distanceBetween(
//          userJoinContent.fballResDto.latitude, userJoinContent.fballResDto.longitude, position.latitude, position.longitude);
//      userJoinContent.fballResDto.distanceDisplayText =
//          DistanceDisplayUtil.changeDisplayStr(userJoinContent.fballResDto.distanceWithMapCenter);
    }
    return userToPlayBallResWrapDto;
  }

  Future<UserToPlayBallResDto> getUserToPlayBall(
      UserToPlayBallSelectReqDto reqDto) async {
    FDio dio = new FDio("nonetoken");
    var response = await dio.get("/v1/FBallPlayer/UserToPlayBall",
        queryParameters: reqDto.toJson());
    var resDto = UserToPlayBallResDto.fromJson(response.data);

    var position = await GeoLocationUtilUseCase().getCurrentWithLastPosition();
//    resDto.fballResDto.distanceWithMapCenter = await Geolocator().distanceBetween(
//        resDto.fballResDto.latitude,
//        resDto.fballResDto.longitude,
//        position.latitude,
//        position.longitude);
//    resDto.fballResDto.distanceDisplayText =
//        DistanceDisplayUtil.changeDisplayStr(resDto.fballResDto.distanceWithMapCenter);
    return resDto;
  }
}
