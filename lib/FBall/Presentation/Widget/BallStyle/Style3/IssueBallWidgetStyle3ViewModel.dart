import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:forutonafront/FBall/Domain/UseCase/BallDisPlayUseCase/BallDisPlayUseCase.dart';
import 'package:forutonafront/FBall/Domain/UseCase/BallDisPlayUseCase/IssueBallDisPlayUseCase.dart';
import 'package:forutonafront/FBall/Domain/Value/IssueBallDescription.dart';

import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/FBall/Presentation/Widget/BallStyle/BasicStyle/IssueBallBasicStyle.dart';

class IssueBallWidgetStyle3ViewModel extends ChangeNotifier {
  FBallResDto issueBall;
  IssueBallBasicStyle _issueBallBasicStyle;
  IssueBallDescription _issueBallDescription;
  IssueBallDisPlayUseCase _ballDisPlayUseCaseInputPort;

  IssueBallWidgetStyle3ViewModel(
      {@required FBallResDto fBallResDto,
      @required IssueBallBasicStyle issueBallBasicStyle})
      : _issueBallBasicStyle = issueBallBasicStyle {
    _issueBallDescription = IssueBallDescription.fromJson(json.decode(issueBall.description));
    _ballDisPlayUseCaseInputPort = IssueBallDisPlayUseCase(issueBall);
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
