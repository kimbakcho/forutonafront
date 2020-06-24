import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:forutonafront/Common/FDio.dart';
import 'package:forutonafront/FBall/Data/DataStore/IssueBallTypeRemoteDateSource.dart';
import 'package:forutonafront/FBall/Data/Entity/FBall.dart';
import 'package:forutonafront/FBall/Data/Value/FBallImageUpload.dart';
import 'package:forutonafront/FBall/Domain/Repository/IssueBallTypeRepository.dart';
import 'package:forutonafront/FBall/Dto/FBallJoinReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallReqDto.dart';
import 'package:forutonafront/FBall/Dto/IssueBallInsertReqDto.dart';
import 'package:forutonafront/FBall/Dto/IssueBallUpdateReqDto.dart';
import 'package:forutonafront/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthAdapterForUseCase.dart';
import 'package:forutonafront/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthBaseAdapter.dart';

class IssueBallTypeRepositoryImpl implements IssueBallTypeRepository {
  final IssueBallTypeRemoteDateSourceImpl issueBallTypeRemoteDateSource;
  final FireBaseAuthBaseAdapter fireBaseAuthBaseAdapter;

  IssueBallTypeRepositoryImpl(
      {@required this.issueBallTypeRemoteDateSource,
      @required this.fireBaseAuthBaseAdapter})
      : assert(issueBallTypeRemoteDateSource != null),
        assert(fireBaseAuthBaseAdapter != null);

  @override
  Future<int> ballHit(FBallReqDto reqDto) async {
    return await issueBallTypeRemoteDateSource.ballHit(
        reqDto: reqDto, noneTokenFDio: FDio.noneToken());
  }

  @override
  Future<int> deleteBall(FBallReqDto reqDto) async {
    return issueBallTypeRemoteDateSource.deleteBall(
        reqDto: reqDto,
        fDio:
            FDio.token(idToken: await fireBaseAuthBaseAdapter.getFireBaseIdToken()));
  }

  @override
  Future<FBall> insertBall(IssueBallInsertReqDto reqDto) async {
    return issueBallTypeRemoteDateSource.insertBall(
        reqDto: reqDto,
        fDio:
            FDio.token(idToken: await fireBaseAuthBaseAdapter.getFireBaseIdToken()));
  }

  @override
  Future<int> joinBall(FBallJoinReqDto reqDto) async {
    return issueBallTypeRemoteDateSource.joinBall(
        reqDto: reqDto,
        fDio:
            FDio.token(idToken: await fireBaseAuthBaseAdapter.getFireBaseIdToken()));
  }

  @override
  Future<FBall> selectBall(FBallReqDto fBallReqDto) async {
    return await issueBallTypeRemoteDateSource.selectBall(
        reqDto: fBallReqDto, noneTokenFDio: FDio.noneToken());
  }

  @override
  Future<int> updateBall(IssueBallUpdateReqDto reqDto) async {
    return await issueBallTypeRemoteDateSource.updateBall(
        reqDto: reqDto,
        fDio:
            FDio.token(idToken: await fireBaseAuthBaseAdapter.getFireBaseIdToken()));
  }

  @override
  Future<FBallImageUpload> ballImageUpload(
      {@required List<Uint8List> images}) async {
    var fBallImageUpload = await issueBallTypeRemoteDateSource.ballImageUpload(
        images: images,
        tokenFDio:
            FDio.token(idToken: await fireBaseAuthBaseAdapter.getFireBaseIdToken()));
    return fBallImageUpload;
  }
}
