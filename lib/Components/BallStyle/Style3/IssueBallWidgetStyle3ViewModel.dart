

import 'package:flutter/material.dart';
import 'package:forutonafront/Components/BallStyle/BasicStyle/IssueBallBasicStyle.dart';

import 'package:forutonafront/AppBis/FBall/Domain/UseCase/BallDisPlayUseCase/IssueBallDisPlayUseCase.dart';


import 'package:forutonafront/AppBis/FBall/Dto/FBallResDto.dart';


class IssueBallWidgetStyle3ViewModel extends ChangeNotifier {
  FBallResDto issueBall;
  IssueBallBasicStyle _issueBallBasicStyle;

  IssueBallDisPlayUseCase _ballDisPlayUseCaseInputPort;

  IssueBallWidgetStyle3ViewModel(
      {@required FBallResDto fBallResDto,
      @required IssueBallBasicStyle issueBallBasicStyle})
      : _issueBallBasicStyle = issueBallBasicStyle {
    _ballDisPlayUseCaseInputPort = IssueBallDisPlayUseCase(fBallResDto: issueBall);
  }

  void goIssueDetailPage() async{
    await _issueBallBasicStyle.goIssueDetailPage(issueBall);
    notifyListeners();
  }

  isMainPicture() {
    return _ballDisPlayUseCaseInputPort.isMainPicture();
  }

  String getDisplayLikeCount() {
    return _ballDisPlayUseCaseInputPort.ballLikes();
  }

  String getDisplayDisLikeCount() {
    return _ballDisPlayUseCaseInputPort.ballDisLikes();
  }

  String getDisplayCommentCount() {
    return _ballDisPlayUseCaseInputPort.commentCount();
  }

  String getDisplayRemainingTime() {
    return _ballDisPlayUseCaseInputPort.remainTime();
  }

  String mainPictureSrc() {
    return _ballDisPlayUseCaseInputPort.mainPictureSrc();
  }

}
