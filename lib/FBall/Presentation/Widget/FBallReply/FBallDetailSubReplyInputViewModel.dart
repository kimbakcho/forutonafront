import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyInsertReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyResDto.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyResWrapDto.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallSubReplyResDto.dart';
import 'package:forutonafront/FBall/Repository/FBallReplyRepository.dart';
import 'package:forutonafront/GlobalModel.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

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
    reqDto.replyUuid = Uuid().v4();
    reqDto.replyText = subReplyController.text;
    reqDto.replyNumber = mainReply.replyNumber;
    reqDto.ballUuid = mainReply.ballUuid;
    reqDto.replySort = 1;
    reqDto.replyDepth = 1;
    _fBallReplyRepository.insertFBallReply(reqDto);

    FBallReplyResDto resDto = FBallReplyResDto();
    resDto.replyUuid = reqDto.replyUuid;
    resDto.deleteFlag = false;
    resDto.replySort = reqDto.replySort ;
    resDto.replyDepth =reqDto.replyDepth;
    resDto.replyNumber = reqDto.replyNumber;
    resDto.ballUuid =  reqDto.ballUuid;
    GlobalModel globalModel = Provider.of(_context,listen: false);
    resDto.userProfilePictureUrl = globalModel.fUserInfoDto.profilePictureUrl;
    resDto.userNickName = globalModel.fUserInfoDto.nickName;
    resDto.replyUpdateDateTime = DateTime.now();
    resDto.replyText=  reqDto.replyText;
    resDto.uid = globalModel.fUserInfoDto.uid;
    Navigator.of(_context).pop(resDto);
  }





  void onReplySubmitted(String value) {
    sendSubReply(mainReply);
  }
}