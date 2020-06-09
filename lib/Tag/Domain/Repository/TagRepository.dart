import 'package:forutonafront/Tag/Data/Entity/FBallTagWrap.dart';
import 'package:forutonafront/Tag/Data/Value/FBallTagRankingWrap.dart';
import 'package:forutonafront/Tag/Dto/RelationTagRankingFromTagNameReqDto.dart';
import 'package:forutonafront/Tag/Dto/TagFromBallReqDto.dart';
import 'package:forutonafront/Tag/Dto/TagRankingFromBallInfluencePowerReqDto.dart';


abstract class  TagRepository {
  Future<FBallTagRankingWrap> getFTagRankingFromBallInfluencePower(TagRankingFromBallInfluencePowerReqDto reqDto);
  Future<FBallTagRankingWrap> getRelationTagRankingFromTagNameOrderByBallPower(RelationTagRankingFromTagNameReqDto reqDto);
  Future<FBallTagWrap> tagFromBallUuid(TagFromBallReqDto reqDto);
}