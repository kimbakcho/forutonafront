import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyInsertReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyResDto.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/FBall/Repository/FBallReplyRepository.dart';
import 'package:forutonafront/GlobalModel.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class FBallInputReplyViewModel extends ChangeNotifier {
  StreamSubscription keyboard;
  bool isBackSendButton = false;
  final BuildContext _context;
  final FBallReplyInsertReqDto _fBallReplyInsertReqDto;

  TextEditingController replyTextController = new TextEditingController();
  FBallReplyRepository _fBallReplyRepository = new FBallReplyRepository();
  bool _isLoading = false;
  getIsLoading() {
    return _isLoading;
  }

  _setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
  FBallInputReplyViewModel(this._fBallReplyInsertReqDto,this._context) {
    if(_fBallReplyInsertReqDto.replyUuid!=null){
      replyTextController.text = _fBallReplyInsertReqDto.replyText;
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
    FBallReplyResDto fBallReplyResDto = await fBallReplyInsert();
    replyTextController.clear();
    Navigator.of(_context).pop(fBallReplyResDto);
  }

  Future<FBallReplyResDto> fBallReplyInsert() async{
    _setIsLoading(true);
    _fBallReplyInsertReqDto.replyUuid = Uuid().v4();
    _fBallReplyInsertReqDto.replyNumber = -1;
    _fBallReplyInsertReqDto.replyDepth = 0;
    _fBallReplyInsertReqDto.replySort = 0;
    _fBallReplyInsertReqDto.replyText = replyTextController.text;
    var fBallReplyResDto = await _fBallReplyRepository.insertFBallReply(_fBallReplyInsertReqDto);
    _setIsLoading(false);
    return fBallReplyResDto;
  }

  void updateReply() async {
    isBackSendButton = true;
    _fBallReplyInsertReqDto.replyText = replyTextController.text;
    _fBallReplyRepository.updateFBallReply(_fBallReplyInsertReqDto);

    FBallReplyResDto replyResDto = new FBallReplyResDto();
    replyResDto.ballUuid = _fBallReplyInsertReqDto.ballUuid;
    replyResDto.replyUuid = _fBallReplyInsertReqDto.replyUuid;
    replyResDto.deleteFlag = false;
    replyResDto.replyUpdateDateTime = DateTime.now();
    replyResDto.replyDepth = _fBallReplyInsertReqDto.replyDepth;
    replyResDto.replySort = _fBallReplyInsertReqDto.replySort ;
    replyResDto.replyText = _fBallReplyInsertReqDto.replyText;
    GlobalModel globalModel = Provider.of(_context,listen: false);
    replyResDto.uid = globalModel.fUserInfoDto.uid;
    replyResDto.userNickName =  globalModel.fUserInfoDto.nickName;
    replyResDto.userProfilePictureUrl = globalModel.fUserInfoDto.profilePictureUrl;
    replyResDto.replyNumber = _fBallReplyInsertReqDto.replyNumber;
    Navigator.of(_context).pop(replyResDto);
  }


  void onReplyInputChange(String value) {
    if(value.length >= 300){
      Fluttertoast.showToast(
          msg: "댓글/답글은 최대 300자까지 입력가능합니다",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: Color(0xff454F63),
          textColor: Colors.white,
          fontSize: 12.0);
    }
  }
}
enum ID001InputReplyViewResult {
  Insert,Modify
}
