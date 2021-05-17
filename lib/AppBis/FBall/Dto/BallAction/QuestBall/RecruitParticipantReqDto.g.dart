// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'RecruitParticipantReqDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecruitParticipantReqDto _$RecruitParticipantReqDtoFromJson(
    Map<String, dynamic> json) {
  return RecruitParticipantReqDto()
    ..ballUuid = json['ballUuid'] as String?
    ..qualifyingForQuestText = json['qualifyingForQuestText'] as String?;
}

Map<String, dynamic> _$RecruitParticipantReqDtoToJson(
        RecruitParticipantReqDto instance) =>
    <String, dynamic>{
      'ballUuid': instance.ballUuid,
      'qualifyingForQuestText': instance.qualifyingForQuestText,
    };
