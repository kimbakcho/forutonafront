import 'package:forutonafront/FBall/Dto/FBallResDto.dart';

class FBallResForMarkerDto extends FBallResDto {
  bool isSelectBall = false;

  Function onTopEvent;

  FBallResForMarkerDto(
      this.isSelectBall, this.onTopEvent, FBallResDto ballResDto)
      : super(
            ballResDto.latitude,
            ballResDto.longitude,
            ballResDto.ballUuid,
            ballResDto.ballName,
            ballResDto.ballType,
            ballResDto.ballState,
            ballResDto.placeAddress,
            ballResDto.ballLikes,
            ballResDto.ballDisLikes,
            ballResDto.commentCount,
            ballResDto.ballPower,
            ballResDto.activationTime,
            ballResDto.makeTime,
            ballResDto.description,
            ballResDto.nickName,
            ballResDto.profilePicktureUrl,
            ballResDto.uid,
            ballResDto.userLevel,
            ballResDto.distanceWithMapCenter,
            ballResDto.distanceDisplayText,
            ballResDto.contributor,
            ballResDto.ballDeleteFlag);
}
