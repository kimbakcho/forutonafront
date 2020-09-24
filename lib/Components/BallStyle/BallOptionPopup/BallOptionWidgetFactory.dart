import 'package:flutter/cupertino.dart';
import 'package:forutonafront/Components/BallListUp/BallListMediator.dart';
import 'package:forutonafront/Components/BallStyle/BallOptionPopup/LogOutUserBallPopup.dart';
import 'package:forutonafront/Components/BallStyle/BallOptionPopup/OtherUserBallPopup.dart';
import 'package:forutonafront/Components/BallStyle/BallOptionPopup/UserBallPopup.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/FUser/SigInInUserInfoUseCase/SignInUserInfoUseCaseInputPort.dart';
import 'package:injectable/injectable.dart';

import 'BallOptionPopup.dart';

@Injectable()
class BallOptionWidgetFactory {
  final SignInUserInfoUseCaseInputPort signInUserInfoUseCaseInputPort;

  BallOptionWidgetFactory({@required this.signInUserInfoUseCaseInputPort});

  BallOptionWidget getBallOptionWidget(
      BallOptionWidgetFactoryParams ballOptionWidgetFactoryParams) {
    if (signInUserInfoUseCaseInputPort.isLogin) {
      if (isLoginUserBall(ballOptionWidgetFactoryParams.fBallResDto)) {
        return UserBallPopup(ballOptionWidgetFactoryParams.fBallResDto);
      } else {
        return OtherUserBallPopup(
            ballResDto: ballOptionWidgetFactoryParams.fBallResDto,
            ballListMediator: ballOptionWidgetFactoryParams.ballListMediator);
      }
    } else {
      return LogOutUserBallPopup();
    }
  }

  bool isLoginUserBall(FBallResDto fBallResDto) =>
      this.signInUserInfoUseCaseInputPort.reqSignInUserInfoFromMemory().uid ==
      fBallResDto.uid.uid;
}

class BallOptionWidgetFactoryParams {
  final FBallResDto fBallResDto;
  final BallListMediator ballListMediator;

  BallOptionWidgetFactoryParams({this.fBallResDto, this.ballListMediator});
}
