import 'dart:typed_data';

import 'package:forutonafront/Common/FDio.dart';
import 'package:forutonafront/Common/Page/Dto/PageWrap.dart';
import 'package:forutonafront/FBall/Data/DataStore/FBallRemoteDataSource.dart';
import 'package:forutonafront/FBall/Data/Entity/FBall.dart';
import 'package:forutonafront/FBall/Data/Entity/FBallListUpWrap.dart';
import 'package:forutonafront/FBall/Data/Entity/UserToMakeBallWrap.dart';
import 'package:forutonafront/FBall/Data/Value/FBallImageUpload.dart';
import 'package:forutonafront/FBall/Domain/Repository/FBallRepository.dart';
import 'package:forutonafront/FBall/Dto/BallFromMapAreaReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallInsertReqDto/FBallInsertReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallJoinReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallListUpFromBallInfluencePowerReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallListUpFromSearchTitleReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallListUpFromTagNameReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/FBall/Dto/FBallUpdateReqDto/FBallUpdateReqDto.dart';
import 'package:forutonafront/FBall/Dto/UserBall/UserToMakeBallReqDto.dart';
import 'package:forutonafront/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthAdapterForUseCase.dart';
import 'package:meta/meta.dart';

class FBallRepositoryImpl implements FBallRepository {
  final FBallRemoteDataSource _fBallRemoteDataSource;
  final FireBaseAuthAdapterForUseCase _fireBaseAuthBaseAdapter;

  FBallRepositoryImpl(
      {@required FBallRemoteDataSource fBallRemoteDataSource,
      @required FireBaseAuthAdapterForUseCase fireBaseAuthBaseAdapter})
      : _fBallRemoteDataSource = fBallRemoteDataSource,
        _fireBaseAuthBaseAdapter = fireBaseAuthBaseAdapter;

  @override
  Future<PageWrap<FBallResDto>> listUpFromInfluencePower(
      FBallListUpFromBallInfluencePowerReqDto listUpReqDto) async {
    var result = await _fBallRemoteDataSource.listUpFromInfluencePower(
        listUpReqDto, FDio.noneToken());
    return result;
  }

  @override
  Future<PageWrap<FBallResDto>> getUserToMakerBalls(
      {@required UserToMakeBallReqDto reqDto}) async {
    var result = await _fBallRemoteDataSource.getUserToMakerBalls(
        reqDto: reqDto, noneTokenFDio: FDio.noneToken());
    return result;
  }

  @override
  Future<PageWrap<FBallResDto>>  listUpFromSearchTitle(
      {@required FBallListUpFromSearchTitleReqDto reqDto}) async {
    var result = await _fBallRemoteDataSource.listUpFromSearchTitle(
        reqDto: reqDto, noneTokenFDio: FDio.noneToken());
    return result;
  }

  @override
  Future<PageWrap<FBallResDto>>  listUpFromTagName(
      {@required FBallListUpFromTagNameReqDto reqDto}) async {
    var result = await _fBallRemoteDataSource.listUpFromTagName(
        reqDto: reqDto, noneTokenFDio: FDio.noneToken());
    return result;
  }

  @override
  Future<PageWrap<FBallResDto>> ballListUpFromMapArea(
      {@required BallFromMapAreaReqDto reqDto}) async {
    var result = await _fBallRemoteDataSource.listUpBallFromMapArea(
        reqDto: reqDto, noneTokenFDio: FDio.noneToken());
    return result;
  }

  @override
  Future<int> ballHit(FBallReqDto reqDto) async {
    return await _fBallRemoteDataSource.ballHit(
        reqDto: reqDto, noneTokenFDio: FDio.noneToken());
  }

  @override
  Future<int> deleteBall(String ballUuid) async {
    return _fBallRemoteDataSource.deleteBall(
        ballUuid: ballUuid,
        fDio: FDio.token(
            idToken: await _fireBaseAuthBaseAdapter.getFireBaseIdToken()));
  }

  @override
  Future<FBall> insertBall(FBallInsertReqDto reqDto) async {
    return _fBallRemoteDataSource.insertBall(
        reqDto: reqDto,
        fDio: FDio.token(
            idToken: await _fireBaseAuthBaseAdapter.getFireBaseIdToken()));
  }

  @override
  Future<FBall> selectBall(String ballUuid) async {
    return await _fBallRemoteDataSource.selectBall(
        ballUuid: ballUuid, noneTokenFDio: FDio.noneToken());
  }

  @override
  Future<int> updateBall(FBallUpdateReqDto reqDto) async {
    return await _fBallRemoteDataSource.updateBall(
        reqDto: reqDto,
        fDio: FDio.token(
            idToken: await _fireBaseAuthBaseAdapter.getFireBaseIdToken()));
  }

  @override
  Future<FBallImageUpload> ballImageUpload(
      {@required List<Uint8List> images}) async {
    var fBallImageUpload = await _fBallRemoteDataSource.ballImageUpload(
        images: images,
        tokenFDio: FDio.token(
            idToken: await _fireBaseAuthBaseAdapter.getFireBaseIdToken()));
    return fBallImageUpload;
  }

}
