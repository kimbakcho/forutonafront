import 'package:flutter/material.dart';
import 'package:forutonafront/FBall/Data/Entity/IssueBall.dart';
import 'package:forutonafront/FBall/Domain/UseCase/FBall/FBallUseCaseInputPort.dart';
import 'package:forutonafront/FBall/Dto/FBallJoinReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallReqDto.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/Auth/AuthUserCaseInputPort.dart';
import 'package:forutonafront/ICodePage/ID001/ID001MainPage.dart';

abstract class IssueBallBasicStyle {
  Future<void> goIssueDetailPage(IssueBall issueBall);

  Future reqJoinBall({@required IssueBall issueBall});

  Future reqBallHit(IssueBall issueBall);
}

class IssueBallBasicStyleImpl implements IssueBallBasicStyle {
  final BuildContext context;

  final FBallUseCaseInputPort _issueBallUseCaseInputPort;

  final AuthUserCaseInputPort _authUserCaseInputPort;

  IssueBallBasicStyleImpl(
      {@required this.context,
      @required FBallUseCaseInputPort issueBallUseCaseInputPort,
      @required AuthUserCaseInputPort authUserCaseInputPort})
      : _issueBallUseCaseInputPort = issueBallUseCaseInputPort,
        _authUserCaseInputPort = authUserCaseInputPort;

  Future<void> goIssueDetailPage(IssueBall issueBall) async {
    reqBallHit(issueBall);
    if (await _authUserCaseInputPort.isLogin()) {
      reqJoinBall(issueBall: issueBall);
    }
    await Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => ID001MainPage(issueBall: issueBall)));

  }

  Future reqJoinBall({@required IssueBall issueBall}) async {
    if (issueBall.isUserBall(myUid: await _authUserCaseInputPort.myUid())) {
      //TODO FBallPlayer 구현후 다시 구현
//      _issueBallUseCaseInputPort.joinBall(
//          reqDto: FBallJoinReqDto(issueBall.ballType, issueBall.ballUuid,
//              await _authUserCaseInputPort.myUid()));
    }
  }

  Future reqBallHit(IssueBall issueBall) async {
    if (await _authUserCaseInputPort.isLogin()) {
      var result = await _issueBallUseCaseInputPort.ballHit(
          reqDto: FBallReqDto(issueBall.ballType, issueBall.ballUuid));
      if(result==1) {
        issueBall.ballHit();
      }
    }
  }
}
