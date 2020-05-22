import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/Common/TimeUitl/TimeDisplayUtil.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyResDto.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:forutonafront/Preference.dart';

class FBallDetailReplySubContentBar extends StatelessWidget {
  final FBallReplyResDto fBallReplyResDto;
  Function(FBallReplyResDto) modifyPopup;
  Function(FBallReplyResDto) reportPopup;

  FBallDetailReplySubContentBar(this.fBallReplyResDto, {this.modifyPopup});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: UniqueKey(),
      margin: EdgeInsets.fromLTRB(55, 0, 16, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              width: 21,
              height: 21,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: NetworkImage(
                          getUserPorfilePicktureUrl())))),
          Expanded(
              child: Container(
                  child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                      child: Container(
                    child: Text(getUserNickName(),
                        style: TextStyle(
                          fontFamily: "Noto Sans CJK KR",
                          fontWeight: FontWeight.w700,
                          fontSize: 11,
                          color: Color(0xff454f63),
                        )),
                    margin: EdgeInsets.only(left: 8),
                  )),
                  !fBallReplyResDto.deleteFlag
                      ? Container(
                          width: 12,
                          height: 12,
                          child: FlatButton(
                              onPressed: () async {
                                var firebaseUser =
                                    await FirebaseAuth.instance.currentUser();
                                if (fBallReplyResDto.uid == firebaseUser.uid) {
                                  this.modifyPopup(fBallReplyResDto);
                                } else {
//                                  this.reportPopup(fBallReplyResDto);
                                }
                              },
                              padding: EdgeInsets.all(0),
                              child: Icon(
                                ForutonaIcon.pointdash,
                                size: 10,
                                color: Color(0xff454F63),
                              )))
                      : Container()
                ],
              ),
              Container(
                  margin: EdgeInsets.only(left: 8, right: 16),
                  child: Text(getBallText(),
                      style: TextStyle(
                        fontFamily: "Noto Sans CJK KR",
                        fontSize: 10,
                        color: Color(0xff454f63),
                      ))),
              Container(
                  margin: EdgeInsets.only(left: 8),
                  child: Text(getReplyUploadDateTime(),
                      style: TextStyle(
                        fontFamily: "Noto Sans CJK KR",
                        fontSize: 9,
                        color: Color(0xffb1b1b1),
                      )))
            ],
          )))
        ],
      ),
    );
  }

  String getUserPorfilePicktureUrl() {
    if(fBallReplyResDto.deleteFlag){
      return Preference.basicProfileImageUrl;
    }else {
      return fBallReplyResDto.userProfilePictureUrl;
    }
  }

  String getReplyUploadDateTime(){
    if(fBallReplyResDto.deleteFlag){
      return "";
    }else {
      return TimeDisplayUtil.getRemainingToStrFromNow(
          fBallReplyResDto.replyUploadDateTime);
    }
  }

  String getUserNickName() {
    if(fBallReplyResDto.deleteFlag){
      return "";
    }else {
      return fBallReplyResDto.userNickName;
    }
  }

  String getBallText() {
    if (fBallReplyResDto.deleteFlag) {
      return "삭제됨";
    } else {
      return fBallReplyResDto.replyText;
    }
  }
}
