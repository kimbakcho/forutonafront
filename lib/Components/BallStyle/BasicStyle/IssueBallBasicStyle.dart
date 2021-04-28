import 'package:flutter/material.dart';
import 'package:forutonafront/AppBis/FBall/Domain/UseCase/HitBall/HitBallUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/AppBis/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthAdapterForUseCase.dart';
import 'package:forutonafront/Page/ICodePage/ID001/ID001MainPage2.dart';

abstract class IssueBallBasicStyle {
  Future<void> goIssueDetailPage(FBallResDto issueBall);

  Future reqJoinBall({required FBallResDto issueBall});

  Future<int> reqBallHit(String balluuid);
}

class IssueBallBasicStyleImpl implements IssueBallBasicStyle {
  final BuildContext context;

  final FireBaseAuthAdapterForUseCase? _fireBaseAuthAdapterForUseCase;

  final HitBallUseCaseInputPort? _hitBallUseCaseInputPort;

  IssueBallBasicStyleImpl(
      {required this.context,
        HitBallUseCaseInputPort? hitBallUseCaseInputPort,
      FireBaseAuthAdapterForUseCase? fireBaseAuthAdapterForUseCase})
      : _fireBaseAuthAdapterForUseCase = fireBaseAuthAdapterForUseCase,
        _hitBallUseCaseInputPort = hitBallUseCaseInputPort;

  Future<void> goIssueDetailPage(FBallResDto fballResDto) async {
    reqBallHit(fballResDto.ballUuid!);
    if (await _fireBaseAuthAdapterForUseCase!.isLogin()) {
      reqJoinBall(issueBall: fballResDto);
    }
    await Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => ID001MainPage2(ballUuid: fballResDto.ballUuid!)));
  }

  Future reqJoinBall({required FBallResDto issueBall}) async {
//    if (issueBall.isUserBall(myUid: await _fireBaseAuthAdapterForUseCase.userUid())) {

//      _issueBallUseCaseInputPort.joinBall(
//          reqDto: FBallJoinReqDto(issueBall.ballType, issueBall.ballUuid,
//              await _authUserCaseInputPort.myUid()));
    }

  @override
  Future<int> reqBallHit(String ballUuid) async {
     return await this._hitBallUseCaseInputPort!.hit(ballUuid);
  }

}
