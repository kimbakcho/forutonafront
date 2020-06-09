import 'package:flutter/material.dart';
import 'package:forutonafront/Common/FDio.dart';
import 'package:forutonafront/Tag/Data/Entity/FBallTagWrap.dart';
import 'package:forutonafront/Tag/Data/Value/FBallTagRankingWrap.dart';

import 'package:forutonafront/Tag/Dto/RelationTagRankingFromTagNameReqDto.dart';
import 'package:forutonafront/Tag/Dto/TagFromBallReqDto.dart';
import 'package:forutonafront/Tag/Dto/TagRankingFromBallInfluencePowerReqDto.dart';

abstract class FBallTagRemoteDataSource {
  Future<FBallTagRankingWrap> getFTagRankingFromBallInfluencePower({@required TagRankingFromBallInfluencePowerReqDto reqDto,@required FDio noneTokenFDio});
  Future<FBallTagRankingWrap> getRelationTagRankingFromTagNameOrderByBallPower({@required RelationTagRankingFromTagNameReqDto reqDto,@required FDio noneTokenFDio});
  Future<FBallTagWrap> tagFromBallUuid({@required TagFromBallReqDto reqDto,@required @required FDio noneTokenFDio});
}

class FBallTagRemoteDataSourceImpl implements FBallTagRemoteDataSource{
  FBallTagRemoteDataSourceImpl();

  @override
  Future<FBallTagRankingWrap> getFTagRankingFromBallInfluencePower({@required TagRankingFromBallInfluencePowerReqDto reqDto,@required FDio noneTokenFDio}) async {
    var response = await noneTokenFDio.get("/v1/FTag/RankingFromBallInfluencePower",
        queryParameters: reqDto.toJson()
    );
    return FBallTagRankingWrap.fromJson(response.data);
  }

  @override
  Future<FBallTagRankingWrap> getRelationTagRankingFromTagNameOrderByBallPower
      ({@required RelationTagRankingFromTagNameReqDto reqDto,@required FDio noneTokenFDio}) async {
    var response = await noneTokenFDio.get("/v1/FTag/RelationTagRankingFromTagNameOrderByBallPower",
        queryParameters: reqDto.toJson()
    );
    return FBallTagRankingWrap.fromJson(response.data);

  }

  @override
  Future<FBallTagWrap> tagFromBallUuid({@required TagFromBallReqDto reqDto,@required FDio noneTokenFDio}) async {
    var response = await noneTokenFDio.get("/v1/FTag/tagFromBallUuid",queryParameters:reqDto.toJson());
    return FBallTagWrap.fromJson(response.data);
  }




}