import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/FBall/Presentation/Widget/BallStyle/Style3/BallStyle3Widget.dart';

class FBallResForMarker extends FBallResDto {
  bool isSelectBall = false;

  final Function onTopEvent;

  BallStyle3Widget ballStyle3Widget;

  FBallResForMarker(
      this.isSelectBall, this.onTopEvent,FBallResDto ballResDto)
      : super(){
    ballStyle3Widget = BallStyle3Widget.create(ballResDto: ballResDto);
  }
}
