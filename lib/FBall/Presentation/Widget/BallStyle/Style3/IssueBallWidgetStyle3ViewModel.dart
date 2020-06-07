import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/FBall/Data/Entity/IssueBall.dart';
import 'package:forutonafront/FBall/Data/Value/FBallType.dart';
import 'package:forutonafront/FBall/Domain/UseCase/IssueBall/IssueBallUseCase.dart';
import 'package:forutonafront/FBall/Domain/UseCase/IssueBall/IssueBallUseCaseInputPort.dart';
import 'package:forutonafront/FBall/Domain/UseCase/IssueBall/IssueBallUseCaseOutputPort.dart';
import 'package:forutonafront/FBall/Dto/FBallJoinReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallReqDto.dart';

import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/ICodePage/ID001/ID001MainPage.dart';

class IssueBallWidgetStyle3ViewModel extends ChangeNotifier implements IssueBallUseCaseOutputPort {
  final BuildContext context;
  IssueBall issueBall;
  IssueBallUseCaseInputPort _issueBallUseCase = IssueBallUseCase();
  IssueBallWidgetStyle3ViewModel({@required this.context,@required FBallResDto fBallResDto}){
    issueBall = IssueBall.fromFBallResDto(fBallResDto);
  }

  void goIssueDetailPage() async{
    _issueBallUseCase.ballHit(reqDto: FBallReqDto(issueBall.ballType,issueBall.ballUuid), outputPort: this);
    var currentUser = await FirebaseAuth.instance.currentUser();
    if(currentUser != null){
      _issueBallUseCase.joinBall(reqDto: FBallJoinReqDto(issueBall.ballType,issueBall.ballUuid,currentUser.uid));
    }
    await Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => ID001MainPage(issueBall: issueBall)));
    _issueBallUseCase.selectBall(ballUuid: issueBall.ballUuid);
  }

  @override
  void onBallHit() {
    issueBall.ballHit();
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
  void onInsertBall() {
    throw("here don't have action");
  }

  @override
  void onUpdateBall() {
    throw("here don't have action");
  }
}
