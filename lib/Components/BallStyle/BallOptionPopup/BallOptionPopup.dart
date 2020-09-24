import 'package:flutter/material.dart';
import 'package:forutonafront/Components/BallStyle/BallOptionButton/NoInterestBallAddAction.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/FUser/SigInInUserInfoUseCase/SignInUserInfoUseCaseInputPort.dart';
import 'package:forutonafront/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthAdapterForUseCase.dart';
import 'package:injectable/injectable.dart';

abstract class BallOptionPopup {
  Future<void>  showPopup(BuildContext context);
}

@injectable
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