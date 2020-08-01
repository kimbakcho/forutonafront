import 'package:flutter/material.dart';
import 'package:forutonafront/FBall/Presentation/Widget/BallModify/Widget/CommonBallModifyWidget.dart';
import 'package:forutonafront/FBall/Presentation/Widget/BallModify/Widget/CommonBallModifyWidgetResultType.dart';

import '../BallModifyService.dart';

class IssueBallModifyService implements BallModifyService {
  final AuthUserCaseInputPort _authUserCaseInputPort;

  IssueBallModifyService(
      {@required AuthUserCaseInputPort authUserCaseInputPort})
      : _authUserCaseInputPort = authUserCaseInputPort;

  @override
  Future<CommonBallModifyWidgetResultType> showModifySelectDialog(
      {@required BuildContext context}) async {
    CommonBallModifyWidgetResultType commandResult = await showGeneralDialog(
        context: context,
        barrierDismissible: true,
        transitionDuration: Duration(milliseconds: 300),
        barrierColor: Colors.black.withOpacity(0.3),
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        pageBuilder:
            (_context, Animation animation, Animation secondaryAnimation) {
          return CommonBallModifyWidget();
        });
    return commandResult;
  }

  @override
  Future<bool> isCanModify({@required String ballMakeUid}) async {
    if (ballMakeUid == await _authUserCaseInputPort.myUid()) {
      return true;
    } else {
      return false;
    }
  }
}
