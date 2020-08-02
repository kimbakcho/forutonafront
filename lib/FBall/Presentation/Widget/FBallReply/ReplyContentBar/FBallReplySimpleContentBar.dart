import 'package:flutter/cupertino.dart';
import 'package:forutonafront/FBall/Domain/Entity/FBallReply.dart';

import 'package:google_fonts/google_fonts.dart';

class FBallReplySimpleContentBar extends StatelessWidget {
  final FBallReply _fBallReply;
  FBallReplySimpleContentBar(this._fBallReply);

  @override
  Widget build(BuildContext context) {
    return Container(
      key: Key(_fBallReply.replyUuid),
      child: Row(
        children: <Widget>[
          _userAvatar(),
          Expanded(
              child: Column(children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[_userNickName(), _replyUploadTime()],
            ),
            Row(children: <Widget>[
              Expanded(
                child: _replyContentText(),
              )
            ])
          ]))
        ],
      ),
    );
  }

  Container _replyContentText() {
    return Container(
      child: Text(
        _fBallReply.replyText,
        overflow: TextOverflow.ellipsis,
        style: GoogleFonts.notoSans(
          fontSize: 10,
          color: const Color(0xff454f63),
          height: 1.4,
        ),
        textAlign: TextAlign.left,
      ),
    );
  }

  Container _replyUploadTime() {
    return Container(
      margin: EdgeInsets.only(left: 6),
      child: Text(
        _fBallReply.replyUploadDateTimeString,
        style: GoogleFonts.notoSans(
          fontSize: 9,
          color: const Color(0xffb1b1b1),
        ),
        textAlign: TextAlign.left,
      ),
    );
  }

  Container _userNickName() {
    return Container(
      child: Text(
        _fBallReply.userNickName,
        style: GoogleFonts.notoSans(
          fontSize: 11,
          color: const Color(0xff454f63),
          fontWeight: FontWeight.w700,
        ),
        textAlign: TextAlign.left,
      ),
    );
  }

  Container _userAvatar() {
    return Container(
        margin: EdgeInsets.all(16),
        width: 32.0,
        height: 32.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40.0),
            image: DecorationImage(
              image: NetworkImage(_fBallReply.userProfilePictureUrl),
              fit: BoxFit.cover,
            )));
  }


}
