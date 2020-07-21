import 'package:json_annotation/json_annotation.dart';

part 'ID001PayloadDto.g.dart';
@JsonSerializable()
class ID001PayloadDto {
  String ballUuid;
  ID001PayloadDto();
  factory ID001PayloadDto.fromJson(Map<String, dynamic> json) => _$ID001PayloadDtoFromJson(json);
  Map<String, dynamic> toJson() => _$ID001PayloadDtoToJson(this);
}