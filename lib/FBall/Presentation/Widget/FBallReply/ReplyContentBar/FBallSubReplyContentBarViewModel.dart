import 'package:flutter/cupertino.dart';
import 'package:forutonafront/FBall/Domain/Entity/FBallReply.dart';
import 'package:forutonafront/FBall/Presentation/Widget/FBallReply/Popup/FBallReplyPopupUseCaseInputPort.dart';
import 'package:forutonafront/ForutonaUser/Domain/Entity/FUserInfo.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/FUser/SigInInUserInfoUseCase/SignInUserInfoUseCaseInputPort.dart';
import 'package:forutonafront/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthAdapterForUseCase.dart';

class FBallSubReplyContentBarViewModel extends ChangeNotifier {
  final FBallReply fBallReply;
  final BuildContext context;
  final FireBaseAuthAdapterForUseCase _fireBaseAuthAdapterForUseCase;
  final SignInUserInfoUseCaseInputPort _signInUserInfoUseCaseInputPort;
  final FBallReplyPopupUseCaseInputPort _fBallReplyPopupUseCaseInputPort;

  FBallSubReplyContentBarViewModel(
      {@required
          this.fBallReply,
      @required
          this.context,
      @required
          FireBaseAuthAdapterForUseCase fireBaseAuthAdapterForUseCase,
      @required
          SignInUserInfoUseCaseInputPort signInUserInfoUseCaseInputPort,
      @required
          FBallReplyPopupUseCaseInputPort fBallReplyPopupUseCaseInputPort})
      : _fireBaseAuthAdapterForUseCase = fireBaseAuthAdapterForUseCase,
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
