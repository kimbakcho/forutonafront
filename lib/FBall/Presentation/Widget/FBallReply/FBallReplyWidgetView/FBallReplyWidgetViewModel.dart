import 'package:flutter/material.dart';
import 'package:forutonafront/FBall/Domain/Entity/FBallReply.dart';

import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyReqDto.dart';
import 'package:forutonafront/FBall/Presentation/Widget/FBallReply/Mediator/FBallReplyMediator.dart';
import 'package:forutonafront/FBall/Presentation/Widget/FBallReply/Popup/FBallReplyPopupUseCaseInputPort.dart';
import 'package:forutonafront/FBall/Presentation/Widget/FBallReply/ReplyContentBar/FBallReplySimpleContentBar.dart';

import 'package:forutonafront/JCodePage/J001/J001View.dart';

class FBallReplyWidgetViewModel extends ChangeNotifier
    with FBallReplyColleague {
  final String ballUuid;
  final FBallReplyMediator fBallReplyMediator;
  final BuildContext context;
  final replyFirstPageMaxReply = 3;
  final FBallReplyPopupUseCaseInputPort _fBallReplyPopupUseCaseInputPort;

  FBallReplyWidgetViewModel(
      {this.ballUuid,
      this.context,
      this.fBallReplyMediator,
      FBallReplyPopupUseCaseInputPort fBallReplyPopupUseCaseInputPort})
      : _fBallReplyPopupUseCaseInputPort = fBallReplyPopupUseCaseInputPort {
    super.mediatorJoin(fBallReplyMediator);
    loadTop3Reply();
  }

  void loadTop3Reply() async {
    FBallReplyReqDto reqDto = new FBallReplyReqDto();
    reqDto.ballUuid = ballUuid;
    reqDto.reqOnlySubReply = false;
    reqDto.size = replyFirstPageMaxReply;
    reqDto.page = 0;
    fBallReplyMediator.reqFBallReply(reqDto);
  }

  get replySimpleWidget {
    List<FBallReply> topReplyList = [];
    if (isOverReplyLengthForMainReply()) {
      topReplyList =
          fBallReplyMediator.replyList.sublist(0, replyFirstPageMaxReply);
    } else {
      topReplyList = fBallReplyMediator.replyList;
    }
    if (isEmptyReply(topReplyList)) {
      return [Container()];
    } else {
      return topReplyList
          .map((e) => new FBallReplySimpleContentBar(e))
          .toList();
    }
  }

  bool isEmptyReply(List<FBallReply> topReplyList) => topReplyList.length == 0;

  bool isOverReplyLengthForMainReply() =>
      fBallReplyMediator.replyList.length > replyFirstPageMaxReply;

  void popUpDetailReply() async {
    _fBallReplyPopupUseCaseInputPort.popUpDetailReply(context, ballUuid);
  }

  @override
  void onUpdateFBallReply() {
    notifyListeners();
  }

  @override
  void dispose() {
    fBallReplyMediator.removeColleague(this);
    super.dispose();
  }

  void popupInputDisplay() async {
    await _fBallReplyPopupUseCaseInputPort.popupInsertDisplay(context, ballUuid);
  }
}
