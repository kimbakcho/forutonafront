import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyInsertReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyResDto.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/FBall/Repository/FBallReplyRepository.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/FUser/SigInInUserInfoUseCase/SignInUserInfoUseCaseInputPort.dart';
import 'package:forutonafront/GlobalModel.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class FBallInputReplyViewModel extends ChangeNotifier {
  StreamSubscription keyboard;
  bool isBackSendButton = false;
  final BuildContext context;
  final FBallReplyInsertReqDto fBallReplyInsertReqDto;
  final SignInUserInfoUseCaseInputPort _signInUserInfoUseCaseInputPort;

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
  FBallInputReplyViewModel({
    @required this.fBallReplyInsertReqDto,
    @required this.context,
    @required SignInUserInfoUseCaseInputPort signInUserInfoUseCaseInputPort}):
  _signInUserInfoUseCaseInputPort = signInUserInfoUseCaseInputPort
  {
    if(fBallReplyInsertReqDto.replyUuid!=null){
      replyTextController.text = fBallReplyInsertReqDto.replyText;
    }
    keyboard = KeyboardVisibility.onChange.listen((value) {
      if (!value) {
        keyboard.cancel();
        if (!isBackSendButton) {
          Navigator.of(context).pop();
        }
      }
    });
  }

  void insertReply() async {
    isBackSendButton = true;
    FBallReplyResDto fBallReplyResDto = await fBallReplyInsert();
    replyTextController.clear();
    Navigator.of(context).pop(fBallReplyResDto);
  }

  Future<FBallReplyResDto> fBallReplyInsert() async{
    _setIsLoading(true);
    fBallReplyInsertReqDto.replyUuid = Uuid().v4();
    fBallReplyInsertReqDto.replyNumber = -1;
    fBallReplyInsertReqDto.replyDepth = 0;
    fBallReplyInsertReqDto.replySort = 0;
    fBallReplyInsertReqDto.replyText = replyTextController.text;
    var fBallReplyResDto = await _fBallReplyRepository.insertFBallReply(fBallReplyInsertReqDto);
    _setIsLoading(false);
    return fBallReplyResDto;
  }

  void updateReply() async {
    isBackSendButton = true;
    fBallReplyInsertReqDto.replyText = replyTextController.text;
    _fBallReplyRepository.updateFBallReply(fBallReplyInsertReqDto);

    FBallReplyResDto replyResDto = new FBallReplyResDto();
    replyResDto.ballUuid = fBallReplyInsertReqDto.ballUuid;
    replyResDto.replyUuid = fBallReplyInsertReqDto.replyUuid;
    replyResDto.deleteFlag = false;
    replyResDto.replyUpdateDateTime = DateTime.now();
    replyResDto.replyDepth = fBallReplyInsertReqDto.replyDepth;
    replyResDto.replySort = fBallReplyInsertReqDto.replySort ;
    replyResDto.replyText = fBallReplyInsertReqDto.replyText;
    var fUserInfo = _signInUserInfoUseCaseInputPort.reqSignInUserInfoFromMemory();
    replyResDto.uid = fUserInfo.uid;
    replyResDto.userNickName =  fUserInfo.nickName;
    replyResDto.userProfilePictureUrl = fUserInfo.profilePictureUrl;
    replyResDto.replyNumber = fBallReplyInsertReqDto.replyNumber;
    Navigator.of(context).pop(replyResDto);
  }

  reqInsertOrUpdate(){
    if(fBallReplyInsertReqDto.replyUuid != null){
      updateReply();
    }else {
      insertReply();
    }
  }

  void onReplySubmitted(String value) {
    reqInsertOrUpdate();
  }
}
enum ID001InputReplyViewResult {
  Insert,Modify
}
