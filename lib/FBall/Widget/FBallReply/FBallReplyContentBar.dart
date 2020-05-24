import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/Common/TimeUitl/TimeDisplayUtil.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyInsertReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyResDto.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallSubReplyResDto.dart';
import 'package:forutonafront/FBall/Repository/FBallReplyRepository.dart';
import 'package:forutonafront/FBall/Widget/FBallReply/FBallDetailReplyViewModel.dart';
import 'package:forutonafront/FBall/Widget/FBallReply/FBallReplyUtil.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:forutonafront/Preference.dart';

class FBallReplyContentBar extends StatefulWidget {
  final FBallReplyResDto fBallReplyResDto;
  final bool _showSubReply;
  final bool _showBottomDivider;
  final double _maxWidth;
  final bool _showEditButton;

  FBallReplyContentBar(this.fBallReplyResDto, this._showSubReply,
      this._showBottomDivider, this._showEditButton, this._maxWidth);

  @override
  _FBallReplyContentBarState createState() {
    return _FBallReplyContentBarState();
  }
}

class _FBallReplyContentBarState extends State<FBallReplyContentBar> {
  List<Widget> subFBallReplyContentBar = [];
  bool subReplyOpenFlag = false;

  _FBallReplyContentBarState();

  @override
  void initState() {
    super.initState();
    if (widget.fBallReplyResDto is FBallSubReplyResDto) {
      var changeFBallReplyResDto =
          widget.fBallReplyResDto as FBallSubReplyResDto;
      subFBallReplyContentBar.addAll(changeFBallReplyResDto.subReply
          .map((e) => Container(
                key: UniqueKey(),
                margin: EdgeInsets.only(left: 50),
                child: FBallReplyContentBar(
                    e, false, false, true, widget._maxWidth - 50),
              ))
          .toList());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      key: UniqueKey(),
      children: <Widget>[
        parentReply(context),
        widget._showSubReply ? subReplyToggleBar() : Container(),
        isOpenSubReply()
            ? Column(
                children: subFBallReplyContentBar,
              )
            : Container()
      ],
    );
  }

  isOpenSubReply() {
    if (widget._showSubReply && subReplyOpenFlag) {
      return true;
    } else {
      return false;
    }
  }

  Container parentReply(BuildContext context) {
    return Container(
        key: UniqueKey(),
        width: widget._maxWidth,
        height: 61,
        padding: EdgeInsets.fromLTRB(16, 15, 16, 13),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    width: widget._showBottomDivider ? 1 : 0,
                    color: Color(0xffF2F0F1)))),
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
              width: widget._maxWidth - 76,
              child: Container(
                  child: Text(
                getBallText(),
                style: TextStyle(
                  fontFamily: "Noto Sans CJK KR",
                  fontSize: 10,
                  color: Color(0xff454f63),
                ),
                overflow: TextOverflow.ellipsis,
              ))),
          Positioned(
            right: 0,
            top: 0,
            child: !widget.fBallReplyResDto.deleteFlag
                ? Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(shape: BoxShape.circle),
                    child: FlatButton(
                      padding: EdgeInsets.all(0),
                      shape: CircleBorder(),
                      onPressed: () async {
                        var firebaseUser =
                            await FirebaseAuth.instance.currentUser();
                        if (widget.fBallReplyResDto.uid == firebaseUser.uid) {
                          ModifyReturnValue result =
                              await FBallReplyUtil().modifyPopup(context);
                          if (result == ModifyReturnValue.Edit) {
                            await _editReply(context);
                          } else {
                            _deleteReply();
                          }
                        } else {
                          //추후 신고 하기 구현 할 자리
                        }
                      },
                      child: Icon(
                        ForutonaIcon.pointdash,
                        size: 15,
                        color: Color(0xff454F63),
                      ),
                    ))
                : Container(),
          )
        ]));
  }

  Future _editReply(BuildContext context) async {
    FBallReplyInsertReqDto fBallReplyInsertReqDto =
        new FBallReplyInsertReqDto();
    fBallReplyInsertReqDto.replyUuid = widget.fBallReplyResDto.replyUuid;
    fBallReplyInsertReqDto.ballUuid = widget.fBallReplyResDto.ballUuid;
    fBallReplyInsertReqDto.replyNumber = widget.fBallReplyResDto.replyNumber;
    fBallReplyInsertReqDto.replyText = widget.fBallReplyResDto.replyText;
    fBallReplyInsertReqDto.replyDepth = widget.fBallReplyResDto.replyDepth;
    fBallReplyInsertReqDto.replySort = widget.fBallReplyResDto.replySort;
    FBallReplyResDto fBallReplyResDto = await FBallReplyUtil()
        .popupInputDisplay(fBallReplyInsertReqDto, context);
    setState(() {
      widget.fBallReplyResDto.replyText = fBallReplyResDto.replyText;
    });
  }

  void _deleteReply() {
    FBallReplyRepository fBallReplyRepository = FBallReplyRepository();
    fBallReplyRepository.deleteFBallReply(widget.fBallReplyResDto.replyUuid);
    setState(() {
      widget.fBallReplyResDto.deleteFlag = true;
    });
  }

  String getUserPorfilePicktureUrl() {
    if (widget.fBallReplyResDto.deleteFlag) {
      return Preference.basicProfileImageUrl;
    } else {
      return widget.fBallReplyResDto.userProfilePictureUrl;
    }
  }

  String getReplyUpdateDateTime() {
    if (widget.fBallReplyResDto.deleteFlag) {
      return "";
    } else {
      return "   " +
          TimeDisplayUtil.getRemainingToStrFromNow(
              widget.fBallReplyResDto.replyUpdateDateTime);
    }
  }

  String getUserNickName() {
    if (widget.fBallReplyResDto.deleteFlag) {
      return "";
    } else {
      return widget.fBallReplyResDto.userNickName;
      ;
    }
  }

  String getBallText() {
    if (widget.fBallReplyResDto.deleteFlag) {
      return "삭제됨";
    } else {
      return widget.fBallReplyResDto.replyText;
    }
  }

  Container subReplyToggleBar() {
    return subFBallReplyContentBar.length != 0
        ? Container(
            margin: EdgeInsets.only(left: 49),
            height: 20,
            alignment: Alignment.centerLeft,
            child: FlatButton(
                onPressed: () {
                  setState(() {
                    subReplyOpenFlag = !subReplyOpenFlag;
                  });
                },
                padding: EdgeInsets.all(0),
                child: RichText(
                  text: TextSpan(
                      text: subReplyOpenFlag ? "▲" : "▼",
                      style: TextStyle(
                        fontFamily: "Noto Sans CJK KR",
                        fontWeight: FontWeight.w700,
                        fontSize: 10,
                        color: Color(0xff3497fd),
                      ),
                      children: [
                        TextSpan(
                            text: "답글 숨기기(${subFBallReplyContentBar.length})",
                            style: TextStyle(
                              fontFamily: "Noto Sans CJK KR",
                              fontWeight: FontWeight.w700,
                              fontSize: 10,
                              color: Color(0xff3497fd),
                            )),
                      ]),
                )))
        : Container();
  }
}

//
//class FBallReplyContentBar extends StatelessWidget {
//
//
//  @override
//  Widget build(BuildContext context) {
//    return Column(
//      children: <Widget>[
//        parentReply(context)
//      ],
//    ) ;
//
//  }
//
//  Container parentReply(BuildContext context) {
//    return Container(
//          key: UniqueKey(),
//          width: MediaQuery.of(context).size.width,
//          height: 61,
//          padding: EdgeInsets.fromLTRB(16, 15, 16, 13),
//          decoration: BoxDecoration(
//              border:
//              Border(bottom: BorderSide(width: 1, color: Color(0xffF2F0F1)))),
//          child: Stack(children: <Widget>[
//            Positioned(
//              left: 0,
//              top: 0,
//              width: 32,
//              height: 32,
//              child: Container(
//                decoration: BoxDecoration(
//                    shape: BoxShape.circle,
//                    image: DecorationImage(
//                        image: NetworkImage(getUserPorfilePicktureUrl()))),
//              ),
//            ),
//            Positioned(
//                top: 0,
//                left: 44,
//                child: RichText(
//                    text: TextSpan(
//                        text: getUserNickName(),
//                        style: TextStyle(
//                          fontFamily: "Noto Sans CJK KR",
//                          fontWeight: FontWeight.w700,
//                          fontSize: 11,
//                          color: Color(0xff454f63),
//                        ),
//                        children: [
//                          TextSpan(
//                              text: getReplyUpdateDateTime(),
//                              style: TextStyle(
//                                fontFamily: "Noto Sans CJK KR",
//                                fontSize: 9,
//                                color: Color(0xffb1b1b1),
//                              ))
//                        ]))),
//            Positioned(
//                left: 44,
//                bottom: 0,
//                width: MediaQuery.of(context).size.width - 76,
//                child: Container(
//                    child: Text(
//                      getBallText(),
//                      style: TextStyle(
//                        fontFamily: "Noto Sans CJK KR",
//                        fontSize: 10,
//                        color: Color(0xff454f63),
//                      ),
//                      overflow: TextOverflow.ellipsis,
//                    )))
//          ])
//
//      );
//  }
//
//
//  Container subReplyToggleBar() {
//    return subFBallReplyContentBar.length != 0
//        ? Container(
//        margin: EdgeInsets.only(left: 49),
//        height: 20,
//        alignment: Alignment.centerLeft,
//        child: FlatButton(
//            onPressed: () {
//              subReplyOpenFlag = !subReplyOpenFlag;
//            },
//            padding: EdgeInsets.all(0),
//            child: RichText(
//              text: TextSpan(
//                  text: widget.fBallSubReplyResDto.replyOpenFlag ? "▲" : "▼",
//                  style: TextStyle(
//                    fontFamily: "Noto Sans CJK KR",
//                    fontWeight: FontWeight.w700,
//                    fontSize: 10,
//                    color: Color(0xff3497fd),
//                  ),
//                  children: [
//                    TextSpan(
//                        text:
//                        "답글 숨기기(${_subContentBars.length})",
//                        style: TextStyle(
//                          fontFamily: "Noto Sans CJK KR",
//                          fontWeight: FontWeight.w700,
//                          fontSize: 10,
//                          color: Color(0xff3497fd),
//                        )),
//                  ]),
//            )))
//        : Container();
//  }
//
//  String getUserPorfilePicktureUrl() {
//    if(_fBallSubReplyResDto.deleteFlag){
//      return Preference.basicProfileImageUrl;
//    }else {
//      return _fBallSubReplyResDto.userProfilePictureUrl;
//    }
//  }
//  String getReplyUpdateDateTime() {
//    if(_fBallSubReplyResDto.deleteFlag){
//      return "";
//    }else {
//      return "   " +
//          TimeDisplayUtil.getRemainingToStrFromNow(_fBallSubReplyResDto.replyUpdateDateTime);
//    }
//  }
//
//  String getUserNickName() {
//    if(_fBallSubReplyResDto.deleteFlag){
//      return "";
//    }else {
//      return _fBallSubReplyResDto.userNickName;;
//    }
//  }
//
//  String getBallText() {
//    if (_fBallSubReplyResDto.deleteFlag) {
//      return "삭제됨";
//    } else {
//      return _fBallSubReplyResDto.replyText;
//    }
//  }
//
//}
