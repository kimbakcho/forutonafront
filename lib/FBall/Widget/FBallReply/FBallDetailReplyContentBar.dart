import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/Common/TimeUitl/TimeDisplayUtil.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyInsertReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyResDto.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallSubReplyResDto.dart';
import 'package:forutonafront/FBall/Repository/FBallReplyRepository.dart';
import 'package:forutonafront/FBall/Widget/FBallReply/FBallDetailReplySubContentBar.dart';
import 'package:forutonafront/FBall/Widget/FBallReply/FBallDetailReplyViewModel.dart';
import 'package:forutonafront/FBall/Widget/FBallReply/FBallDetailSubReplyInputView.dart';
import 'package:forutonafront/FBall/Widget/FBallReply/FBallInputReplyView.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:forutonafront/JCodePage/J001/J001View.dart';
import 'package:forutonafront/Preference.dart';

class FBallDetailReplyContentBar extends StatefulWidget {
  final FBallSubReplyResDto fBallSubReplyResDto;
  FBallDetailReplyContentBar(this.fBallSubReplyResDto);

  @override
  _FBallDetailReplyContentBarState createState() => _FBallDetailReplyContentBarState();
}

class _FBallDetailReplyContentBarState extends State<FBallDetailReplyContentBar> {

  List<FBallDetailReplySubContentBar> _subContentBars = [];

  @override

  void initState() {
      super.initState();
      _subContentBars.addAll(widget.fBallSubReplyResDto.subReply
          .map((e) => FBallDetailReplySubContentBar(e,modifyPopup: modifyPopup)).toList());
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      key: UniqueKey(),
      children: <Widget>[
        mainReplyBar(context),
        subReplyToggleBar(),
        widget.fBallSubReplyResDto.replyOpenFlag
            ? subReplyBar()
            : Container()
      ],
    );
  }

  FlatButton mainReplyBar(BuildContext context) {
    return FlatButton(
        padding: EdgeInsets.all(0),
        onPressed: () async {
          var firebaseUser = await FirebaseAuth.instance.currentUser();
          if(firebaseUser != null ){
            List<FBallReplyResDto> subReplyItem = await showGeneralDialog(
                context: context,
                barrierDismissible: false,
                transitionDuration: Duration(milliseconds: 300),
                barrierColor: Colors.black.withOpacity(0.3),
                barrierLabel:
                MaterialLocalizations.of(context).modalBarrierDismissLabel,
                pageBuilder:
                    (_context, Animation animation, Animation secondaryAnimation) {
                  return FBallDetailSubReplyInputView(widget.fBallSubReplyResDto);
                });
            if (subReplyItem != null) {
              _subContentBars.clear();
              _subContentBars.addAll(subReplyItem.map((e) => FBallDetailReplySubContentBar(e)).toList()) ;
            }
            setState(() {
            });
          }else {
            Navigator.push(
                context,
                MaterialPageRoute(
                    settings: RouteSettings(name: "/J001"),
                    builder: (context) {
                      return J001View();
                    }));
          }
        },
        child: Container(
          child: Row(
            children: <Widget>[
              Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: NetworkImage(
                              getUserPorfilePicktureUrl()))),
                  width: 32,
                  height: 32),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                            )),
                        !widget.fBallSubReplyResDto.deleteFlag ?
                        Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(shape: BoxShape.circle),
                            child: FlatButton(
                              padding: EdgeInsets.all(0),
                              shape: CircleBorder(),
                              onPressed: () async {
                                var firebaseUser =
                                await FirebaseAuth.instance.currentUser();
                                if (widget.fBallSubReplyResDto.uid ==
                                    firebaseUser.uid) {
                                  this.modifyPopup(widget.fBallSubReplyResDto);
                                } else {

                                }
                              },
                              child: Icon(
                                ForutonaIcon.pointdash,
                                size: 15,
                                color: Color(0xff454F63),
                              ),
                            )) : Container()
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 16),
                      child: Text(getBallText(),
                          style: TextStyle(
                            fontFamily: "Noto Sans CJK KR",
                            fontSize: 10,
                            color: Color(0xff454f63),
                          )),
                    ),
                    Container(
                      child: Text(
                          getReplyUploadDateTime(),
                          style: TextStyle(
                            fontFamily: "Noto Sans CJK KR",
                            fontSize: 9,
                            color: Color(0xffb1b1b1),
                          )),
                    )
                  ],
                ),
                width: MediaQuery.of(context).size.width - 75,
                margin: EdgeInsets.only(left: 11),
              )
            ],
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
          padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
        ));
  }

  Container subReplyToggleBar() {
    return widget.fBallSubReplyResDto.subReply.length != 0
        ? Container(
        margin: EdgeInsets.only(left: 49),
        height: 20,
        alignment: Alignment.centerLeft,
        child: FlatButton(
            onPressed: () {
              setState(() {
                widget.fBallSubReplyResDto.replyOpenFlag = !widget.fBallSubReplyResDto.replyOpenFlag;
              });
            },
            padding: EdgeInsets.all(0),
            child: RichText(
              text: TextSpan(
                  text: widget.fBallSubReplyResDto.replyOpenFlag ? "▲" : "▼",
                  style: TextStyle(
                    fontFamily: "Noto Sans CJK KR",
                    fontWeight: FontWeight.w700,
                    fontSize: 10,
                    color: Color(0xff3497fd),
                  ),
                  children: [
                    TextSpan(
                        text:
                        "답글 숨기기(${_subContentBars.length})",
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

  ListView subReplyBar() {
    return ListView.builder(
        key: UniqueKey(),
        physics: NeverScrollableScrollPhysics(),
        itemCount: _subContentBars.length,
        shrinkWrap: true,
        itemBuilder: (context, subIndex) {
          return _subContentBars[subIndex];
        });
  }




  void modifyPopup(FBallReplyResDto detailReply) async {
    ModifyReturnValue result = await showGeneralDialog(
        context: context,
        barrierDismissible: true,
        transitionDuration: Duration(milliseconds: 300),
        barrierColor: Colors.black.withOpacity(0.3),
        barrierLabel:
        MaterialLocalizations.of(context).modalBarrierDismissLabel,
        pageBuilder:
            (_context, Animation animation, Animation secondaryAnimation) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: Stack(
              children: <Widget>[
                Positioned(
                    left: 0,
                    bottom: 0,
                    width: MediaQuery.of(_context).size.width,
                    child: Container(
                        color: Colors.white,
                        child: Column(children: <Widget>[
                          Container(
                            child: FlatButton(
                              padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                              onPressed: () {
                                Navigator.of(_context)
                                    .pop(ModifyReturnValue.Edit);
                              },
                              child: Row(children: <Widget>[
                                Icon(
                                  Icons.edit,
                                  color: Colors.black,
                                ),
                                Container(child: Text("수정하기"))
                              ]),
                            ),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Color(0xffF5F5F5), width: 1))),
                          ),
                          Container(
                            child: FlatButton(
                                padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                                onPressed: () {
                                  Navigator.of(_context)
                                      .pop(ModifyReturnValue.Delete);
                                },
                                child: Row(children: <Widget>[
                                  Icon(Icons.delete, color: Colors.black),
                                  Container(
                                    child: Text("삭제하기"),
                                  )
                                ])),
                          )
                        ])))
              ],
            ),
          );
        });
    if (result == ModifyReturnValue.Edit) {
      await replyChangeAction(detailReply);
    } else if (result == ModifyReturnValue.Delete) {
      await replyDelete(detailReply);
    }
    setState(() {

    });
  }

  Future replyDelete(FBallReplyResDto detailReply) async {
    ModifyReturnValue result = await showGeneralDialog(
        context: context,
        barrierDismissible: true,
        transitionDuration: Duration(milliseconds: 300),
        barrierColor: Colors.black.withOpacity(0.3),
        barrierLabel:
        MaterialLocalizations.of(context).modalBarrierDismissLabel,
        pageBuilder:
            (_context, Animation animation, Animation secondaryAnimation) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
                child: Container(
                  height: 130.00,
                  width: 332.00,
                  child: Column(
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.all(16),
                          child: Text("삭제 하시겠습니까?",
                              style: TextStyle(
                                fontFamily: "Noto Sans CJK KR",
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
                                color: Color(0xff000000),
                              ))),
                      Row(
                        children: <Widget>[
                          Expanded(
                              child: Container(
                                margin: EdgeInsets.all(16),
                                height: 32.00,
                                child: FlatButton(
                                  onPressed: () async {
                                    await replyDeleteAction(detailReply);
                                    Navigator.of(_context)
                                        .pop(ModifyReturnValue.Delete);
                                  },
                                  padding: EdgeInsets.all(0),
                                  child: Text("삭제",
                                      style: TextStyle(
                                        fontFamily: "Noto Sans CJK KR",
                                        fontWeight: FontWeight.w700,
                                        fontSize: 13,
                                        color: Color(0xff3497fd),
                                      )),
                                ),
                                decoration: BoxDecoration(
                                  color: Color(0xffffffff),
                                  border: Border.all(
                                    width: 1.00,
                                    color: Color(0xff454f63),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      offset: Offset(0.00, 12.00),
                                      color: Color(0xff455b63).withOpacity(0.08),
                                      blurRadius: 16,
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(5.00),
                                ),
                              )),
                          Expanded(
                              child: Container(
                                margin: EdgeInsets.all(16),
                                height: 32.00,
                                child: FlatButton(
                                  onPressed: () {
                                    Navigator.of(_context).pop();
                                  },
                                  padding: EdgeInsets.all(0),
                                  child: Text("취소",
                                      style: TextStyle(
                                        fontFamily: "Noto Sans CJK KR",
                                        fontWeight: FontWeight.w700,
                                        fontSize: 13,
                                        color: Color(0xff3497fd),
                                      )),
                                ),
                                decoration: BoxDecoration(
                                  color: Color(0xffffffff),
                                  border: Border.all(
                                    width: 1.00,
                                    color: Color(0xff454f63),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      offset: Offset(0.00, 12.00),
                                      color: Color(0xff455b63).withOpacity(0.08),
                                      blurRadius: 16,
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(5.00),
                                ),
                              ))
                        ],
                      )
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xffffffff),
                    border: Border.all(
                      width: 1.00,
                      color: Color(0xff000000),
                    ),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0.00, 3.00),
                        color: Color(0xff000000).withOpacity(0.16),
                        blurRadius: 6,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(10.00),
                  ),
                )),
          );
        });
    if (result != null && result == ModifyReturnValue.Delete) {
      detailReply.replyText = "삭제 되었습니다.";
      detailReply.deleteFlag = true;
      setState(() {

      });
    }
  }
  Future replyChangeAction(FBallReplyResDto detailReply) async {
    var changeText = await showGeneralDialog(
        context: context,
        barrierDismissible: true,
        transitionDuration: Duration(milliseconds: 300),
        barrierColor: Colors.black.withOpacity(0.3),
        barrierLabel:
        MaterialLocalizations.of(context).modalBarrierDismissLabel,
        pageBuilder:
            (_context, Animation animation, Animation secondaryAnimation) {
          FBallReplyInsertReqDto fBallReplyInsertReqDto =
          FBallReplyInsertReqDto();
          fBallReplyInsertReqDto.ballUuid = detailReply.ballUuid;
          fBallReplyInsertReqDto.idx = detailReply.idx;
          fBallReplyInsertReqDto.replyText = detailReply.replyText;
          return FBallInputReplyView(fBallReplyInsertReqDto);
        });
    detailReply.replyText = changeText;
  }
  Future<void> replyDeleteAction(FBallReplyResDto detailReply) async {
    FBallReplyRepository _fBallReplyRepository = new FBallReplyRepository();
    await _fBallReplyRepository.deleteFBallReply(detailReply.idx);
  }

  String getUserPorfilePicktureUrl() {
    if(widget.fBallSubReplyResDto.deleteFlag){
      return Preference.basicProfileImageUrl;
    }else {
      return widget.fBallSubReplyResDto.userProfilePictureUrl;
    }
  }

  String getReplyUploadDateTime(){
    if(widget.fBallSubReplyResDto.deleteFlag){
      return "";
    }else {
      return TimeDisplayUtil.getRemainingToStrFromNow(
          widget.fBallSubReplyResDto.replyUploadDateTime);
    }
  }

  String getUserNickName() {
    if(widget.fBallSubReplyResDto.deleteFlag){
      return "";
    }else {
      return widget.fBallSubReplyResDto.userNickName;
    }
  }

  String getBallText() {
    if (widget.fBallSubReplyResDto.deleteFlag) {
      return "삭제됨";
    } else {
      return widget.fBallSubReplyResDto.replyText;
    }
  }

}

