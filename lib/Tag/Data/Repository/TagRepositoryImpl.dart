import 'package:forutonafront/Common/FDio.dart';
import 'package:forutonafront/Tag/Data/DataSource/FBallTagRemoteDataSource.dart';
import 'package:forutonafront/Tag/Data/Entity/FBallTagWrap.dart';
import 'package:forutonafront/Tag/Data/Value/FBallTagRankingWrap.dart';
import 'package:forutonafront/Tag/Domain/Repository/TagRepository.dart';
import 'package:forutonafront/Tag/Dto/RelationTagRankingFromTagNameReqDto.dart';
import 'package:forutonafront/Tag/Dto/TagFromBallReqDto.dart';
import 'package:forutonafront/Tag/Dto/TagRankingFromBallInfluencePowerReqDto.dart';
import 'package:meta/meta.dart';

class TagRepositoryImpl implements TagRepository {
  final FBallTagRemoteDataSource _fBallTagRemoteDataSource;

  TagRepositoryImpl(
      {@required FBallTagRemoteDataSource fBallTagRemoteDataSource})
      : _fBallTagRemoteDataSource = fBallTagRemoteDataSource;

  @override
  Future<FBallTagRankingWrap> getFTagRankingFromBallInfluencePower(
      TagRankingFromBallInfluencePowerReqDto reqDto) async {
    return await _fBallTagRemoteDataSource.getFTagRankingFromBallInfluencePower(
        reqDto, FDio.noneToken());
  }

  @override
  Future<FBallTagRankingWrap> getRelationTagRankingFromTagNameOrderByBallPower(
      RelationTagRankingFromTagNameReqDto reqDto) async {
    return await _fBallTagRemoteDataSource
        .getRelationTagRankingFromTagNameOrderByBallPower(
            reqDto: reqDto, noneTokenFDio: FDio.noneToken());
  }

  @override
  Future<FBallTagWrap> tagFromBallUuid(TagFromBallReqDto reqDto) async {
    return await _fBallTagRemoteDataSource.tagFromBallUuid(
        reqDto: reqDto, noneTokenFDio: FDio.noneToken());
  }
}
