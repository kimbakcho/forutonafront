import 'package:forutonafront/Common/FDio.dart';
import 'file:///C:/workproject/FlutterPro/forutonafront/lib/FBall/Data/Entity/FBallListUpWrap.dart';
import 'package:forutonafront/Tag/Data/DataSource/FBallTagRemoteDataSource.dart';
import 'package:forutonafront/Tag/Data/Value/FBallTagRankingWrap.dart';
import 'package:forutonafront/Tag/Data/Value/FBallTagWrap.dart';
import 'package:forutonafront/Tag/Domain/Repository/ITagRepository.dart';
import 'package:forutonafront/Tag/Dto/TagFromBallReqDto.dart';
import 'package:forutonafront/Tag/Dto/TagRankingReqDto.dart';
import 'package:forutonafront/Tag/Dto/TagSearchFromTextReqDto.dart';

class TagRepositoryImpl implements ITagRepository {

  IFBallTagRemoteDataSource _ifBallTagRemoteDataSource = FBallTagRemoteDataSource();

  @override
  Future<FBallTagRankingWrap> getTagRanking(TagRankingReqDto reqDto) async {
    return await _ifBallTagRemoteDataSource.getTagRanking(reqDto: reqDto, noneTokenFDio: FDio.noneToken());
  }

  @override
  Future<FBallListUpWrap> tagSearchFromTextToBalls(TagSearchFromTextReqDto reqDto) async {
    return await _ifBallTagRemoteDataSource.tagSearchFromTextToBalls(reqDto: reqDto, noneTokenFDio: FDio.noneToken());
  }

  @override
  Future<FBallTagRankingWrap> tagSearchFromTextToTagRankings(TagSearchFromTextReqDto reqDto) async {
    return await _ifBallTagRemoteDataSource.tagSearchFromTextToTagRankings(reqDto: reqDto, noneTokenFDio: FDio.noneToken());
  }

  @override
  Future<FBallTagWrap> tagFromBallUuid(TagFromBallReqDto reqDto) async {
    return await _ifBallTagRemoteDataSource.tagFromBallUuid(reqDto: reqDto, noneTokenFDio: FDio.noneToken());
  }
  

}