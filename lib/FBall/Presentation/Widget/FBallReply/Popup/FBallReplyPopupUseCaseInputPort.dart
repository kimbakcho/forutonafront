import 'package:flutter/material.dart';
import 'package:forutonafront/FBall/Data/Entity/FBallReply.dart';
import 'package:forutonafront/FBall/Presentation/Widget/FBallReply/Mediator/FBallReplyMediator.dart';
import 'package:forutonafront/FBall/Presentation/Widget/FBallReply/Popup/FBallDetailReplyView.dart';
import 'package:forutonafront/FBall/Presentation/Widget/FBallReply/Popup/FBallDetailSubReplyActionView.dart';
import 'package:forutonafront/FBall/Presentation/Widget/FBallReply/Popup/FBallReplyDeletePopupView.dart';
import 'package:forutonafront/FBall/Presentation/Widget/FBallReply/Popup/FBallReplyModifyView.dart';
import 'package:forutonafront/FBall/Presentation/Widget/FBallReply/Popup/FBallReplyRootActionCommand.dart';
import 'package:forutonafront/FBall/Presentation/Widget/FBallReply/Popup/FBallReplyRootActionView.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/Auth/AuthUserCaseInputPort.dart';
import 'package:forutonafront/JCodePage/J001/J001View.dart';


abstract class FBallReplyPopupUseCaseInputPort {
  Future<void> popupInsertDisplay(BuildContext context, String ballUuid);

  Future<void> popUpDetailReply(BuildContext context, String ballUuid);

  Future<void> popupUpdateDisplay(BuildContext context, FBallReply fBallReply);

  Future<void> modifyPopup(BuildContext context, FBallReply fBallReply);

  Future<void> deletePopupDisplay(BuildContext context, FBallReply fBallReply);

  Future<void> popupSubReplyInputDialog(
      BuildContext context, FBallReply fBallReply);
}

class FBallReplyPopupUseCase implements FBallReplyPopupUseCaseInputPort {
  AuthUserCaseInputPort _authUserCaseInputPort;
  FBallReplyMediator _replyMediator;

  FBallReplyPopupUseCase(
      {@required AuthUserCaseInputPort authUserCaseInputPort,
      @required FBallReplyMediator replyMediator})
      : _authUserCaseInputPort = authUserCaseInputPort,
        _replyMediator = replyMediator;

  @override
  Future<void> popupInsertDisplay(BuildContext context, String ballUuid) async {
    if (await _authUserCaseInputPort.isLogin()) {
      await showGeneralDialog(
          context: context,
          barrierDismissible: true,
          transitionDuration: Duration(milliseconds: 300),
          barrierColor: Colors.black.withOpacity(0.3),
          barrierLabel:
              MaterialLocalizations.of(context).modalBarrierDismissLabel,
          pageBuilder:
              (_context, Animation animation, Animation secondaryAnimation) {
            return FBallReplyRootActionView(FBallReplyRootActionInsert(ballUuid,_replyMediator));
          });
    } else {
      await Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => J001View(), settings: RouteSettings(name: "/J001")));
    }
  }

  @override
  Future<void> popupUpdateDisplay(
      BuildContext context, FBallReply fBallReply) async {
    if (await _authUserCaseInputPort.isLogin()) {
      await showGeneralDialog(
          context: context,
          barrierDismissible: true,
          transitionDuration: Duration(milliseconds: 300),
          barrierColor: Colors.black.withOpacity(0.3),
          barrierLabel:
              MaterialLocalizations.of(context).modalBarrierDismissLabel,
          pageBuilder:
              (_context, Animation animation, Animation secondaryAnimation) {
            return FBallReplyRootActionView(
                FBallReplyActionUpdate(fBallReply, _replyMediator));
          });
      Navigator.of(context).pop();
    } else {
      await Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => J001View(), settings: RouteSettings(name: "/J001")));
    }
  }

  @override
  Future<void> popUpDetailReply(BuildContext context, String ballUuid) async {
    await showGeneralDialog(
        context: context,
        barrierDismissible: true,
        transitionDuration: Duration(milliseconds: 300),
        barrierColor: Colors.black.withOpacity(0.3),
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        pageBuilder:
            (_context, Animation animation, Animation secondaryAnimation) {
          return FBallDetailReplyView(ballUuid, _replyMediator);
        });
  }

  Future<void> modifyPopup(BuildContext context, FBallReply fBallReply) async {
    await showGeneralDialog(
        context: context,
        barrierDismissible: true,
        transitionDuration: Duration(milliseconds: 300),
        barrierColor: Colors.black.withOpacity(0.3),
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        pageBuilder:
            (_context, Animation animation, Animation secondaryAnimation) {
          return FBallReplyModifyView(fBallReply, _replyMediator, this);
        });
  }

  @override
  Future<void> deletePopupDisplay(
      BuildContext context, FBallReply fBallReply) async {
    await showGeneralDialog(
        context: context,
        barrierDismissible: true,
        transitionDuration: Duration(milliseconds: 300),
        barrierColor: Colors.black.withOpacity(0.3),
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        pageBuilder:
            (_context, Animation animation, Animation secondaryAnimation) {
          return FBallReplyDeletePopupView(fBallReply, _replyMediator);
        });
    Navigator.of(context).pop();
  }

  @override
  Future<void> popupSubReplyInputDialog(
      BuildContext context, FBallReply fBallReply) async {
    return await showGeneralDialog(
        context: context,
        barrierDismissible: true,
        transitionDuration: Duration(milliseconds: 300),
        barrierColor: Colors.black.withOpacity(0.3),
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        pageBuilder:
            (_context, Animation animation, Animation secondaryAnimation) {
          return FBallDetailSubReplyActionView(fBallReply,
              FBallReplySubActionInsert(fBallReply, _replyMediator));
        });
  }
}
