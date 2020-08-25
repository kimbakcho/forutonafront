import 'package:flutter/cupertino.dart';
import 'package:forutonafront/Common/FDio.dart';
import 'package:forutonafront/FBallValuation/Data/DataStore/FBallValuationRemoteDataSource.dart';
import 'package:forutonafront/FBallValuation/Domain/Repositroy/FBallValuationRepository.dart';
import 'package:forutonafront/FBallValuation/Dto/FBallLikeReqDto.dart';
import 'package:forutonafront/FBallValuation/Dto/FBallLikeResDto.dart';
import 'package:forutonafront/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthAdapterForUseCase.dart';

class FBallValuationRepositoryImpl implements FBallValuationRepository {
  final FireBaseAuthAdapterForUseCase _fireBaseAuthBaseAdapter;
  final FBallValuationRemoteDataSource _fBallValuationRemoteDataSource;

  FBallValuationRepositoryImpl(
      {@required FireBaseAuthAdapterForUseCase fireBaseAuthBaseAdapter,
      @required FBallValuationRemoteDataSource fBallValuationRemoteDataSource})
      : _fireBaseAuthBaseAdapter = fireBaseAuthBaseAdapter,
        _fBallValuationRemoteDataSource = fBallValuationRemoteDataSource;

  @override
  Future<FBallLikeResDto> ballLike(FBallLikeReqDto reqDto) async {
    return _fBallValuationRemoteDataSource.ballLike(
        reqDto: reqDto,
        tokenFDio: FDio.token(
            idToken: await _fireBaseAuthBaseAdapter.getFireBaseIdToken()));
  }

  @override
  Future<FBallLikeResDto> getBallLikeState(String ballUuid, String uid) async {
    return _fBallValuationRemoteDataSource.getBallLikeState(
        ballUuid: ballUuid, uid: uid, noneTokenFDio: FDio.noneToken());
  }
}
