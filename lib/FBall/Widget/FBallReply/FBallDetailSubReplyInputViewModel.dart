import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyInsertReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyResWrapDto.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallSubReplyResDto.dart';
import 'package:forutonafront/FBall/Repository/FBallReplyRepository.dart';

class FBallDetailSubReplyInputViewModel extends ChangeNotifier{
  final FBallSubReplyResDto mainReply;
  final BuildContext _context;
  bool _isBackSendButton = false;
  bool _isLoading = false;
  getIsLoading(){
    return _isLoading;
  }
  _setIsLoading(bool value){
    _isLoading = value;
    notifyListeners();
  }

  StreamSubscription _keyboard;
  TextEditingController subReplyController = new TextEditingController();
  FBallReplyRepository _fBallReplyRepository = FBallReplyRepository();
  FBallDetailSubReplyInputViewModel(this.mainReply,this._context){
    _keyboard = KeyboardVisibility.onChange.listen((value) {
      if (!value) {
        _keyboard.cancel();
        if (!_isBackSendButton) {
          Navigator.of(_context).pop();
        }
      }
    });
  }
  @override
  void dispose() {
    _keyboard.cancel();
    super.dispose();
  }

  void sendSubReply(FBallSubReplyResDto mainReply) async {
    _setIsLoading(true);
    _isBackSendButton = true;
    FBallReplyInsertReqDto reqDto= new FBallReplyInsertReqDto();
    reqDto.replyText = subReplyController.text;
    reqDto.replyNumber = mainReply.replyNumber;
    reqDto.ballUuid = mainReply.ballUuid;
    reqDto.replySort = 1;
    reqDto.replyDepth = 1;
    await _fBallReplyRepository.insertFBallReply(reqDto);

    FBallReplyReqDto subReplyReqDto = FBallReplyReqDto();
    subReplyReqDto.ballUuid = mainReply.ballUuid;
    subReplyReqDto.replyNumber = mainReply.replyNumber;
    subReplyReqDto.detail = false;
    FBallReplyResWrapDto fBallReplyResWrapDto = await _fBallReplyRepository.getFBallSubReply(subReplyReqDto);
    _setIsLoading(false);
    Navigator.of(_context).pop(fBallReplyResWrapDto.contents);

  }

}