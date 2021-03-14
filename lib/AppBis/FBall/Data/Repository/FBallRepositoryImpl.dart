import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:forutonafront/Common/FDio.dart';
import 'package:forutonafront/Common/Page/Dto/PageWrap.dart';
import 'package:forutonafront/Common/PageableDto/Pageable.dart';
import 'package:forutonafront/AppBis/FBall/Data/DataStore/FBallRemoteDataSource.dart';
import 'package:forutonafront/AppBis/FBall/Domain/Repository/FBallRepository.dart';
import 'package:forutonafront/AppBis/FBall/Domain/Value/FBallImageUpload.dart';
import 'package:forutonafront/AppBis/FBall/Dto/BallFromMapAreaReqDto.dart';
import 'package:forutonafront/AppBis/FBall/Dto/FBallInsertReqDto/FBallInsertReqDto.dart';
import 'package:forutonafront/AppBis/FBall/Dto/FBallListUpFromBIReqDto.dart';
import 'package:forutonafront/AppBis/FBall/Dto/FBallListUpFromSearchTitleReqDto.dart';
import 'package:forutonafront/AppBis/FBall/Dto/FBallListUpFromTagNameReqDto.dart';
import 'package:forutonafront/AppBis/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/AppBis/FBall/Dto/FBallUpdateReqDto/FBallUpdateReqDto.dart';
import 'package:forutonafront/AppBis/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthAdapterForUseCase.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:http_parser/http_parser.dart';

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
    FDio fDio = FDio.token(idToken: await fireBaseAuthBaseAdapter.getFireBaseIdToken());
    List<MultipartFile> imageFiles = [];
    for (var image in images) {
      imageFiles.add(MultipartFile.fromBytes(image,
          contentType: MediaType("image", "jpeg"), filename: "ballImage.jpg"));
    }
    var formData = FormData.fromMap({"imageFiles": imageFiles});
    var response = await fDio.post("/v1/FBall/BallImageUpload", data: formData);
    return FBallImageUpload.fromJson(response.data);
  }

  @override
  Future<List<FBallResDto>> selectBalls(List<String> ballUuids) async {
    var fDio = FDio.noneToken();
    var response = await fDio.get("/v1/FBalls",queryParameters: {
      "ballUuids" : ballUuids.toString()
    });
    return List<FBallResDto>.from(
        response.data.map((x) => FBallResDto.fromJson(x)));
  }


}
