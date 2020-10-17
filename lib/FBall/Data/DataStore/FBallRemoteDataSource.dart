import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:forutonafront/Common/FDio.dart';
import 'package:forutonafront/Common/Page/Dto/PageWrap.dart';
import 'package:forutonafront/Common/PageableDto/Pageable.dart';
import 'package:forutonafront/FBall/Domain/Value/FBallImageUpload.dart';
import 'package:forutonafront/FBall/Dto/BallFromMapAreaReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallInsertReqDto/FBallInsertReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallListUpFromBIReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallListUpFromSearchTitleReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallListUpFromTagNameReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/FBall/Dto/FBallUpdateReqDto/FBallUpdateReqDto.dart';
import 'package:http_parser/http_parser.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

abstract class FBallRemoteDataSource {
  Future<PageWrap<FBallResDto>> findByBallOrderByBI(
      FBallListUpFromBIReqDto fBallListUpFromBIReqDto,
      Pageable pageable,
      FDio noneTokenFDio);

  Future<PageWrap<FBallResDto>> searchUserToMakerBalls(
      {@required String makerUid,
      @required Pageable pageable,
      @required FDio noneTokenFDio});

  Future<PageWrap<FBallResDto>> listUpFromSearchTitle(
      {@required FBallListUpFromSearchTitleReqDto reqDto,
      @required Pageable pageable,
      @required FDio noneTokenFDio});

  Future<PageWrap<FBallResDto>> listUpFromTagName(
      {@required FBallListUpFromTagNameReqDto reqDto,
      @required Pageable pageable,
      @required FDio noneTokenFDio});

  Future<PageWrap<FBallResDto>> listUpBallFromMapArea(
      {@required BallFromMapAreaReqDto reqDto,
      @required Pageable pageable,
      @required FDio noneTokenFDio});

  Future<String> deleteBall({@required String ballUuid, @required FDio fDio});

  Future<FBallResDto> insertBall(
      {@required FBallInsertReqDto reqDto, @required FDio fDio});

  Future<FBallResDto> selectBall(
      {@required String ballUuid, @required FDio noneTokenFDio});

  Future<FBallResDto> updateBall(
      {@required FBallUpdateReqDto reqDto, @required FDio fDio});

  Future<int> ballHit(
      {@required String ballUuid, @required FDio noneTokenFDio});

  Future<FBallImageUpload> ballImageUpload(
      {@required List<Uint8List> images, @required FDio tokenFDio});
}

@LazySingleton(as: FBallRemoteDataSource)
class FBallRemoteSourceImpl implements FBallRemoteDataSource {
  @override
  Future<PageWrap<FBallResDto>> findByBallOrderByBI(
      FBallListUpFromBIReqDto fBallListUpFromBIReqDto,
      Pageable pageable,
      FDio noneTokenFDio) async {
    Map<String, dynamic> jsonReq = fBallListUpFromBIReqDto.toJson();
    jsonReq.addAll(pageable.toJson());
    var response = await noneTokenFDio
        .get("/v1/FBall/ListUpBallListUpOrderByBI", queryParameters: jsonReq);
    return PageWrap<FBallResDto>.fromJson(response.data, FBallResDto.fromJson);
  }

  @override
  Future<PageWrap<FBallResDto>> searchUserToMakerBalls(
      {@required String makerUid,
      @required Pageable pageable,
      @required FDio noneTokenFDio}) async {
    Map<String, dynamic> reqJson = Map<String, dynamic>();
    reqJson["makerUid"] = makerUid;
    reqJson.addAll(pageable.toJson());
    var response = await noneTokenFDio.get("/v1/FBall/UserToMakerBalls",
        queryParameters: reqJson);
    return PageWrap<FBallResDto>.fromJson(response.data,
        response.data["content"].map((e) => FBallResDto.fromJson(e)).toList());
  }

  @override
  Future<PageWrap<FBallResDto>> listUpFromSearchTitle(
      {@required FBallListUpFromSearchTitleReqDto reqDto,
      @required Pageable pageable,
      @required FDio noneTokenFDio}) async {
    Map<String, dynamic> jsonReq = reqDto.toJson();
    jsonReq.addAll(pageable.toJson());
    var response = await noneTokenFDio.get("/v1/FBall/ListUpFromSearchTitle",
        queryParameters: jsonReq);
    return PageWrap<FBallResDto>.fromJson(response.data, FBallResDto.fromJson);
  }

  @override
  Future<PageWrap<FBallResDto>> listUpFromTagName(
      {@required FBallListUpFromTagNameReqDto reqDto,
      @required Pageable pageable,
      @required FDio noneTokenFDio}) async {
    Map<String, dynamic> jsonReq = reqDto.toJson();
    jsonReq.addAll(pageable.toJson());
    var response = await noneTokenFDio.get("/v1/FBall/ListUpFromTagName",
        queryParameters: jsonReq);
    return PageWrap<FBallResDto>.fromJson(response.data,
        response.data["content"].map((e) => FBallResDto.fromJson(e)).toList());
  }

  @override
  Future<PageWrap<FBallResDto>> listUpBallFromMapArea(
      {@required BallFromMapAreaReqDto reqDto,
      @required Pageable pageable,
      @required FDio noneTokenFDio}) async {
    Map<String, dynamic> jsonReq = reqDto.toJson();
    jsonReq.addAll(pageable.toJson());
    var response = await noneTokenFDio.get("/v1/FBall/ListUpFromMapArea",
        queryParameters: jsonReq);
    return PageWrap<FBallResDto>.fromJson(response.data, FBallResDto.fromJson);
  }

  @override
  Future<int> ballHit(
      {@required String ballUuid, @required FDio noneTokenFDio}) async {
    var response = await noneTokenFDio
        .post("/v1/FBall/BallHit", queryParameters: {"ballUuid": ballUuid});
    return response.data;
  }

  @override
  Future<String> deleteBall(
      {@required String ballUuid, @required FDio fDio}) async {
    var response =
        await fDio.delete("/v1/FBall", queryParameters: {"ballUuid": ballUuid});
    return response.data;
  }

  @override
  Future<FBallResDto> insertBall(
      {@required FBallInsertReqDto reqDto, @required FDio fDio}) async {
    var response = await fDio.post("/v1/FBall", data: reqDto.toJson());
    return response.data;
  }

  @override
  Future<FBallResDto> selectBall(
      {@required String ballUuid, @required FDio noneTokenFDio}) async {
    var response = await noneTokenFDio
        .get("/v1/FBall", queryParameters: {"ballUuid": ballUuid});
    return FBallResDto.fromJson(response.data);
  }

  @override
  Future<FBallResDto> updateBall(
      {@required FBallUpdateReqDto reqDto, @required FDio fDio}) async {
    var response = await fDio.put("/v1/FBall", data: reqDto.toJson());
    return FBallResDto.fromJson(response.data);
  }

  @override
  Future<FBallImageUpload> ballImageUpload(
      {@required List<Uint8List> images, @required FDio tokenFDio}) async {
    List<MultipartFile> imageFiles = [];
    for (var image in images) {
      imageFiles.add(MultipartFile.fromBytes(image,
          contentType: MediaType("image", "jpeg"), filename: "ballImage.jpg"));
    }
    var formData = FormData.fromMap({"imageFiles": imageFiles});
    var response =
        await tokenFDio.post("/v1/FBall/BallImageUpload", data: formData);
    return FBallImageUpload.fromJson(response.data);
  }
}
