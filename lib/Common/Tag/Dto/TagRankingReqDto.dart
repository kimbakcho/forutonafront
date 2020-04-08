

import 'package:json_annotation/json_annotation.dart';

part 'TagRankingReqDto.g.dart';


@JsonSerializable()
class TagRankingReqDto {
  double latitude;
  double longitude;
  int limit;

  TagRankingReqDto(this.latitude, this.longitude, this.limit);

  factory TagRankingReqDto.fromJson(Map<String, dynamic> json) => _$TagRankingReqDtoFromJson(json);
  Map<String, dynamic> toJson() => _$TagRankingReqDtoToJson(this);
}