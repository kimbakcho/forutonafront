import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyInsertReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyResDto.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyResWrapDto.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallSubReplyResDto.dart';
import 'package:forutonafront/FBall/Widget/FBallReply/FBallDetailReplyViewModel.dart';
import 'package:forutonafront/FBall/Widget/FBallReply/FBallInputReplyView.dart';
import 'package:forutonafront/FBall/Widget/FBallReply/FBallReplyWidgetViewController.dart';
import 'package:forutonafront/JCodePage/J001/J001View.dart';

class FBallReplyUtil {
  List<FBallSubReplyResDto> replyResWrapToSubReplyResDtoList(FBallReplyResWrapDto fBallReplyResWrapDto) {
    var contents = fBallReplyResWrapDto.contents;
    List<FBallSubReplyResDto> fBallSubReplyResDto = [];
    var replyList = contents.where((item) {
      return item.replySort == 0;
    });
    var mainReplyList = replyList.toList();
    mainReplyList.sort((x1, x2) {
      return x1.replyUploadDateTime
          .difference(x2.replyUploadDateTime)
          .isNegative
          ? 1
          : -1;
    });
    for (var mainReply in mainReplyList) {
      FBallSubReplyResDto item =
      FBallSubReplyResDto.fromFBallReplyResDto(mainReply);
      var subReply = contents.where((item) {
        if (item.replySort == 0) {
          return false;
        } else if (item.replyNumber == mainReply.replyNumber) {
          return true;
        } else {
          return false;
        }
      });
      var subReplyList = subReply.toList();
      subReplyList.sort((x1, x2) {
        return x1.replyUploadDateTime
            .difference(x2.replyUploadDateTime)
            .isNegative
            ? 1
            : -1;
      });
      item.subReply = subReplyList;
      fBallSubReplyResDto.add(item);
    }
    return fBallSubReplyResDto;
  }

  Future<ModifyReturnValue> modifyPopup(BuildContext context) async {
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
    return result;
  }

  Future<FBallReplyResDto> popupInputDisplay(BuildContext context,String ballUuid,{FBallReplyInsertReqDto reqDto}) async {
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    if (firebaseUser != null) {
      FBallReplyInsertReqDto reqDto1 = reqDto;
      if(reqDto1 == null){
        reqDto1 = new FBallReplyInsertReqDto();
        reqDto1.ballUuid = ballUuid;
      }
      FBallReplyResDto fBallReplyResDto = await showGeneralDialog(
          context: context,
          barrierDismissible: true,
          transitionDuration: Duration(milliseconds: 300),
          barrierColor: Colors.black.withOpacity(0.3),
          barrierLabel:
          MaterialLocalizations.of(context).modalBarrierDismissLabel,
          pageBuilder:
              (_context, Animation animation, Animation secondaryAnimation) {
            return FBallInputReplyView(reqDto1);
          });
      return fBallReplyResDto;
    } else {
      await Navigator.push(
          context,
          MaterialPageRoute(
              settings: RouteSettings(name: "/J001"),
              builder: (context) {
                return J001View();
              }));
      return null;
    }
  }
}