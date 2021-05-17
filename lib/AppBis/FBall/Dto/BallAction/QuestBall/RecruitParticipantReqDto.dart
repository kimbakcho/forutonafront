
import 'package:json_annotation/json_annotation.dart';

part 'RecruitParticipantReqDto.g.dart';

@JsonSerializable()
class RecruitParticipantReqDto {
  String? ballUuid;
  String? qualifyingForQuestText;

  RecruitParticipantReqDto();

  factory RecruitParticipantReqDto.fromJson(Map<String, dynamic> json) => _$RecruitParticipantReqDtoFromJson(json);
  Map<String, dynamic> toJson() => _$RecruitParticipantReqDtoToJson(this);
}