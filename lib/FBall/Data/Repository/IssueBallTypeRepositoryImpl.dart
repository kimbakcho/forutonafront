


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/Common/FDio.dart';
import 'package:forutonafront/FBall/Data/DataStore/IIssueBallTypeRemoteDateSource.dart';
import 'package:forutonafront/FBall/Data/Entity/FBall.dart';
import 'package:forutonafront/FBall/Domain/Repository/IssueBallTypeRepository.dart';
import 'package:forutonafront/FBall/Dto/FBallInsertReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallJoinReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';

class IssueBallTypeRepositoryImpl implements IssueBallTypeRepository{

  final IssueBallTypeRemoteDateSource issueBallTypeRemoteDateSource;

  IssueBallTypeRepositoryImpl({@required this.issueBallTypeRemoteDateSource});

  @override
  Future<int> ballHit(FBallReqDto reqDto) async {
    return await issueBallTypeRemoteDateSource.ballHit(reqDto: reqDto, noneTokenFDio: FDio.noneToken());
  }

  @override
  Future<int> deleteBall(FBallReqDto reqDto) async {
    return issueBallTypeRemoteDateSource.deleteBall(reqDto: reqDto, fDio: await FDio.makeAuthTokenFDio());
  }

  @override
  Future<int> insertBall(FBallInsertReqDto reqDto) async{
    return issueBallTypeRemoteDateSource.insertBall(reqDto: reqDto, fDio: await FDio.makeAuthTokenFDio());
  }

  @override
  Future<int> joinBall(FBallJoinReqDto reqDto) async {

    return issueBallTypeRemoteDateSource.joinBall(
          reqDto: reqDto, fDio: await FDio.makeAuthTokenFDio());

  }

  @override
  Future<FBall> selectBall(FBallReqDto fBallReqDto) async{
    return await issueBallTypeRemoteDateSource.selectBall(reqDto: fBallReqDto, fDio: await FDio.makeAuthTokenFDio());
  }

  @override
  Future<int> updateBall(FBallInsertReqDto reqDto) async {
    return await issueBallTypeRemoteDateSource.updateBall(reqDto: reqDto, fDio: await FDio.makeAuthTokenFDio());
  }



}