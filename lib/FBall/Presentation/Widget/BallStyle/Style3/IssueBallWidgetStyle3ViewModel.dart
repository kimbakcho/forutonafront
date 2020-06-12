import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/FBall/Data/Entity/IssueBall.dart';
import 'package:forutonafront/FBall/Domain/UseCase/IssueBall/IssueBallUseCaseOutputPort.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/FBall/Presentation/Widget/BallStyle/BasicStyle/IssueBallBasicStyleMixin.dart';


class IssueBallWidgetStyle3ViewModel extends ChangeNotifier
    with IssueBallBasicStyleMixin
    implements IssueBallUseCaseOutputPort {

  IssueBall issueBall;

  IssueBallWidgetStyle3ViewModel({@required BuildContext context,@required FBallResDto fBallResDto}){
    issueBall = IssueBall.fromFBallResDto(fBallResDto);
  }

  @override
  void onBallHit() {
    issueBall.ballHit();
    notifyListeners();
  }

  @override
  void onDeleteBall() {
    issueBall.ballDeleteFlag = true;
    notifyListeners();
  }

  @override
  void onSelectBall(FBallResDto fBallResDto) {
    issueBall = IssueBall.fromFBallResDto(fBallResDto);
    notifyListeners();
  }

  @override
  void onInsertBall(FBallResDto resDto) {
    throw("here don't have action");
  }

  @override
  void onUpdateBall() {
    throw("here don't have action");
  }

  @override
  onBallDistanceDisplayText({String displayDistanceText}) {
    throw UnimplementedError();
  }
}
