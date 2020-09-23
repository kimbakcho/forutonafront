import 'dart:typed_data';

import 'package:forutonafront/Common/FDio.dart';
import 'package:forutonafront/Common/Page/Dto/PageWrap.dart';
import 'package:forutonafront/Common/PageableDto/Pageable.dart';
import 'package:forutonafront/FBall/Data/DataStore/FBallRemoteDataSource.dart';
import 'package:forutonafront/FBall/Domain/Repository/FBallRepository.dart';
import 'package:forutonafront/FBall/Domain/Value/FBallImageUpload.dart';
import 'package:forutonafront/FBall/Dto/BallFromMapAreaReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallInsertReqDto/FBallInsertReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallListUpFromBIReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallListUpFromSearchTitleReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallListUpFromTagNameReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/FBall/Dto/FBallUpdateReqDto/FBallUpdateReqDto.dart';
import 'package:forutonafront/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthAdapterForUseCase.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

@LazySingleton(as: FBallRepository)
class FBallRepositoryImpl implements FBallRepository {
  final FBallRemoteDataSource fBallRemoteDataSource;
  final FireBaseAuthAdapterForUseCase fireBaseAuthBaseAdapter;

  FBallRepositoryImpl(
      {@required this.fBallRemoteDataSource,
      @required  this.fireBaseAuthBaseAdapter});


  @override
  Future<PageWrap<FBallResDto>> findByBallOrderByBI(
      {@required FBallListUpFromBIReqDto listUpReqDto,
      @required Pageable pageable}) async {
    var result = await fBallRemoteDataSource.findByBallOrderByBI(
        listUpReqDto, pageable, FDio.noneToken());
    return result;
  }

  @override
  Future<PageWrap<FBallResDto>> searchUserToMakerBalls(
      {@required String makerUid, @required Pageable pageable}) async {
    var result = await fBallRemoteDataSource.searchUserToMakerBalls(
        makerUid: makerUid,
        pageable: pageable,
        noneTokenFDio: FDio.noneToken());
    return result;
  }

  @override
  Future<PageWrap<FBallResDto>> listUpFromSearchTitle(
      {@required FBallListUpFromSearchTitleReqDto reqDto,
      @required Pageable pageable}) async {
    var result = await fBallRemoteDataSource.listUpFromSearchTitle(
        reqDto: reqDto, pageable: pageable, noneTokenFDio: FDio.noneToken());
    return result;
  }

  @override
  Future<PageWrap<FBallResDto>> listUpFromTagName(
      {@required FBallListUpFromTagNameReqDto reqDto,
      @required Pageable pageable}) async {
    var result = await fBallRemoteDataSource.listUpFromTagName(
        reqDto: reqDto, pageable: pageable, noneTokenFDio: FDio.noneToken());
    return result;
  }

  @override
  Future<PageWrap<FBallResDto>> ballListUpFromMapArea(
      {@required BallFromMapAreaReqDto reqDto,
      @required Pageable pageable}) async {
    var result = await fBallRemoteDataSource.listUpBallFromMapArea(
        reqDto: reqDto, pageable: pageable, noneTokenFDio: FDio.noneToken());
    return result;
  }

  @override
  Future<int> ballHit(String ballUuid) async {
    return await fBallRemoteDataSource.ballHit(
        ballUuid: ballUuid, noneTokenFDio: FDio.noneToken());
  }

  @override
  Future<String> deleteBall(String ballUuid) async {
    return fBallRemoteDataSource.deleteBall(
        ballUuid: ballUuid,
        fDio: FDio.token(
            idToken: await fireBaseAuthBaseAdapter.getFireBaseIdToken()));
  }

  @override
  Future<FBallResDto> insertBall(FBallInsertReqDto reqDto) async {
    return fBallRemoteDataSource.insertBall(
        reqDto: reqDto,
        fDio: FDio.token(
            idToken: await fireBaseAuthBaseAdapter.getFireBaseIdToken()));
  }

  @override
  Future<FBallResDto> selectBall(String ballUuid) async {
    return await fBallRemoteDataSource.selectBall(
        ballUuid: ballUuid, noneTokenFDio: FDio.noneToken());
  }

  @override
  Future<FBallResDto> updateBall(FBallUpdateReqDto reqDto) async {
    return await fBallRemoteDataSource.updateBall(
        reqDto: reqDto,
        fDio: FDio.token(
            idToken: await fireBaseAuthBaseAdapter.getFireBaseIdToken()));
  }

  @override
  Future<FBallImageUpload> ballImageUpload(
      {@required List<Uint8List> images}) async {
    var fBallImageUpload = await fBallRemoteDataSource.ballImageUpload(
        images: images,
        tokenFDio: FDio.token(
            idToken: await fireBaseAuthBaseAdapter.getFireBaseIdToken()));
    return fBallImageUpload;
  }


}
