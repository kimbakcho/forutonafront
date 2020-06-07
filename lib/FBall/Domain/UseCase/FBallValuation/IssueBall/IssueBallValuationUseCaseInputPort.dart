import 'package:flutter/material.dart';
import 'package:forutonafront/FBall/Dto/FBallValuation/FBallValuationInsertReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallValuation/FBallValuationReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallValuation/FBallValuationResDto.dart';

import 'IssueBallValuationUseCaseOutputPort.dart';

abstract class IssueBallValuationUseCaseInputPort {
  Future<void> deleteFBallValuation({@required String valueUuid,int deletePoint,IssueBallValuationUseCaseOutputPort outputPort});
  Future<FBallValuationResDto> getFBallValuation({@required FBallValuationReqDto reqDto});
  Future<FBallValuationResDto> save({@required FBallValuationInsertReqDto reqDto});
}