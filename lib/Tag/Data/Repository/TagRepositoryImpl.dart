import 'package:meta/meta.dart';
import 'package:forutonafront/Common/FDio.dart';
import 'package:forutonafront/Tag/Data/DataSource/FBallTagRemoteDataSource.dart';
import 'package:forutonafront/Tag/Data/Entity/FBallTagWrap.dart';
import 'package:forutonafront/Tag/Data/Value/FBallTagRankingWrap.dart';

import 'package:forutonafront/Tag/Domain/Repository/TagRepository.dart';
import 'package:forutonafront/Tag/Dto/RelationTagRankingFromTagNameReqDto.dart';
import 'package:forutonafront/Tag/Dto/TagFromBallReqDto.dart';
import 'package:forutonafront/Tag/Dto/TagRankingFromBallInfluencePowerReqDto.dart';


class TagRepositoryImpl implements TagRepository {

  final FBallTagRemoteDataSource fBallTagRemoteDataSource;

  TagRepositoryImpl({@required this.fBallTagRemoteDataSource}):assert(fBallTagRemoteDataSource!=null);


  @override
  Future<FBallTagRankingWrap> getFTagRankingFromBallInfluencePower(TagRankingFromBallInfluencePowerReqDto reqDto) async {
    return await fBallTagRemoteDataSource.getFTagRankingFromBallInfluencePower(reqDto,FDio.noneToken());
  }


  @override
  Future<FBallTagRankingWrap> getRelationTagRankingFromTagNameOrderByBallPower(RelationTagRankingFromTagNameReqDto reqDto) async {
    return await fBallTagRemoteDataSource.getRelationTagRankingFromTagNameOrderByBallPower(reqDto: reqDto, noneTokenFDio: FDio.noneToken());
  }

  @override
  Future<FBallTagWrap> tagFromBallUuid(TagFromBallReqDto reqDto) async {
    return await fBallTagRemoteDataSource.tagFromBallUuid(reqDto: reqDto, noneTokenFDio: FDio.noneToken());
  }

  

}