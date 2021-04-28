import 'package:flutter/material.dart';
import 'package:forutonafront/Components/BallModify/Widget/CommonBallModifyWidget.dart';
import 'package:forutonafront/Components/BallModify/Widget/CommonBallModifyWidgetResultType.dart';
import 'package:forutonafront/AppBis/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthAdapterForUseCase.dart';

import '../BallModifyService.dart';

class IssueBallModifyService implements BallModifyService {

  final FireBaseAuthAdapterForUseCase _fireBaseAuthAdapterForUseCase;

  IssueBallModifyService(
      {required FireBaseAuthAdapterForUseCase fireBaseAuthAdapterForUseCase})
      : _fireBaseAuthAdapterForUseCase = fireBaseAuthAdapterForUseCase;

  @override
  Future<CommonBallModifyWidgetResultType?> showModifySelectDialog(
      {required BuildContext context}) async {
    CommonBallModifyWidgetResultType? commandResult = await showGeneralDialog(
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
  Future<bool> isCanModify({required String ballMakeUid}) async {
    if (ballMakeUid == await _fireBaseAuthAdapterForUseCase.userUid()) {
      return true;
    } else {
      return false;
    }
  }
}
