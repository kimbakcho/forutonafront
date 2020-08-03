
import 'package:json_annotation/json_annotation.dart';

part 'TagRankingResDto.g.dart';

@JsonSerializable()
class TagRankingResDto {
  int ranking;
  String tagName;
  double tagPower;
  int tagBallPower;

  TagRankingResDto();

  factory TagRankingResDto.fromJson(Map<String, dynamic> json) => _$TagRankingResDtoFromJson(json);
  Map<String, dynamic> toJson() => _$TagRankingResDtoToJson(this);

}