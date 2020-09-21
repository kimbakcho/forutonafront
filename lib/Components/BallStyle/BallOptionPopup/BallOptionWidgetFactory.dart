import 'package:flutter/cupertino.dart';
import 'package:forutonafront/Components/BallStyle/BallOptionPopup/LogOutUserBallPopup.dart';
import 'package:forutonafront/Components/BallStyle/BallOptionPopup/OtherUserBallPopup.dart';
import 'package:forutonafront/Components/BallStyle/BallOptionPopup/UserBallPopup.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/FUser/SigInInUserInfoUseCase/SignInUserInfoUseCaseInputPort.dart';
import 'package:forutonafront/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthAdapterForUseCase.dart';

import 'BallOptionPopup.dart';

class BallOptionWidgetFactory {
  final SignInUserInfoUseCaseInputPort signInUserInfoUseCaseInputPort;
  BallOptionWidgetFactory(
      {@required this.signInUserInfoUseCaseInputPort});

  BallOptionWidget getBallOptionWidget(FBallResDto fBallResDto) {
    if ( signInUserInfoUseCaseInputPort.isLogin ) {
      if (isLoginUserBall(fBallResDto)) {
        return UserBallPopup(fBallResDto);
      } else {
        return OtherUserBallPopup(fBallResDto);
      }
    } else {
      return LogOutUserBallPopup();
    }
  }

  bool isLoginUserBall(FBallResDto fBallResDto) =>
      this.signInUserInfoUseCaseInputPort.reqSignInUserInfoFromMemory().uid ==
      fBallResDto.uid.uid;
}
