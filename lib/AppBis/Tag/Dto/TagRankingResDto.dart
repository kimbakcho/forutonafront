
import 'package:json_annotation/json_annotation.dart';

part 'TagRankingResDto.g.dart';

@JsonSerializable()
class TagRankingResDto {
  String? tagName;
  double? tagPower;

  TagRankingResDto();

  factory TagRankingResDto.fromJson(Map<String, dynamic> json) => _$TagRankingResDtoFromJson(json);
  Map<String, dynamic> toJson() => _$TagRankingResDtoToJson(this);

}