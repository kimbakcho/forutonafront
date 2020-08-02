import 'package:flutter/material.dart';
import 'package:forutonafront/FBall/Domain/Entity/IssueBall.dart';

import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/FBall/Presentation/Widget/BallStyle/BasicStyle/IssueBallBasicStyle.dart';

class IssueBallWidgetStyle3ViewModel extends ChangeNotifier {
  IssueBall issueBall;
  IssueBallBasicStyle _issueBallBasicStyle;

  IssueBallWidgetStyle3ViewModel(
      {@required FBallResDto fBallResDto,
      @required IssueBallBasicStyle issueBallBasicStyle})
      : _issueBallBasicStyle = issueBallBasicStyle {
    issueBall = IssueBall.fromFBallResDto(fBallResDto);
  }

  void goIssueDetailPage() async{
    await _issueBallBasicStyle.goIssueDetailPage(issueBall);
    notifyListeners();
  }

}
