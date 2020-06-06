
import 'package:forutonafront/Tag/Data/Value/TagRanking.dart';
import 'package:json_annotation/json_annotation.dart';

part 'TagRankingDto.g.dart';

@JsonSerializable()
class TagRankingDto {
  int ranking;
  String tagName;
  double tagPower;
  int tagBallPower;

  TagRankingDto();

  factory TagRankingDto.fromJson(Map<String, dynamic> json) => _$TagRankingDtoFromJson(json);
  Map<String, dynamic> toJson() => _$TagRankingDtoToJson(this);

  factory TagRankingDto.fromTagRanking(TagRanking item){
    var tagRankingDto = TagRankingDto();
    tagRankingDto.ranking = item.ranking;
    tagRankingDto.tagName = item.tagName;
    tagRankingDto.tagPower = item.tagPower;
    tagRankingDto.tagBallPower = item.tagBallPower;
    return tagRankingDto;
  }
}