import 'package:flutter/material.dart';
import 'package:forutonafront/Common/FDio.dart';
import 'package:forutonafront/FBall/Data/Entity/FBallValuation.dart';
import 'package:forutonafront/FBall/Data/Entity/FBallValuationWrap.dart';
import 'package:forutonafront/FBall/Dto/FBallValuation/FBallValuationInsertReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallValuation/FBallValuationReqDto.dart';

abstract class FBallValuationRepository {
  Future<void> deleteFBallValuation({@required String valueUuid});
  Future<FBallValuationWrap> getFBallValuation({@required FBallValuationReqDto reqDto});
  Future<FBallValuation> save({@required FBallValuationInsertReqDto reqDto});
}