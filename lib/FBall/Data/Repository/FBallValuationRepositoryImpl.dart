import 'package:flutter/cupertino.dart';
import 'package:forutonafront/Common/FDio.dart';

import 'package:forutonafront/FBall/Data/DataStore/FBallValuationRemoteDataSource.dart';
import 'package:forutonafront/FBall/Data/Entity/FBallValuation.dart';
import 'package:forutonafront/FBall/Data/Entity/FBallValuationWrap.dart';
import 'package:forutonafront/FBall/Domain/Repository/FBallValuationRepository.dart';
import 'package:forutonafront/FBall/Dto/FBallValuation/FBallValuationInsertReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallValuation/FBallValuationReqDto.dart';
import 'package:forutonafront/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthAdapterForUseCase.dart';
import 'package:forutonafront/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthBaseAdapter.dart';

class FBallValuationRepositoryImpl implements FBallValuationRepository {
  final FBallValuationRemoteDataSource fBallValuationRemoteDataSource;

  final FireBaseAuthBaseAdapter fireBaseAuthBaseAdapter;

  FBallValuationRepositoryImpl(
      {@required this.fBallValuationRemoteDataSource,
      @required this.fireBaseAuthBaseAdapter})
      : assert(fBallValuationRemoteDataSource != null),
        assert(fireBaseAuthBaseAdapter != null);

  @override
  Future<void> deleteFBallValuation({@required String valueUuid}) async {
    await fBallValuationRemoteDataSource.deleteFBallValuation(
        valueUuid: valueUuid,
        tokenFDio:
            FDio.token(idToken: await fireBaseAuthBaseAdapter.getFireBaseIdToken()));
    return;
  }

  @override
  Future<FBallValuationWrap> getFBallValuation(
      {@required FBallValuationReqDto reqDto}) async {
    return await fBallValuationRemoteDataSource.getFBallValuation(
        reqDto: reqDto, noneTokenFDio: FDio.noneToken());
  }

  @override
  Future<FBallValuation> save(
      {@required FBallValuationInsertReqDto reqDto}) async {
    return await fBallValuationRemoteDataSource.save(
        reqDto: reqDto,
        tokenFDio:
            FDio.token(idToken: await fireBaseAuthBaseAdapter.getFireBaseIdToken()));
  }
}
