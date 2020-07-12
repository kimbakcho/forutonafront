import 'package:flutter/material.dart';
import 'package:forutonafront/FBall/Data/Entity/FBallReply.dart';
import 'package:forutonafront/FBall/Domain/UseCase/FBallReply/FBallReplyUseCaseInputPort.dart';
import 'package:forutonafront/FBall/Domain/UseCase/FBallReply/FBallReplyUseCaseOutputPort.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyResDto.dart';
import 'package:forutonafront/FBall/Presentation/Widget/FBallReply/FBallReplyContentBar.dart';
import 'package:forutonafront/FBall/Presentation/Widget/FBallReply/FBallReplyWidgetViewController.dart';
import 'package:forutonafront/FBall/Repository/FBallReplyRepository.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/Auth/AuthUserCaseInputPort.dart';
import 'package:forutonafront/JCodePage/J001/J001View.dart';
import 'package:forutonafront/ServiceLocator.dart';

class FBallReplyWidgetViewModel extends ChangeNotifier
    implements FBallReplyUseCaseOutputPort {
  final String ballUuid;
  final FBallReplyUseCaseInputPort _fBallReplyUseCaseInputPort;
  final List<FBallReplyContentBar> fBallReplyContentBars = [];
  final BuildContext context;

  int totalReplyCount = 0;

  AuthUserCaseInputPort _authUserCaseInputPort;

  FBallReplyWidgetViewModel(
      {this.ballUuid,
      this.context,
      AuthUserCaseInputPort authUserCaseInputPort,
      FBallReplyUseCaseInputPort fBallReplyUseCaseInputPort})
      : _authUserCaseInputPort = authUserCaseInputPort,
        _fBallReplyUseCaseInputPort = fBallReplyUseCaseInputPort {
    loadTop3Reply();
  }

  void loadTop3Reply() async {
    FBallReplyReqDto reqDto = new FBallReplyReqDto();
    reqDto.ballUuid = ballUuid;
    reqDto.reqOnlySubReply = false;
    reqDto.size = 3;
    reqDto.page = 0;
    await _fBallReplyUseCaseInputPort.reqFBallReply(reqDto);
  }

  void gotoJ001Page() {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return J001View();
    }));
  }

  void popupInputDisplay() async {}

  @override
  onFBallReply(List<FBallReplyResDto> fBallResDto) {
    fBallReplyContentBars.clear();

    fBallReplyContentBars.addAll(fBallResDto
        .map((item) => FBallReplyContentBar(
              context: context,
              fBallReply: FBallReply.fromFBallReplyResDto(item),
              authUserCaseInputPort: sl(),
            ))
        .toList());

    notifyListeners();
  }

  @override
  onFBallReplyTotalCount(int totalCount) {
    totalReplyCount = totalCount;
    notifyListeners();
  }
}
