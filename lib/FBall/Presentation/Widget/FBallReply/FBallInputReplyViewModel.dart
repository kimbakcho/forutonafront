import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:forutonafront/FBall/Domain/UseCase/FBallReply/FBallReplyUseCaseInputPort.dart';
import 'package:forutonafront/FBall/Domain/UseCase/FBallReply/FBallReplyUseCaseOutputPort.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyInsertReqDto.dart';
import 'package:forutonafront/FBall/Presentation/Widget/FBallReply/FBallReplyMediator.dart';
import 'package:uuid/uuid.dart';

class FBallInputReplyViewModel extends ChangeNotifier {
  StreamSubscription keyboard;
  bool isBackSendButton = false;
  final BuildContext context;
  final FBallReplyInsertReqDto _fBallReplyInsertReqDto;
  final FBallReplyMediator _fBallReplyMediator;

  TextEditingController replyTextController = new TextEditingController();

  bool _isLoading = false;

  getIsLoading() {
    return _isLoading;
  }

  _setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  FBallInputReplyViewModel(
      {@required this.context,
      @required FBallReplyInsertReqDto fBallReplyInsertReqDto,
      @required FBallReplyMediator fBallReplyMediator})
      : _fBallReplyInsertReqDto = fBallReplyInsertReqDto,
        _fBallReplyMediator = fBallReplyMediator {
    if (isUpdateMode()) {
      replyTextController.text = fBallReplyInsertReqDto.replyText;
    }
    keyBoardVisibilitySetting();
  }

  StreamSubscription<bool> keyBoardVisibilitySetting() {
    return keyboard = KeyboardVisibility.onChange.listen((value) {
      if (!value) {
        keyboard.cancel();
        if (!isBackSendButton) {
          Navigator.of(context).pop();
        }
      }
    });
  }

  bool isUpdateMode() => _fBallReplyInsertReqDto.replyUuid != null;

  void insertReply() async {
    isBackSendButton = true;
    await fBallReplyInsert();
    replyTextController.clear();
  }

  Future<void> fBallReplyInsert() async {
    _setIsLoading(true);
    _fBallReplyInsertReqDto.replyUuid = Uuid().v4();
    _fBallReplyInsertReqDto.replyNumber = -1;
    _fBallReplyInsertReqDto.replyDepth = 0;
    _fBallReplyInsertReqDto.replySort = 0;
    _fBallReplyInsertReqDto.replyText = replyTextController.text;
    await _fBallReplyMediator.insertFBallReply(_fBallReplyInsertReqDto);
    _setIsLoading(false);
    Navigator.of(context).pop();
  }

  Future<void> updateReply() async {
    isBackSendButton = true;
    _setIsLoading(true);
    _fBallReplyInsertReqDto.replyText = replyTextController.text;
    await _fBallReplyMediator.updateFBallReply(_fBallReplyInsertReqDto);
    _setIsLoading(false);
    Navigator.of(context).pop();
  }

  reqInsertOrUpdate() {
    if (isUpdateMode()) {
      updateReply();
    } else {
      insertReply();
    }
  }

  void onReplySubmitted(String value) {
    reqInsertOrUpdate();
  }
}
