import 'package:flutter/material.dart';
import 'package:forutonafront/Common/TimeUitl/TimeDisplayUtil.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyResDto.dart';
import 'package:forutonafront/Preference.dart';

class FBallReplyContentBar extends StatelessWidget {
  FBallReplyResDto _fBallReplyResDto;
  FBallReplyContentBar(this._fBallReplyResDto);
  @override
  Widget build(BuildContext context) {
    return Container(
      key: UniqueKey(),
        width: MediaQuery.of(context).size.width,
        height: 61,
        padding: EdgeInsets.fromLTRB(16, 15, 16, 13),
        decoration: BoxDecoration(
            border:
            Border(bottom: BorderSide(width: 1, color: Color(0xffF2F0F1)))),
        child: Stack(children: <Widget>[
          Positioned(
            left: 0,
            top: 0,
            width: 32,
            height: 32,
            child: Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: NetworkImage(getUserPorfilePicktureUrl()))),
            ),
          ),
          Positioned(
              top: 0,
              left: 44,
              child: RichText(
                  text: TextSpan(
                      text: getUserNickName(),
                      style: TextStyle(
                        fontFamily: "Noto Sans CJK KR",
                        fontWeight: FontWeight.w700,
                        fontSize: 11,
                        color: Color(0xff454f63),
                      ),
                      children: [
                        TextSpan(
                            text: getReplyUpdateDateTime(),
                            style: TextStyle(
                              fontFamily: "Noto Sans CJK KR",
                              fontSize: 9,
                              color: Color(0xffb1b1b1),
                            ))
                      ]))),
          Positioned(
              left: 44,
              bottom: 0,
              width: MediaQuery.of(context).size.width - 76,
              child: Container(
                  child: Text(
                    getBallText(),
                    style: TextStyle(
                      fontFamily: "Noto Sans CJK KR",
                      fontSize: 10,
                      color: Color(0xff454f63),
                    ),
                    overflow: TextOverflow.ellipsis,
                  )))
        ]));
  }

  String getUserPorfilePicktureUrl() {
    if(_fBallReplyResDto.deleteFlag){
      return Preference.basicProfileImageUrl;
    }else {
      return _fBallReplyResDto.userProfilePictureUrl;
    }
  }
  String getReplyUpdateDateTime() {
    if(_fBallReplyResDto.deleteFlag){
      return "";
    }else {
      return "   " +
          TimeDisplayUtil.getRemainingToStrFromNow(_fBallReplyResDto.replyUpdateDateTime);
    }
  }

  String getUserNickName() {
    if(_fBallReplyResDto.deleteFlag){
      return "";
    }else {
      return _fBallReplyResDto.userNickName;;
    }
  }

  String getBallText() {
    if (_fBallReplyResDto.deleteFlag) {
      return "삭제됨";
    } else {
      return _fBallReplyResDto.replyText;
    }
  }

}
