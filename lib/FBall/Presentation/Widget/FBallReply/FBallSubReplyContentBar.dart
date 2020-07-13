import 'package:flutter/cupertino.dart';
import 'package:forutonafront/FBall/Data/Entity/FBallReply.dart';

class FBallSubReplyContentBar extends StatelessWidget{

  final FBallReply fBallReply;

  FBallSubReplyContentBar(this.fBallReply);

  @override
  Widget build(BuildContext context) {
    return Container(
      key: Key(fBallReply.replyUuid),
      child: Row(
        children: <Widget>[
          avatarWidget()
        ],
      ),
    );
  }
  Container avatarWidget() {
    return Container(
      margin: EdgeInsets.fromLTRB(16, 0, 16, 16),
      width: 32,
      height: 32,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
              image: NetworkImage(fBallReply.userProfilePictureUrl),
              fit: BoxFit.fitWidth)),
    );
  }

}