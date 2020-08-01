import 'package:flutter/cupertino.dart';
import 'package:forutonafront/Common/FDio.dart';
import 'package:forutonafront/FBall/Data/DataStore/FBallValuationRemoteDataSource.dart';
import 'package:forutonafront/FBall/Domain/Repository/FBallValuationRepository.dart';
import 'package:forutonafront/FBall/Dto/FBallValuation/FBallValuationInsertReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallValuation/FBallValuationReqDto.dart';
import 'package:forutonafront/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthBaseAdapter.dart';

class FBallValuationRepositoryImpl implements FBallValuationRepository {

  final FBallValuationRemoteDataSource _fBallValuationRemoteDataSource;

  final FireBaseAuthBaseAdapter _fireBaseAuthBaseAdapter;

  FBallValuationRepositoryImpl(
      {@required FBallValuationRemoteDataSource fBallValuationRemoteDataSource,
        @required FireBaseAuthBaseAdapter fireBaseAuthBaseAdapter})
      : _fireBaseAuthBaseAdapter = fireBaseAuthBaseAdapter,
        _fBallValuationRemoteDataSource = fBallValuationRemoteDataSource;

  @override
  Future<void> deleteFBallValuation({@required String valueUuid}) async {
    await _fBallValuationRemoteDataSource.deleteFBallValuation(
        valueUuid: valueUuid,
        tokenFDio:
        FDio.token(
            idToken: await _fireBaseAuthBaseAdapter.getFireBaseIdToken()));
    return;
  }

  @override
  Future<FBallValuationWrap> getFBallValuation(
      {@required FBallValuationReqDto reqDto}) async {
    return await _fBallValuationRemoteDataSource.getFBallValuation(
        reqDto: reqDto, noneTokenFDio: FDio.noneToken());
  }

  @override
  Future<FBallValuation> save(
      {@required FBallValuationInsertReqDto reqDto}) async {
    return await _fBallValuationRemoteDataSource.save(
        reqDto: reqDto,
        tokenFDio:
        FDio(await _fireBaseAuthBaseAdapter.getFireBaseIdToken()));
  }
}
