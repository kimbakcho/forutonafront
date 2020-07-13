import 'package:flutter/material.dart';
import 'package:forutonafront/FBall/Data/Entity/FBallReply.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyReqDto.dart';
import 'package:forutonafront/FBall/Presentation/Widget/FBallReply/FBallSubReplyContentBar.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/Auth/AuthUserCaseInputPort.dart';

import 'FBallReplyMediator.dart';

class FBallReplyContentViewModel extends ChangeNotifier {
  final AuthUserCaseInputPort _authUserCaseInputPort;
  final FBallReplyMediator _fBallReplyMediator;
  final FBallReply fBallReply;

  bool isOpenSubReply = false;

  FBallReplyContentViewModel({
    @required this.fBallReply,
  @required AuthUserCaseInputPort authUserCaseInputPort,
    @required FBallReplyMediator fBallReplyMediator})
      : _fBallReplyMediator = fBallReplyMediator,
        _authUserCaseInputPort = authUserCaseInputPort;

  void toggleSubReplyOpenFlag() {
    isOpenSubReply = !isOpenSubReply;
    if (isOpenSubReply) {
      openSubRely();
    }
    notifyListeners();
  }

  void openSubRely() async {
    FBallReplyReqDto reqDto = FBallReplyReqDto();
    reqDto.reqOnlySubReply =true;
    reqDto.replyNumber = fBallReply.replyNumber;
    reqDto.ballUuid = fBallReply.ballUuid;
    reqDto.size = 1000;
    reqDto.page = 0;
    await _fBallReplyMediator.reqFBallReply(reqDto);
  }

  get subReplyContentBar{
    if (isSubReplyEmpty()) {
      return [Container()];
    } else {
      return fBallReply.fBallSubReplys
          .map((fBallReply) => FBallSubReplyContentBar(fBallReply))
          .toList();
    }
  }

  bool isSubReplyEmpty() => fBallReply.fBallSubReplys.length == 0;
}
