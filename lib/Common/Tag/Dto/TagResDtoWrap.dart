import 'package:json_annotation/json_annotation.dart';

import 'TagResDto.dart';

part 'TagResDtoWrap.g.dart';

@JsonSerializable()
class TagResDtoWrap {
  int totalCount;
  List<TagResDto> tags;

  TagResDtoWrap();

  factory TagResDtoWrap.fromJson(Map<String, dynamic> json) => _$TagResDtoWrapFromJson(json);
  Map<String, dynamic> toJson() => _$TagResDtoWrapToJson(this);

}