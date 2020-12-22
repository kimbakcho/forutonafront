import 'package:flutter/material.dart';
import 'package:forutonafront/Common/FDio.dart';
import 'package:forutonafront/Common/Page/Dto/PageWrap.dart';
import 'package:forutonafront/Common/PageableDto/Pageable.dart';
import 'package:forutonafront/AppBis/Tag/Dto/FBallTagResDto.dart';
import 'package:forutonafront/AppBis/Tag/Dto/TagRankingFromBallInfluencePowerReqDto.dart';
import 'package:forutonafront/AppBis/Tag/Dto/TagRankingFromTextReqDto.dart';
import 'package:forutonafront/AppBis/Tag/Dto/TagRankingResDto.dart';
import 'package:forutonafront/AppBis/Tag/Dto/TextMatchTagBallReqDto.dart';
import 'package:injectable/injectable.dart';

abstract class FBallTagRemoteDataSource {
  Future<List<TagRankingResDto>> getFTagRankingFromBallInfluencePower(
      TagRankingFromBallInfluencePowerReqDto reqDto, FDio noneTokenFDio);

  Future<List<TagRankingResDto>>
      getRelationTagRankingFromTagNameOrderByBallPower(
          {@required String searchTag, @required FDio noneTokenFDio});

  Future<List<FBallTagResDto>> tagFromBallUuid(
      {@required String ballUuid, @required FDio noneTokenFDio});

  Future<List<TagRankingResDto>> getTagRankingFromTextOrderBySumBI(
      {@required TagRankingFromTextReqDto tagRankingFromTextReqDto,
      @required FDio noneTokenFDio});

  Future<PageWrap<FBallTagResDto>> getTagItem(
      {@required TextMatchTagBallReqDto textMatchTagBallReqDto,
      @required Pageable pageable,
      @required FDio noneTokenFDio});
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
    return List<TagRankingResDto>.from(
        response.data.map((x) => TagRankingResDto.fromJson(x)));
  }

  @override
  Future<List<TagRankingResDto>>
      getRelationTagRankingFromTagNameOrderByBallPower(
          {@required String searchTag, @required FDio noneTokenFDio}) async {
    var response = await noneTokenFDio.get(
        "/v1/FTag/RelationTagRankingFromTagNameOrderByBallPower",
        queryParameters: {"searchTag": searchTag});
    return List<TagRankingResDto>.from(
        response.data.map((x) => TagRankingResDto.fromJson(x)));
  }

  @override
  Future<List<FBallTagResDto>> tagFromBallUuid(
      {@required String ballUuid, @required FDio noneTokenFDio}) async {
    var response = await noneTokenFDio.get("/v1/FTag/tagFromBallUuid",
        queryParameters: {"ballUuid": ballUuid});
    return List<FBallTagResDto>.from(
        response.data.map((x) => FBallTagResDto.fromJson(x)));
  }

  @override
  Future<List<TagRankingResDto>> getTagRankingFromTextOrderBySumBI(
      {@required TagRankingFromTextReqDto tagRankingFromTextReqDto,
      @required FDio noneTokenFDio}) async {
    var response = await noneTokenFDio.get(
        "/v1/FTag/TagRankingFromTextOrderBySumBI",
        queryParameters: tagRankingFromTextReqDto.toJson());
    return List<TagRankingResDto>.from(
        response.data.map((x) => TagRankingResDto.fromJson(x)));
  }

  @override
  Future<PageWrap<FBallTagResDto>> getTagItem(
      {TextMatchTagBallReqDto textMatchTagBallReqDto,
      Pageable pageable,
      FDio noneTokenFDio}) async {
    var reqDto = textMatchTagBallReqDto.toJson();
    reqDto.addAll(pageable.toJson());
    var response = await noneTokenFDio.get(
        "/v1/FTag/TagItem",
        queryParameters: reqDto);
    return PageWrap.fromJson(response.data, FBallTagResDto.fromJson);
  }
}
