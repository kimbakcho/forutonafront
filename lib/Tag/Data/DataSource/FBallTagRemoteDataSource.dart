import 'package:flutter/material.dart';
import 'package:forutonafront/Common/FDio.dart';
import 'package:forutonafront/Tag/Dto/FBallTagResDto.dart';
import 'package:forutonafront/Tag/Dto/TagRankingFromBallInfluencePowerReqDto.dart';
import 'package:forutonafront/Tag/Dto/TagRankingResDto.dart';
import 'package:injectable/injectable.dart';

abstract class FBallTagRemoteDataSource {
  Future<List<TagRankingResDto>> getFTagRankingFromBallInfluencePower(
      TagRankingFromBallInfluencePowerReqDto reqDto, FDio noneTokenFDio);

  Future<List<TagRankingResDto>>
      getRelationTagRankingFromTagNameOrderByBallPower(
          {@required String searchTag, @required FDio noneTokenFDio});

  Future<List<FBallTagResDto>> tagFromBallUuid(
      {@required String ballUuid, @required FDio noneTokenFDio});
}
@LazySingleton(as: FBallTagRemoteDataSource)
class FBallTagRemoteDataSourceImpl implements FBallTagRemoteDataSource {
  FBallTagRemoteDataSourceImpl();

  @override
  Future<List<TagRankingResDto>> getFTagRankingFromBallInfluencePower(
      TagRankingFromBallInfluencePowerReqDto reqDto, FDio noneTokenFDio) async {
    var response = await noneTokenFDio.get(
        "/v1/FTag/RankingFromBallInfluencePower",
        queryParameters: reqDto.toJson());
    return List<TagRankingResDto>.from(response.data.map((x)=>TagRankingResDto.fromJson(x)));
  }

  @override
  Future<List<TagRankingResDto>>
      getRelationTagRankingFromTagNameOrderByBallPower(
          {@required String searchTag, @required FDio noneTokenFDio}) async {
    var response = await noneTokenFDio.get(
        "/v1/FTag/RelationTagRankingFromTagNameOrderByBallPower",
        queryParameters: {"searchTag": searchTag});
    return List<TagRankingResDto>.from(response.data.map((x)=>TagRankingResDto.fromJson(x)));
  }

  @override
  Future<List<FBallTagResDto>> tagFromBallUuid(
      {@required String ballUuid, @required FDio noneTokenFDio}) async {
    var response = await noneTokenFDio.get("/v1/FTag/tagFromBallUuid",
        queryParameters: {"ballUuid": ballUuid});
    return List<FBallTagResDto>.from(
        response.data.map((x) => FBallTagResDto.fromJson(x)));
  }
}
