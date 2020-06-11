
import 'package:flutter/material.dart';
import 'package:forutonafront/FBall/Presentation/Widget/BallModify/Widget/CommonBallModifyWidget.dart';
import 'package:forutonafront/FBall/Presentation/Widget/BallModify/Widget/CommonBallModifyWidgetResultType.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/Auth/AuthUserCaseInputPort.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/Auth/FireBaseAuthUseCase.dart';

import '../BallModifyService.dart';


class IssueBallModifyService implements BallModifyService {

  AuthUserCaseInputPort _authUserCaseInputPort = FireBaseAuthUseCase();

  @override
  Future<CommonBallModifyWidgetResultType> showModifySelectDialog({@required BuildContext context}) async{
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
    if(ballMakeUid == await _authUserCaseInputPort.myUid()){
      return true;
    }else {
      return false;
    }
  }


}