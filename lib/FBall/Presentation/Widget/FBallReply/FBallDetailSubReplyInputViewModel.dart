import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:forutonafront/FBall/Data/Entity/FBallReply.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyInsertReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyResDto.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallSubReplyResDto.dart';
import 'package:forutonafront/FBall/Repository/FBallReplyRepository.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/FUser/SigInInUserInfoUseCase/SignInUserInfoUseCaseInputPort.dart';
import 'package:uuid/uuid.dart';

class FBallDetailSubReplyInputViewModel extends ChangeNotifier {
  final FBallReply mainReply;
  final BuildContext context;
  final SignInUserInfoUseCaseInputPort _signInUserInfoUseCaseInputPort;
  bool _isBackSendButton = false;
  bool _isLoading = false;

  getIsLoading() {
    return _isLoading;
  }

  _setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  StreamSubscription _keyboard;
  TextEditingController subReplyController = new TextEditingController();


  FBallDetailSubReplyInputViewModel(
      {@required this.mainReply,
      @required this.context,
      @required SignInUserInfoUseCaseInputPort signInUserInfoUseCaseInputPort})
      : _signInUserInfoUseCaseInputPort = signInUserInfoUseCaseInputPort {
    _keyboard = KeyboardVisibility.onChange.listen((value) {
      if (!value) {
        _keyboard.cancel();
        if (!_isBackSendButton) {
          Navigator.of(context).pop();
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
    FBallReplyInsertReqDto reqDto = new FBallReplyInsertReqDto();
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
    resDto.replySort = reqDto.replySort;
    resDto.replyDepth = reqDto.replyDepth;
    resDto.replyNumber = reqDto.replyNumber;
    resDto.ballUuid = reqDto.ballUuid;
    var fUserInfo =
        _signInUserInfoUseCaseInputPort.reqSignInUserInfoFromMemory();
    resDto.userProfilePictureUrl = fUserInfo.profilePictureUrl;
    resDto.userNickName = fUserInfo.nickName;
    resDto.replyUpdateDateTime = DateTime.now();
    resDto.replyText = reqDto.replyText;
    resDto.uid = fUserInfo.uid;
    Navigator.of(context).pop(resDto);
  }

  void onReplySubmitted(String value) {
    sendSubReply(mainReply);
  }
}
