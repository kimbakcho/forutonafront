import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:forutonafront/FBall/Data/Value/FBallImageUpload.dart';
import 'package:forutonafront/FBall/Dto/FBallInsertReqDto/FBallInsertReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallJoinReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/FBall/Dto/FBallUpdateReqDto/FBallUpdateReqDto.dart';
import 'package:forutonafront/ICodePage/IM001/BallImageItem.dart';

import 'FBallUseCaseOutputPort.dart';

abstract class FBallUseCaseInputPort {


  Future<FBallResDto> selectBall(
      {@required String ballUuid, @required FBallUseCaseOutputPort outputPort});

  Future<int> deleteBall(
      {@required String ballUuid, @required FBallUseCaseOutputPort outputPort});


  Future<int> updateBall(
      {@required FBallUpdateReqDto reqDto, @required FBallUseCaseOutputPort outputPort});

  Future<List<BallImageItem>> ballImageListUpLoadAndFillUrls(List<BallImageItem> refSrcList);
}
