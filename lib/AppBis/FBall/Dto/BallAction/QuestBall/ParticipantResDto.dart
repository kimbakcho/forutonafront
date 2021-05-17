
import 'package:json_annotation/json_annotation.dart';

part 'ParticipantResDto.g.dart';

@JsonSerializable()
class ParticipantResDto {
  String? ballUuid;
  String? makerUid;
  bool? success;

  ParticipantResDto();

  factory ParticipantResDto.fromJson(Map<String, dynamic> json) => _$ParticipantResDtoFromJson(json);
  Map<String, dynamic> toJson() => _$ParticipantResDtoToJson(this);

}