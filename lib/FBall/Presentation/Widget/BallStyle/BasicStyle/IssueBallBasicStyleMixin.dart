import 'package:flutter/material.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilUseCase.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilUseCaseInputPort.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilUseCaseOutputPort.dart';
import 'package:forutonafront/FBall/Data/Entity/IssueBall.dart';
import 'package:forutonafront/FBall/Domain/UseCase/IssueBall/IssueBallUseCase.dart';
import 'package:forutonafront/FBall/Domain/UseCase/IssueBall/IssueBallUseCaseInputPort.dart';
import 'package:forutonafront/FBall/Domain/UseCase/IssueBall/IssueBallUseCaseOutputPort.dart';
import 'package:forutonafront/FBall/Dto/FBallJoinReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallReqDto.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/Auth/AuthUserCaseInputPort.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/Auth/FireBaseAuthUseCase.dart';
import 'package:forutonafront/ICodePage/ID001/ID001MainPage.dart';
import 'package:forutonafront/ServiceLocator.dart';

mixin  IssueBallBasicStyleMixin  {
  BuildContext context;

  IssueBallUseCaseInputPort _issueBallUseCaseInputPort = new IssueBallUseCase();

  GeoLocationUtilUseCaseInputPort geoLocationUtilUseCaseInputPort = sl();

  AuthUserCaseInputPort _authUserCaseInputPort = sl();


  void goIssueDetailPage({@required IssueBall issueBall,@required IssueBallUseCaseOutputPort outputPort}) async {
    reqBallHit(issueBall: issueBall,outputPort: outputPort);
    if (await _authUserCaseInputPort.isLogin()){
        reqJoinBall(issueBall: issueBall);
    }
    await Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => ID001MainPage(issueBall: issueBall)));
    _issueBallUseCaseInputPort.selectBall(ballUuid: issueBall.ballUuid,outputPort: outputPort);

  }

  Future reqJoinBall({@required IssueBall issueBall}) async {
    if(issueBall.isUserBall(myUid: await _authUserCaseInputPort.myUid())){
      _issueBallUseCaseInputPort.joinBall(
          reqDto: FBallJoinReqDto(
              issueBall.ballType, issueBall.ballUuid, await _authUserCaseInputPort.myUid()));
    }
  }

  Future reqBallHit({@required IssueBall issueBall,@required IssueBallUseCaseOutputPort outputPort}) async {
    if (await _authUserCaseInputPort.isLogin()) {
      _issueBallUseCaseInputPort.ballHit(
          reqDto: FBallReqDto(issueBall.ballType, issueBall.ballUuid),
          outputPort: outputPort);
    }
  }
}