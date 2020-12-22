import 'package:forutonafront/Common/FDio.dart';
import 'package:forutonafront/Common/Page/Dto/PageWrap.dart';
import 'package:forutonafront/Common/PageableDto/Pageable.dart';
import 'package:forutonafront/AppBis/Tag/Data/DataSource/FBallTagRemoteDataSource.dart';
import 'package:forutonafront/AppBis/Tag/Domain/Repository/TagRepository.dart';
import 'package:forutonafront/AppBis/Tag/Dto/FBallTagResDto.dart';
import 'package:forutonafront/AppBis/Tag/Dto/TagRankingFromBallInfluencePowerReqDto.dart';
import 'package:forutonafront/AppBis/Tag/Dto/TagRankingFromTextReqDto.dart';
import 'package:forutonafront/AppBis/Tag/Dto/TagRankingResDto.dart';
import 'package:forutonafront/AppBis/Tag/Dto/TextMatchTagBallReqDto.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

@LazySingleton(as: TagRepository)
class TagRepositoryImpl implements TagRepository {
  final FBallTagRemoteDataSource _fBallTagRemoteDataSource;

  TagRepositoryImpl(
      {@required FBallTagRemoteDataSource fBallTagRemoteDataSource})
      : _fBallTagRemoteDataSource = fBallTagRemoteDataSource;

  @override
  Future<List<TagRankingResDto>> getFTagRankingFromBallInfluencePower(
      TagRankingFromBallInfluencePowerReqDto reqDto) async {
    return await _fBallTagRemoteDataSource.getFTagRankingFromBallInfluencePower(
        reqDto, FDio.noneToken());
  }

  @override
  Future<List<TagRankingResDto>>
      getRelationTagRankingFromTagNameOrderByBallPower(String searchTag) async {
    return await _fBallTagRemoteDataSource
        .getRelationTagRankingFromTagNameOrderByBallPower(
            searchTag: searchTag, noneTokenFDio: FDio.noneToken());
  }

  @override
  Future<List<FBallTagResDto>> tagFromBallUuid(String ballUuid) async {
    return await _fBallTagRemoteDataSource.tagFromBallUuid(
        ballUuid: ballUuid, noneTokenFDio: FDio.noneToken());
  }

  @override
  Future<List<TagRankingResDto>> findByTagRankingFromTextOrderBySumBI(
      {@required TagRankingFromTextReqDto tagRankingFromTextReqDto}) async {
    return await _fBallTagRemoteDataSource.getTagRankingFromTextOrderBySumBI(
        tagRankingFromTextReqDto: tagRankingFromTextReqDto,
        noneTokenFDio: FDio.noneToken());
  }

  @override
  Future<PageWrap<FBallTagResDto>> findByTagItem(
      TextMatchTagBallReqDto reqDto, Pageable pageable) async {
    return await _fBallTagRemoteDataSource.getTagItem(
        textMatchTagBallReqDto: reqDto,
        pageable: pageable,
        noneTokenFDio: FDio.noneToken());
  }
}
