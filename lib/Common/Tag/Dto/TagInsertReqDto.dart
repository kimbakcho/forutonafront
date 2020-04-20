
import 'package:json_annotation/json_annotation.dart';

part 'TagInsertReqDto.g.dart';

@JsonSerializable()
class TagInsertReqDto {
  String ballUuid;
  String tagItem;

  TagInsertReqDto(this.ballUuid, this.tagItem);


  factory TagInsertReqDto.fromJson(Map<String, dynamic> json) => _$TagInsertReqDtoFromJson(json);
  Map<String, dynamic> toJson() => _$TagInsertReqDtoToJson(this);

}