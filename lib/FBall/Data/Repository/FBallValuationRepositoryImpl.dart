import 'package:flutter/cupertino.dart';
import 'package:forutonafront/Common/FDio.dart';
import 'package:forutonafront/FBall/Data/DataStore/FBallValuationRemoteDataSource.dart';
import 'package:forutonafront/FBall/Data/Entity/FBallValuation.dart';
import 'package:forutonafront/FBall/Data/Entity/FBallValuationWrap.dart';
import 'package:forutonafront/FBall/Domain/Repository/FBallValuationRepository.dart';
import 'package:forutonafront/FBall/Dto/FBallValuation/FBallValuationInsertReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallValuation/FBallValuationReqDto.dart';

class FBallValuationRepositoryImpl implements FBallValuationRepository {

  final FBallValuationRemoteDataSource fBallValuationRemoteDataSource;

  FBallValuationRepositoryImpl({this.fBallValuationRemoteDataSource});

  @override
  Future<void> deleteFBallValuation({@required String valueUuid}) async {
    await fBallValuationRemoteDataSource.deleteFBallValuation(
        valueUuid: valueUuid, tokenFDio: await FDio.makeAuthTokenFDio());
    return;
  }

  @override
  Future<FBallValuationWrap> getFBallValuation({@required FBallValuationReqDto reqDto}) async {
    return await fBallValuationRemoteDataSource.getFBallValuation(reqDto: reqDto, noneTokenFDio: FDio.noneToken());
  }

  @override
  Future<FBallValuation> save({@required FBallValuationInsertReqDto reqDto}) async {
    return await fBallValuationRemoteDataSource.save(reqDto: reqDto, tokenFDio: await FDio.makeAuthTokenFDio());
  }
}