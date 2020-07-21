
import 'package:json_annotation/json_annotation.dart';

part 'ActionPayloadDto.g.dart';
@JsonSerializable()
class ActionPayloadDto {
  String commandKey;
  String serviceKey;
  String payload;
  ActionPayloadDto();
  factory ActionPayloadDto.fromJson(Map<String, dynamic> json) => _$ActionPayloadDtoFromJson(json);
  Map<String, dynamic> toJson() => _$ActionPayloadDtoToJson(this);
}