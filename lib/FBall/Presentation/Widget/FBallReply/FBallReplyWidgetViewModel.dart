import 'package:flutter/material.dart';
import 'package:forutonafront/FBall/Data/Entity/FBallReply.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyInsertReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyReqDto.dart';
import 'package:forutonafront/FBall/Presentation/Widget/FBallReply/FBallDetailReplyView.dart';
import 'package:forutonafront/FBall/Presentation/Widget/FBallReply/FBallInputReplyView.dart';
import 'package:forutonafront/FBall/Presentation/Widget/FBallReply/FBallReplyMediator.dart';
import 'package:forutonafront/FBall/Presentation/Widget/FBallReply/FBallReplySimpleContentBar.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/Auth/AuthUserCaseInputPort.dart';
import 'package:forutonafront/JCodePage/J001/J001View.dart';

class FBallReplyWidgetViewModel extends ChangeNotifier with FBallReplyColleague{
  final String ballUuid;
  final FBallReplyMediator fBallReplyMediator;
  final BuildContext context;
  final replyFirstPageMaxReply = 3;

  AuthUserCaseInputPort _authUserCaseInputPort;
  FBallReplyWidgetViewModel(
      {this.ballUuid,
      this.context,
      this.fBallReplyMediator,
      AuthUserCaseInputPort authUserCaseInputPort})
      : _authUserCaseInputPort = authUserCaseInputPort {
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

  void gotoJ001Page() {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return J001View();
    }));
  }

  void popupInputDisplay() async {
    if (await _authUserCaseInputPort.isLogin()) {
      FBallReplyInsertReqDto fBallReplyInsertReqDto = FBallReplyInsertReqDto();
      fBallReplyInsertReqDto.ballUuid = ballUuid;
      setInsertMode(fBallReplyInsertReqDto);
      await showGeneralDialog(
          context: context,
          barrierDismissible: true,
          transitionDuration: Duration(milliseconds: 300),
          barrierColor: Colors.black.withOpacity(0.3),
          barrierLabel:
              MaterialLocalizations.of(context).modalBarrierDismissLabel,
          pageBuilder:
              (_context, Animation animation, Animation secondaryAnimation) {
            return FBallInputReplyView(fBallReplyInsertReqDto,fBallReplyMediator);
          });
    } else {
      await Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => J001View(), settings: RouteSettings(name: "/J001")));
    }
  }

  dynamic setInsertMode(FBallReplyInsertReqDto fBallReplyInsertReqDto) =>
      fBallReplyInsertReqDto.replyUuid = null;

  get replySimpleWidget {
    List<FBallReply> topReplyList = [];
    if (isOverReplyLengthForMainReply()) {
      topReplyList = fBallReplyMediator.replyList.sublist(0, replyFirstPageMaxReply);
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
    await showGeneralDialog(
        context: context,
        barrierDismissible: true,
        transitionDuration: Duration(milliseconds: 300),
    barrierColor: Colors.black.withOpacity(0.3),
    barrierLabel:
    MaterialLocalizations.of(context).modalBarrierDismissLabel,
    pageBuilder:
    (_context, Animation animation, Animation secondaryAnimation) {
    return FBallDetailReplyView(ballUuid, fBallReplyMediator);
    });
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
}
