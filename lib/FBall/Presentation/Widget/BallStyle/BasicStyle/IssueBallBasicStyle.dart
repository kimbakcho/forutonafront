import 'package:flutter/material.dart';
import 'package:forutonafront/FBall/Domain/Entity/IssueBall.dart';
import 'package:forutonafront/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthAdapterForUseCase.dart';
import 'package:forutonafront/ICodePage/ID001/ID001MainPage2.dart';

abstract class IssueBallBasicStyle {
  Future<void> goIssueDetailPage(IssueBall issueBall);

  Future reqJoinBall({@required IssueBall issueBall});

  Future reqBallHit(IssueBall issueBall);
}

class IssueBallBasicStyleImpl implements IssueBallBasicStyle {
  final BuildContext context;

  final FireBaseAuthAdapterForUseCase _fireBaseAuthAdapterForUseCase;

  IssueBallBasicStyleImpl(
      {@required this.context,
      FireBaseAuthAdapterForUseCase fireBaseAuthAdapterForUseCase})
      : _fireBaseAuthAdapterForUseCase = fireBaseAuthAdapterForUseCase;

  Future<void> goIssueDetailPage(IssueBall issueBall) async {
    reqBallHit(issueBall);
    if (await _fireBaseAuthAdapterForUseCase.isLogin()) {
      reqJoinBall(issueBall: issueBall);
    }
    await Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => ID001MainPage2(ballUuid: issueBall.ballUuid)));
  }

  Future reqJoinBall({@required IssueBall issueBall}) async {
    if (issueBall.isUserBall(myUid: await _fireBaseAuthAdapterForUseCase.userUid())) {
      //TODO FBallPlayer 구현후 다시 구현
//      _issueBallUseCaseInputPort.joinBall(
//          reqDto: FBallJoinReqDto(issueBall.ballType, issueBall.ballUuid,
//              await _authUserCaseInputPort.myUid()));
    }
  }

  Future reqBallHit(IssueBall issueBall) async {
    if (await _fireBaseAuthAdapterForUseCase.isLogin()) {
      await issueBall.ballHit();
    }
  }
}
