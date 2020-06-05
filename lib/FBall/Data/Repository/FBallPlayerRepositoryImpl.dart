
import 'package:flutter/material.dart';
import 'package:forutonafront/Common/FDio.dart';
import 'package:forutonafront/FBall/Data/DataStore/FBallPlayerRemoteDataSource.dart';
import 'package:forutonafront/FBall/Data/Entity/UserToPlayBall.dart';
import 'package:forutonafront/FBall/Data/Entity/UserToPlayBallWrap.dart';
import 'package:forutonafront/FBall/Domain/Repository/FBallPlayerRepository.dart';
import 'package:forutonafront/FBall/Dto/UserBall/UserToPlayBallReqDto.dart';
import 'package:forutonafront/FBall/Dto/UserBall/UserToPlayBallSelectReqDto.dart';

class FBallPlayerRepositoryImpl implements FBallPlayerRepository{

  final FBallPlayerRemoteDataSource ifBallPlayerRemoteDataSource;

  FBallPlayerRepositoryImpl({@required this.ifBallPlayerRemoteDataSource});

  @override
  Future<UserToPlayBallWrap> getUserPlayBallList(UserToPlayBallReqDto reqDto) async{
    return await ifBallPlayerRemoteDataSource.getUserPlayBallList(reqDto: reqDto, noneTokenFDio: FDio.noneToken());
  }

  @override
  Future<UserToPlayBall> getUserPlayBall(UserToPlayBallSelectReqDto reqDto) async{
    return await ifBallPlayerRemoteDataSource.getUserPlayBall(reqDto: reqDto, noneTokenFDio: FDio.noneToken());
  }

}