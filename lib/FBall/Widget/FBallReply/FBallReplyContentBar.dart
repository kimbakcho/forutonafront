import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/Common/TimeUitl/TimeDisplayUtil.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyInsertReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyResDto.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallSubReplyResDto.dart';
import 'package:forutonafront/FBall/Repository/FBallReplyRepository.dart';
import 'package:forutonafront/FBall/Widget/FBallReply/FBallDetailReplyViewModel.dart';
import 'package:forutonafront/FBall/Widget/FBallReply/FBallDetailSubReplyInputView.dart';
import 'package:forutonafront/FBall/Widget/FBallReply/FBallReplyUtil.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:forutonafront/Preference.dart';
import 'package:google_fonts/google_fonts.dart';

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
                    e, false, false, true, widget._maxWidth-40),
              ))
          .toList());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      key: UniqueKey(),
      children: <Widget>[
        FlatButton(
          onPressed: widget._showSubReply && !widget.fBallReplyResDto.deleteFlag
              ? () async {
                  FBallReplyResDto resDto = await showGeneralDialog(
                      context: context,
                      barrierDismissible: true,
                      transitionDuration: Duration(milliseconds: 300),
                      barrierColor: Colors.black.withOpacity(0.3),
                      barrierLabel: MaterialLocalizations.of(context)
                          .modalBarrierDismissLabel,
                      pageBuilder: (_context, Animation animation,
                          Animation secondaryAnimation) {
                        return FBallDetailSubReplyInputView(
                            widget.fBallReplyResDto);
                      });
                  setState(() {
                    if(resDto != null){
                      subFBallReplyContentBar.insert(
                          0,
                          Container(
                            key: UniqueKey(),
                            margin: EdgeInsets.only(left: 50),
                            child: FBallReplyContentBar(
                                resDto, false, false, true, widget._maxWidth-40),
                          ));
                    }
                  });
                }
              : null,
          padding: EdgeInsets.all(0),
          child: parentReply(context),
        ),
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
        padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    width: widget._showBottomDivider ? 1 : 0,
                    color: Color(0xffF2F0F1)))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            widget.fBallReplyResDto.replyDepth == 0
                ? Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: NetworkImage(getUserPorfilePicktureUrl()),
                            fit: BoxFit.contain)),
                  )
                : Container(
                    width: 21,
                    height: 21,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: NetworkImage(getUserPorfilePicktureUrl()),
                            fit: BoxFit.contain)),
                  ),
            Expanded(
                child: Container(
                    margin: EdgeInsets.only(left: 12),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(children: <Widget>[
                            Container(
                                child:
                                    Text(getUserNickName(),
                                        style: GoogleFonts.notoSans(
                                          fontWeight: FontWeight.w700,

                                          fontSize: 11,
                                          color: Color(0xff454f63),
                                        )))
                          ]),
                          Row(children: <Widget>[
                            Container(
                              width: widget._maxWidth-92,
                                child: Text(getBallText(),
                                    style: GoogleFonts.notoSans(
                                      fontSize: 10,
                                      color: Color(0xff454f63),
                                    )))
                          ]),
                          Row(
                            children: <Widget>[
                              Container(
                                  child: Text(getReplyUpdateDateTime(),
                                      style: GoogleFonts.notoSans(
                                        fontSize: 9,
                                        color: Color(0xffb1b1b1),
                                      )))
                            ],
                          )
                        ]))),
            !widget.fBallReplyResDto.deleteFlag
                ? Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(shape: BoxShape.circle),
                    child: FlatButton(
                        padding: EdgeInsets.all(0),
                        onPressed: () async {
                          var firebaseUser =
                              await FirebaseAuth.instance.currentUser();
                          if (widget.fBallReplyResDto.uid == firebaseUser.uid) {
                            ModifyReturnValue result =
                                await FBallReplyUtil().modifyPopup(context);
                            if (result == ModifyReturnValue.Edit) {
                              await _editReply(context);
                            } else if (result == ModifyReturnValue.Delete) {
                              _deleteReply();
                            }
                          } else {
                            //추후 신고 하기 구현 할 자리
                          }
                        },
                        shape: CircleBorder(),
                        child: Icon(
                          ForutonaIcon.pointdash,
                          size:
                              widget.fBallReplyResDto.replyDepth == 0 ? 15 : 8,
                        )))
                : Container()
          ],
        ));
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
        .popupInputDisplay(context,fBallReplyInsertReqDto.ballUuid,reqDto: fBallReplyInsertReqDto);
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
      return TimeDisplayUtil.getRemainingToStrFromNow(
          widget.fBallReplyResDto.replyUpdateDateTime);
    }
  }

  String getUserNickName() {
    if (widget.fBallReplyResDto.deleteFlag) {
      return "";
    } else {
      return widget.fBallReplyResDto.userNickName;

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

