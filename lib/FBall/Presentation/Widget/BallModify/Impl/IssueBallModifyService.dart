
import 'package:flutter/material.dart';
import 'package:forutonafront/FBall/Presentation/Widget/BallModify/Widget/CommonBallModifyWidget.dart';
import 'package:forutonafront/FBall/Presentation/Widget/BallModify/Widget/CommonBallModifyWidgetResultType.dart';

import '../BallModifyService.dart';


class IssueBallModifyService implements BallModifyService {
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


}