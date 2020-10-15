import 'package:flutter/material.dart';

abstract class BallOptionPopup {
  Future<void>  showPopup(BuildContext context);
}

abstract class BallOptionWidget {
  Widget child(BuildContext context);
}

class BasicBallOptionPopup implements BallOptionPopup {

  BallOptionWidget ballOptionWidget;

  BasicBallOptionPopup(this.ballOptionWidget);

  @override
  Future<void> showPopup(BuildContext context) async {
      await showGeneralDialog(
          context: context,
          barrierDismissible: true,
          transitionDuration: Duration(milliseconds: 300),
          barrierColor: Colors.black.withOpacity(0.3),
          barrierLabel:
          MaterialLocalizations.of(context).modalBarrierDismissLabel,
          pageBuilder:
              (_context, Animation animation, Animation secondaryAnimation) {
            return ballOptionWidget.child(context);
          });
    }
}