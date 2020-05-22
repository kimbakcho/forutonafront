import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/FBall/Widget/BallStyle/Style3/BallStyle3Widget.dart';
import 'package:forutonafront/FBall/Widget/BallStyle/Style3/BallStyle3WidgetController.dart';

class FBallResForMarker extends FBallResDto {
  bool isSelectBall = false;

  final Function onTopEvent;

  BallStyle3Widget ballStyle3Widget;

  BallStyle3WidgetController ballStyle3WidgetController;

  FBallResForMarker(
      this.isSelectBall, this.onTopEvent,FBallResDto ballResDto, this.ballStyle3WidgetController)
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
            ballResDto.ballDeleteFlag){
    ballStyle3Widget = BallStyle3Widget.create(ballResDto.ballType,ballStyle3WidgetController);
  }
}
