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

class IssueBallTypeRepositoryImpl implements IssueBallTypeRepository {
  final IssueBallTypeRemoteDateSource _issueBallTypeRemoteDateSource;
  final FireBaseAuthAdapterForUseCase _fireBaseAuthBaseAdapter;

  IssueBallTypeRepositoryImpl(
      {@required IssueBallTypeRemoteDateSource issueBallTypeRemoteDateSource,
      @required FireBaseAuthAdapterForUseCase fireBaseAuthBaseAdapter})
      : _issueBallTypeRemoteDateSource = issueBallTypeRemoteDateSource,
        _fireBaseAuthBaseAdapter = fireBaseAuthBaseAdapter;

  @override
  Future<int> ballHit(FBallReqDto reqDto) async {
    return await _issueBallTypeRemoteDateSource.ballHit(
        reqDto: reqDto, noneTokenFDio: FDio.noneToken());
  }

  @override
  Future<int> deleteBall(FBallReqDto reqDto) async {
    return _issueBallTypeRemoteDateSource.deleteBall(
        reqDto: reqDto,
        fDio: FDio.token(
            idToken: await _fireBaseAuthBaseAdapter.getFireBaseIdToken()));
  }

  @override
  Future<FBall> insertBall(IssueBallInsertReqDto reqDto) async {
    return _issueBallTypeRemoteDateSource.insertBall(
        reqDto: reqDto,
        fDio: FDio.token(
            idToken: await _fireBaseAuthBaseAdapter.getFireBaseIdToken()));
  }

  @override
  Future<int> joinBall(FBallJoinReqDto reqDto) async {
    return _issueBallTypeRemoteDateSource.joinBall(
        reqDto: reqDto,
        fDio: FDio.token(
            idToken: await _fireBaseAuthBaseAdapter.getFireBaseIdToken()));
  }

  @override
  Future<FBall> selectBall(FBallReqDto fBallReqDto) async {
    return await _issueBallTypeRemoteDateSource.selectBall(
        reqDto: fBallReqDto, noneTokenFDio: FDio.noneToken());
  }

  @override
  Future<int> updateBall(IssueBallUpdateReqDto reqDto) async {
    return await _issueBallTypeRemoteDateSource.updateBall(
        reqDto: reqDto,
        fDio: FDio.token(
            idToken: await _fireBaseAuthBaseAdapter.getFireBaseIdToken()));
  }

  @override
  Future<FBallImageUpload> ballImageUpload(
      {@required List<Uint8List> images}) async {
    var fBallImageUpload = await _issueBallTypeRemoteDateSource.ballImageUpload(
        images: images,
        tokenFDio: FDio.token(
            idToken: await _fireBaseAuthBaseAdapter.getFireBaseIdToken()));
    return fBallImageUpload;
  }
}
