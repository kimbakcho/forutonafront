import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyInsertReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/FBall/Repository/FBallReplyRepository.dart';

class ID001InputReplyViewModel extends ChangeNotifier {
  StreamSubscription keyboard;
  bool isBackSendButton = false;
  final BuildContext _context;
  final FBallReplyInsertReqDto fBallReplyInsertReqDto;
  TextEditingController replyTextController = new TextEditingController();
  FBallReplyRepository _fBallReplyRepository = new FBallReplyRepository();

  ID001InputReplyViewModel(this.fBallReplyInsertReqDto,this._context) {
    if(fBallReplyInsertReqDto.idx!=null){
      replyTextController.text = fBallReplyInsertReqDto.replyText;
    }
    keyboard = KeyboardVisibility.onChange.listen((value) {
      if (!value) {
        keyboard.cancel();
        if (!isBackSendButton) {
          Navigator.of(_context).pop();
        }
      }
    });
  }

  void insertReply() async {
    isBackSendButton = true;
    await fBallReplyInsert();

    replyTextController.clear();
    Navigator.of(_context).pop(ID001InputReplyViewResult.Insert);
  }

  Future<void> fBallReplyInsert() async {
    fBallReplyInsertReqDto.replyNumber = -1;
    fBallReplyInsertReqDto.replyDepth = 0;
    fBallReplyInsertReqDto.replySort = 0;
    fBallReplyInsertReqDto.replyText = replyTextController.text;
    await _fBallReplyRepository.insertFBallReply(fBallReplyInsertReqDto);

  }

  void updateReply() async {
    isBackSendButton = true;
    fBallReplyInsertReqDto.replyText = replyTextController.text;
    await _fBallReplyRepository.updateFBallReply(fBallReplyInsertReqDto);
    Navigator.of(_context).pop(replyTextController.text);
  }

}
enum ID001InputReplyViewResult {
  Insert,Modify
}
