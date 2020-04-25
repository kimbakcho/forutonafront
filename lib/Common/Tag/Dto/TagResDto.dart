import 'package:json_annotation/json_annotation.dart';

part 'TagResDto.g.dart';

@JsonSerializable()
class TagResDto {
  String ballUuid;
  String tagItem;

  TagResDto();

  factory TagResDto.fromJson(Map<String, dynamic> json) => _$TagResDtoFromJson(json);
  Map<String, dynamic> toJson() => _$TagResDtoToJson(this);
}