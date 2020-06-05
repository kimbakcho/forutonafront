import 'file:///C:/workproject/FlutterPro/forutonafront/lib/FBall/Data/Entity/FBallListUpWrap.dart';
import 'package:forutonafront/Tag/Data/Value/FBallTagRankingWrap.dart';
import 'package:forutonafront/Tag/Data/Value/FBallTagWrap.dart';
import 'package:forutonafront/Tag/Dto/TagFromBallReqDto.dart';
import 'package:forutonafront/Tag/Dto/TagRankingReqDto.dart';
import 'package:forutonafront/Tag/Dto/TagSearchFromTextReqDto.dart';

abstract class  ITagRepository {
  Future<FBallTagRankingWrap> getTagRanking(TagRankingReqDto reqDto);
  Future<FBallListUpWrap> tagSearchFromTextToBalls(TagSearchFromTextReqDto reqDto);
  Future<FBallTagRankingWrap> tagSearchFromTextToTagRankings(TagSearchFromTextReqDto reqDto);
  Future<FBallTagWrap> tagFromBallUuid(TagFromBallReqDto reqDto);
}