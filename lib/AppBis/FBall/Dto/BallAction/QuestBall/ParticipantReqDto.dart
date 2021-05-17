
import 'package:json_annotation/json_annotation.dart';

part 'ParticipantReqDto.g.dart';

@JsonSerializable()
class ParticipantReqDto {
  String? ballUuid;

  ParticipantReqDto();

  factory ParticipantReqDto.fromJson(Map<String, dynamic> json) => _$ParticipantReqDtoFromJson(json);
  Map<String, dynamic> toJson() => _$ParticipantReqDtoToJson(this);

}