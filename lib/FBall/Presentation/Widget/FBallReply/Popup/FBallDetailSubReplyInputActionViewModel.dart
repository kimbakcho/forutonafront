import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:forutonafront/FBall/Data/Entity/FBallReply.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyInsertReqDto.dart';
import 'package:forutonafront/FBall/Presentation/Widget/FBallReply/Popup/FBallReplyRootActionCommand.dart';

import 'package:uuid/uuid.dart';

class FBallDetailSubReplyActionViewModel extends ChangeNotifier {
  final BuildContext context;
  final FBallReplyRootActionCommand _fBallReplyRootActionCommand;
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

  FBallDetailSubReplyActionViewModel(
      {@required this.context,

      @required FBallReplyRootActionCommand fBallReplyRootActionCommand})
      : _fBallReplyRootActionCommand = fBallReplyRootActionCommand {
    _keyboard = KeyboardVisibility.onChange.listen((value) {
      if (!value) {
        _keyboard.cancel();
        if (!_isBackSendButton) {
          Navigator.of(context).pop();
        }
      }
    });
    fBallReplyRootActionCommand.init(subReplyController);
  }

  @override
  void dispose() {
    _keyboard.cancel();
    super.dispose();
  }



  void execute() async {
    _setIsLoading(true);
    _isBackSendButton = true;
    await _fBallReplyRootActionCommand.execute(subReplyController.text);
    _setIsLoading(false);
    Navigator.of(context).pop();
  }
}
