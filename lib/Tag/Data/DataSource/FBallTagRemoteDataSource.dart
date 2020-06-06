import 'package:flutter/material.dart';
import 'package:forutonafront/Common/FDio.dart';
import 'package:forutonafront/FBall/Dto/FBallListUpFromTagNameReqDto.dart';
import 'file:///C:/workproject/FlutterPro/forutonafront/lib/FBall/Data/Entity/FBallListUpWrap.dart';
import 'package:forutonafront/Tag/Data/Value/FBallTagRankingWrap.dart';
import 'file:///C:/workproject/FlutterPro/forutonafront/lib/Tag/Data/Entity/FBallTagWrap.dart';
import 'package:forutonafront/Tag/Dto/RelationTagRankingFromTagNameReqDto.dart';
import 'package:forutonafront/Tag/Dto/TagFromBallReqDto.dart';
import 'package:forutonafront/Tag/Dto/TagRankingFromBallInfluencePowerReqDto.dart';

abstract class IFBallTagRemoteDataSource {
  Future<FBallTagRankingWrap> getFTagRankingFromBallInfluencePower({@required TagRankingFromBallInfluencePowerReqDto reqDto,@required FDio noneTokenFDio});
  Future<FBallTagRankingWrap> getRelationTagRankingFromTagNameOrderByBallPower({@required RelationTagRankingFromTagNameReqDto reqDto,@required FDio noneTokenFDio});
  Future<FBallTagWrap> tagFromBallUuid({@required TagFromBallReqDto reqDto,@required @required FDio noneTokenFDio});
}

class FBallTagRemoteDataSource implements IFBallTagRemoteDataSource{
  FBallTagRemoteDataSource();

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