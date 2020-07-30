import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:forutonafront/Common/FDio.dart';
import 'package:forutonafront/Tag/Data/Entity/FBallTagWrap.dart';
import 'package:forutonafront/Tag/Data/Value/FBallTagRankingWrap.dart';
import 'package:forutonafront/Tag/Dto/FBallTagResDto.dart';
import 'package:forutonafront/Tag/Dto/RelationTagRankingFromTagNameReqDto.dart';
import 'package:forutonafront/Tag/Dto/TagRankingFromBallInfluencePowerReqDto.dart';

abstract class FBallTagRemoteDataSource {
  Future<FBallTagRankingWrap> getFTagRankingFromBallInfluencePower(
      TagRankingFromBallInfluencePowerReqDto reqDto, FDio noneTokenFDio);

  Future<FBallTagRankingWrap> getRelationTagRankingFromTagNameOrderByBallPower(
      {@required RelationTagRankingFromTagNameReqDto reqDto,
      @required FDio noneTokenFDio});

  Future<List<FBallTagResDto>> tagFromBallUuid(
      {@required String ballUuid, @required FDio noneTokenFDio});
}

class FBallTagRemoteDataSourceImpl implements FBallTagRemoteDataSource {
  FBallTagRemoteDataSourceImpl();

  @override
  Future<FBallTagRankingWrap> getFTagRankingFromBallInfluencePower(
      TagRankingFromBallInfluencePowerReqDto reqDto, FDio noneTokenFDio) async {
    var response = await noneTokenFDio.get(
        "/v1/FTag/RankingFromBallInfluencePower",
        queryParameters: reqDto.toJson());
    return FBallTagRankingWrap.fromJson(response.data);
  }

  @override
  Future<FBallTagRankingWrap> getRelationTagRankingFromTagNameOrderByBallPower(
      {@required RelationTagRankingFromTagNameReqDto reqDto,
      @required FDio noneTokenFDio}) async {
    var response = await noneTokenFDio.get(
        "/v1/FTag/RelationTagRankingFromTagNameOrderByBallPower",
        queryParameters: reqDto.toJson());
    return FBallTagRankingWrap.fromJson(response.data);
  }

  @override
  Future<List<FBallTagResDto>> tagFromBallUuid(
      {@required String ballUuid, @required FDio noneTokenFDio}) async {
    var response = await noneTokenFDio.get("/v1/FTag/tagFromBallUuid",
        queryParameters: {"ballUuid": ballUuid});
    print(response.data);
    return List<FBallTagResDto>.from(response.data.map((x) => FBallTagResDto.fromJson(x)));
  }
}
