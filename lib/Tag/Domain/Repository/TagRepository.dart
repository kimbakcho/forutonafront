import 'package:forutonafront/Tag/Dto/FBallTagResDto.dart';
import 'package:forutonafront/Tag/Dto/TagRankingFromBallInfluencePowerReqDto.dart';
import 'package:forutonafront/Tag/Dto/TagRankingResDto.dart';


abstract class  TagRepository {
  Future<List<TagRankingResDto>> getFTagRankingFromBallInfluencePower(TagRankingFromBallInfluencePowerReqDto reqDto);
  Future<List<TagRankingResDto>> getRelationTagRankingFromTagNameOrderByBallPower(String searchTag);
  Future<List<FBallTagResDto>> tagFromBallUuid(String ballUuid);
}