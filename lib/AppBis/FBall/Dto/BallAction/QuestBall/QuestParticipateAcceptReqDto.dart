
import 'package:json_annotation/json_annotation.dart';

part 'QuestParticipateAcceptReqDto.g.dart';

@JsonSerializable()
class QuestParticipateAcceptReqDto {
  String? ballUuid;
  String? uid;

  QuestParticipateAcceptReqDto();

  factory QuestParticipateAcceptReqDto.fromJson(Map<String, dynamic> json) => _$QuestParticipateAcceptReqDtoFromJson(json);
  Map<String, dynamic> toJson() => _$QuestParticipateAcceptReqDtoToJson(this);
}