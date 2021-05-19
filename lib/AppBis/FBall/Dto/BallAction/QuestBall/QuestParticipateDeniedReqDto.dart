
import 'package:json_annotation/json_annotation.dart';

part 'QuestParticipateDeniedReqDto.g.dart';

@JsonSerializable()
class QuestParticipateDeniedReqDto {

  String? ballUuid;

  String? uid;

  QuestParticipateDeniedReqDto();

  factory QuestParticipateDeniedReqDto.fromJson(Map<String, dynamic> json) => _$QuestParticipateDeniedReqDtoFromJson(json);
  Map<String, dynamic> toJson() => _$QuestParticipateDeniedReqDtoToJson(this);
}