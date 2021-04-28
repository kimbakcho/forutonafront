
import 'package:json_annotation/json_annotation.dart';

part 'TagRankingFromTextReqDto.g.dart';

@JsonSerializable()
class TagRankingFromTextReqDto {
  String? searchTagText;
  double? mapCenterLatitude;
  double? mapCenterLongitude;

  TagRankingFromTextReqDto();

  factory TagRankingFromTextReqDto.fromJson(Map<String, dynamic> json) => _$TagRankingFromTextReqDtoFromJson(json);
  Map<String, dynamic> toJson() => _$TagRankingFromTextReqDtoToJson(this);
}