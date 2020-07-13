import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyInsertReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyResDto.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyResWrapDto.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallSubReplyResDto.dart';
import 'package:forutonafront/FBall/Presentation/Widget/FBallReply/FBallDetailReplyViewModel.dart';
import 'package:forutonafront/FBall/Presentation/Widget/FBallReply/FBallInputReplyView.dart';
import 'package:forutonafront/JCodePage/J001/J001View.dart';

class FBallReplyUtil {

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

}