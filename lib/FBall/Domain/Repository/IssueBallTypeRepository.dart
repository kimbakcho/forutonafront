import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:forutonafront/FBall/Data/Entity/FBall.dart';
import 'package:forutonafront/FBall/Data/Value/FBallImageUpload.dart';
import 'package:forutonafront/FBall/Dto/IssueBallInsertReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallJoinReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallReqDto.dart';
import 'package:forutonafront/FBall/Dto/IssueBallUpdateReqDto.dart';

abstract class IssueBallTypeRepository {
  Future<int> deleteBall(FBallReqDto reqDto);
  Future<FBall> insertBall(IssueBallInsertReqDto reqDto);
  Future<FBall> selectBall(FBallReqDto fBallReqDto);
  Future<int> updateBall(IssueBallUpdateReqDto reqDto);
  Future<int> joinBall(FBallJoinReqDto reqDto);
  Future<int> ballHit(FBallReqDto reqDto);
  Future<FBallImageUpload> ballImageUpload({@required List<Uint8List> images});
}