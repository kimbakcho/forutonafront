import 'package:flutter/material.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';

class IssueBallReduceSizeWidget extends StatelessWidget {

  final FBallResDto fBallResDto;

  const IssueBallReduceSizeWidget({Key key, this.fBallResDto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(15.0))
      ),
      child: Text(fBallResDto.ballUuid),
    );
  }
}
