import 'package:flutter/cupertino.dart';
import 'package:forutonafront/Components/BallStyle/Style3/BallStyle3Widget.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';


class FBallResForMarker {
  bool isSelectBall = false;

  final Function onTopEvent;

  FBallResDto ballResDto;

  BallStyle3Widget ballStyle3Widget;

  FBallResForMarker(
  {@required this.isSelectBall,@required this.onTopEvent,@required this.ballResDto}) {
    ballStyle3Widget = BallStyle3Widget.create(ballResDto: ballResDto);
  }
}
