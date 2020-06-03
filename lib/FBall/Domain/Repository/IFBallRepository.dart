
import 'package:flutter/cupertino.dart';
import 'package:forutonafront/FBall/Data/Value/FBallListUpWrap.dart';
import 'package:forutonafront/FBall/Dto/FBallListUpReqDto.dart';

abstract class IFBallRepository {
  Future<FBallListUpWrap> listUpFromPosition({
    @required FBallListUpReqDto listUpReqDto});
}
