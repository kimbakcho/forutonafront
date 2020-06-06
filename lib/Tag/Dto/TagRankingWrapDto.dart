
import 'package:json_annotation/json_annotation.dart';

import 'TagRankingDto.dart';

part 'TagRankingWrapDto.g.dart';

@JsonSerializable()
class TagRankingWrapDto {

  DateTime searchTime;
  List<TagRankingDto> contents;

  factory TagRankingWrapDto.fromJson(Map<String, dynamic> json) => _$TagRankingWrapDtoFromJson(json);
  Map<String, dynamic> toJson() => _$TagRankingWrapDtoToJson(this);

  TagRankingWrapDto(this.searchTime, this.contents);
}