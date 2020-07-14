import 'package:flutter/cupertino.dart';
import 'package:forutonafront/FBall/Data/Entity/FBallReply.dart';
import 'package:forutonafront/FBall/Presentation/Widget/FBallReply/Popup/FBallReplyPopupUseCaseInputPort.dart';
import 'package:forutonafront/ForutonaUser/Data/Entity/FUserInfo.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/Auth/AuthUserCaseInputPort.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/FUser/SigInInUserInfoUseCase/SignInUserInfoUseCaseInputPort.dart';



class FBallSubReplyContentBarViewModel extends ChangeNotifier {
  final FBallReply fBallReply;
  final BuildContext context;
  final AuthUserCaseInputPort _authUserCaseInputPort;
  final SignInUserInfoUseCaseInputPort _signInUserInfoUseCaseInputPort;
  final FBallReplyPopupUseCaseInputPort _fBallReplyPopupUseCaseInputPort;

  FBallSubReplyContentBarViewModel(
      {@required
          this.fBallReply,
      @required
          this.context,
      @required
          AuthUserCaseInputPort authUserCaseInputPort,
      @required
          SignInUserInfoUseCaseInputPort signInUserInfoUseCaseInputPort,
      @required
          FBallReplyPopupUseCaseInputPort fBallReplyPopupUseCaseInputPort})
      : _authUserCaseInputPort = authUserCaseInputPort,
        _signInUserInfoUseCaseInputPort = signInUserInfoUseCaseInputPort,
        _fBallReplyPopupUseCaseInputPort = fBallReplyPopupUseCaseInputPort;

  void optionPopup() {
    var userInfo =
        _signInUserInfoUseCaseInputPort.reqSignInUserInfoFromMemory();
    if (isUserSelfReply(userInfo)) {
      _fBallReplyPopupUseCaseInputPort.modifyPopup(context, fBallReply);
    } else {
      //TODO 신고 하기
    }
  }

  bool isUserSelfReply(FUserInfo userInfo) => fBallReply.uid == userInfo.uid;
}
