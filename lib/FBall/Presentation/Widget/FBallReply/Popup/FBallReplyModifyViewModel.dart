import 'package:flutter/cupertino.dart';
import 'package:forutonafront/FBall/Data/Entity/FBallReply.dart';
import 'package:forutonafront/FBall/Presentation/Widget/FBallReply/Mediator/FBallReplyMediator.dart';
import 'package:forutonafront/FBall/Presentation/Widget/FBallReply/Popup/FBallReplyPopupUseCaseInputPort.dart';


class FBallReplyModifyViewModel extends ChangeNotifier {
  final FBallReply fBallReply;

  final FBallReplyMediator fBallReplyMediator;

  final FBallReplyPopupUseCaseInputPort _fBallReplyPopupUseCaseInputPort;

  final BuildContext context;

  FBallReplyModifyViewModel(
      {@required this.fBallReply, @required this.fBallReplyMediator,@required this.context,
      @required FBallReplyPopupUseCaseInputPort fBallReplyPopupUseCaseInputPort
      }):_fBallReplyPopupUseCaseInputPort = fBallReplyPopupUseCaseInputPort;

  void replyUpdatePopup() async {
    await _fBallReplyPopupUseCaseInputPort.popupUpdateDisplay(context,fBallReply);
  }


  void deleteAction() async {
    await _fBallReplyPopupUseCaseInputPort.deletePopupDisplay(context,fBallReply);
  }


}
