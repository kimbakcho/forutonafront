import 'package:flutter/material.dart';
import 'package:forutonafront/Common/FDio.dart';
import 'package:forutonafront/FBall/Data/Value/FBallListUpWrap.dart';
import 'package:forutonafront/Tag/Data/Value/FBallTagRankingWrap.dart';
import 'package:forutonafront/Tag/Data/Value/FBallTagWrap.dart';
import 'package:forutonafront/Tag/Dto/TagFromBallReqDto.dart';
import 'package:forutonafront/Tag/Dto/TagRankingReqDto.dart';
import 'package:forutonafront/Tag/Dto/TagSearchFromTextReqDto.dart';

abstract class IFBallTagRemoteDataSource {
  Future<FBallTagRankingWrap> getTagRanking({@required TagRankingReqDto reqDto,@required FDio noneTokenFDio});
  Future<FBallListUpWrap> tagSearchFromTextToBalls({@required TagSearchFromTextReqDto reqDto,@required FDio noneTokenFDio});
  Future<FBallTagRankingWrap> tagSearchFromTextToTagRankings({@required TagSearchFromTextReqDto reqDto,@required FDio noneTokenFDio});
  Future<FBallTagWrap> tagFromBallUuid({@required TagFromBallReqDto reqDto,@required @required FDio noneTokenFDio});
}

class FBallTagRemoteDataSource implements IFBallTagRemoteDataSource{
  FBallTagRemoteDataSource();

  @override
  Future<FBallTagRankingWrap> getTagRanking({@required TagRankingReqDto reqDto,@required FDio noneTokenFDio}) async {
    var response = await noneTokenFDio.get("/v1/FTag/Ranking",
        queryParameters: reqDto.toJson()
    );
    return FBallTagRankingWrap.fromJson(response.data);
  }

  @override
  Future<FBallListUpWrap> tagSearchFromTextToBalls({@required TagSearchFromTextReqDto reqDto,@required FDio noneTokenFDio}) async {
    var response =
        await noneTokenFDio.get("/v1/FTag/tagSearchFromTextToBalls", queryParameters: reqDto.toJson());
    var fBallListUpWrap = FBallListUpWrap.fromJson(response.data);
    return fBallListUpWrap;
  }

  @override
  Future<FBallTagRankingWrap> tagSearchFromTextToTagRankings({@required TagSearchFromTextReqDto reqDto,@required  FDio noneTokenFDio}) async {
    var response =
        await noneTokenFDio.get("/v1/FTag/tagSearchFromTextToTagRankings", queryParameters: reqDto.toJson());
    var tagRankingWrap = FBallTagRankingWrap.fromJson(response.data);
    return tagRankingWrap;
  }

  @override
  Future<FBallTagWrap> tagFromBallUuid({@required TagFromBallReqDto reqDto,@required FDio noneTokenFDio}) async {
    var response = await noneTokenFDio.get("/v1/FTag/tagFromBallUuid",queryParameters:reqDto.toJson());
    return FBallTagWrap.fromJson(response.data);
  }


}