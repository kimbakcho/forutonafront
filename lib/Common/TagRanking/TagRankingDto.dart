
import 'package:json_annotation/json_annotation.dart';

part 'TagRankingDto.g.dart';

@JsonSerializable()
class TagRankingDto {
  int ranking;
  String tagName;
  double tagPower;

  TagRankingDto(this.ranking, this.tagName, this.tagPower);

  factory TagRankingDto.fromJson(Map<String, dynamic> json) => _$TagRankingDtoFromJson(json);
  Map<String, dynamic> toJson() => _$TagRankingDtoToJson(this);
}