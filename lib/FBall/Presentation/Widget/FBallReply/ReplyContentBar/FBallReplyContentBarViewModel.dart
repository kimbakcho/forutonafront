import 'package:flutter/material.dart';
import 'package:forutonafront/FBall/Data/Entity/FBallReply.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyReqDto.dart';
import 'package:forutonafront/FBall/Presentation/Widget/FBallReply/Mediator/FBallReplyMediator.dart';
import 'package:forutonafront/FBall/Presentation/Widget/FBallReply/Popup/FBallReplyPopupUseCaseInputPort.dart';
import 'package:forutonafront/FBall/Presentation/Widget/FBallReply/ReplyContentBar/FBallSubReplyContentBar.dart';

import 'package:forutonafront/ForutonaUser/Data/Entity/FUserInfo.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/Auth/AuthUserCaseInputPort.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/FUser/SigInInUserInfoUseCase/SignInUserInfoUseCaseInputPort.dart';
import 'package:forutonafront/JCodePage/J001/J001View.dart';


class FBallReplyContentBarViewModel extends ChangeNotifier {
  final AuthUserCaseInputPort _authUserCaseInputPort;
  final SignInUserInfoUseCaseInputPort _signInUserInfoUseCaseInputPort;
  final FBallReplyMediator _fBallReplyMediator;
  final FBallReplyPopupUseCaseInputPort _fBallReplyPopupUseCaseInputPort;
  final FBallReply fBallReply;
  final BuildContext context;
  bool isOpenSubReply = false;

  FBallReplyContentBarViewModel(
      {@required this.context,
      @required this.fBallReply,
      @required FBallReplyPopupUseCaseInputPort fBallReplyPopupUseCaseInputPort,
      @required SignInUserInfoUseCaseInputPort signInUserInfoUseCaseInputPort,
      @required AuthUserCaseInputPort authUserCaseInputPort,
      @required FBallReplyMediator fBallReplyMediator})
      : _fBallReplyMediator = fBallReplyMediator,
        _authUserCaseInputPort = authUserCaseInputPort,
        _signInUserInfoUseCaseInputPort = signInUserInfoUseCaseInputPort,
        _fBallReplyPopupUseCaseInputPort = fBallReplyPopupUseCaseInputPort;

  void toggleSubReplyOpenFlag() {
    isOpenSubReply = !isOpenSubReply;
    if (isOpenSubReply) {
      openSubRely();
    }
    notifyListeners();
  }

  void openSubRely() async {
    FBallReplyReqDto reqDto = FBallReplyReqDto();
    reqDto.reqOnlySubReply = true;
    reqDto.replyNumber = fBallReply.replyNumber;
    reqDto.ballUuid = fBallReply.ballUuid;
    reqDto.size = 1000;
    reqDto.page = 0;
    await _fBallReplyMediator.reqFBallReply(reqDto);
  }

  get subReplyContentBar {
    if (isSubReplyEmpty() || !isOpenSubReply) {
      return [Container()];
    } else {
      return fBallReply.fBallSubReplys
          .map((fBallReply) => FBallSubReplyContentBar(fBallReply,_fBallReplyPopupUseCaseInputPort))
          .toList();
    }
  }

  bool isSubReplyEmpty() => fBallReply.fBallSubReplys.length == 0;

  void insertSubReply() async {
    if (await _authUserCaseInputPort.isLogin()) {
      await showSubReplyInputDialog();
    }
  }

  bool isRootReply() => fBallReply.replySort == 0;

  Future<void> showSubReplyInputDialog() async {
    await _fBallReplyPopupUseCaseInputPort.popupSubReplyInputDialog(context, fBallReply);
  }

  void jumpToJ001() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => J001View(), settings: RouteSettings(name: "/J001")));
  }

  void popupOptionBtn() {
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