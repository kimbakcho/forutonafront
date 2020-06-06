import 'package:forutonafront/Common/FDio.dart';
import 'package:forutonafront/Tag/Data/DataSource/FBallTagRemoteDataSource.dart';
import 'package:forutonafront/Tag/Data/Value/FBallTagRankingWrap.dart';
import 'file:///C:/workproject/FlutterPro/forutonafront/lib/Tag/Data/Entity/FBallTagWrap.dart';
import 'package:forutonafront/Tag/Domain/Repository/TagRepository.dart';
import 'package:forutonafront/Tag/Dto/RelationTagRankingFromTagNameReqDto.dart';
import 'package:forutonafront/Tag/Dto/TagFromBallReqDto.dart';
import 'package:forutonafront/Tag/Dto/TagRankingFromBallInfluencePowerReqDto.dart';


class TagRepositoryImpl implements TagRepository {

  IFBallTagRemoteDataSource _fBallTagRemoteDataSource = FBallTagRemoteDataSource();

  @override
  Future<FBallTagRankingWrap> getFTagRankingFromBallInfluencePower(TagRankingFromBallInfluencePowerReqDto reqDto) async {
    return await _fBallTagRemoteDataSource.getFTagRankingFromBallInfluencePower(reqDto: reqDto, noneTokenFDio: FDio.noneToken());
  }


  @override
  Future<FBallTagRankingWrap> getRelationTagRankingFromTagNameOrderByBallPower(RelationTagRankingFromTagNameReqDto reqDto) async {
    return await _fBallTagRemoteDataSource.getRelationTagRankingFromTagNameOrderByBallPower(reqDto: reqDto, noneTokenFDio: FDio.noneToken());
  }

  @override
  Future<FBallTagWrap> tagFromBallUuid(TagFromBallReqDto reqDto) async {
    return await _fBallTagRemoteDataSource.tagFromBallUuid(reqDto: reqDto, noneTokenFDio: FDio.noneToken());
  }

  

}