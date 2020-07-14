import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:forutonafront/FBall/Domain/UseCase/FBallReply/FBallReplyUseCaseInputPort.dart';
import 'package:forutonafront/FBall/Domain/UseCase/FBallReply/FBallReplyUseCaseOutputPort.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyInsertReqDto.dart';
import 'package:forutonafront/FBall/Presentation/Widget/FBallReply/Popup/FBallReplyRootActionCommand.dart';

import 'package:uuid/uuid.dart';

class FBallReplyRootActionViewModel extends ChangeNotifier {
  StreamSubscription keyboard;
  bool isBackSendButton = false;
  final BuildContext context;
  final FBallReplyRootActionCommand _fBallReplyRootActionCommand;
  final TextEditingController replyTextController = new TextEditingController();


  bool _isLoading = false;

  getIsLoading() {
    return _isLoading;
  }

  _setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  FBallReplyRootActionViewModel(
      {@required this.context,
      FBallReplyRootActionCommand fBallReplyRootActionCommand})
      : _fBallReplyRootActionCommand = fBallReplyRootActionCommand {
    _fBallReplyRootActionCommand.init(replyTextController);
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

  Future<void> fBallReplyAction() async {
    isBackSendButton = true;
    _setIsLoading(true);
    await _fBallReplyRootActionCommand.execute(replyTextController.text);
    _setIsLoading(false);
    Navigator.of(context).pop();
  }


}
