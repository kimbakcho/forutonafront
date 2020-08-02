import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/FBall/Domain/Entity/FBallReply.dart';
import 'package:forutonafront/FBall/Presentation/Widget/FBallReply/Mediator/FBallReplyMediator.dart';



class FBallReplyDeletePopupViewModel extends ChangeNotifier {
  final FBallReply fBallReply;
  final FBallReplyMediator fBallReplyMediator;
  final BuildContext context;

  FBallReplyDeletePopupViewModel({
    @required this.fBallReply,
    @required this.fBallReplyMediator,
    @required this.context
  });

  Future<void> replyDelete()async {
    await fBallReplyMediator.deleteFBallReply(fBallReply.replyUuid);
    Navigator.of(context).pop();
  }

}
