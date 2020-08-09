import 'package:flutter/material.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyResDto.dart';

class BasicReViewsContentBar extends StatelessWidget {

  final FBallReplyResDto _fBallReplyResDto;

  BasicReViewsContentBar({FBallReplyResDto fBallReplyResDto}):_fBallReplyResDto=fBallReplyResDto;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: Key(_fBallReplyResDto.replyUuid),
      child: Row(
        children: <Widget>[

        ],
      ),

    );
  }
}
