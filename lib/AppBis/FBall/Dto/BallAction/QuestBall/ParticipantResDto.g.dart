// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ParticipantResDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParticipantResDto _$ParticipantResDtoFromJson(Map<String, dynamic> json) {
  return ParticipantResDto()
    ..ballUuid = json['ballUuid'] as String?
    ..makerUid = json['makerUid'] as String?
    ..success = json['success'] as bool?;
}

Map<String, dynamic> _$ParticipantResDtoToJson(ParticipantResDto instance) =>
    <String, dynamic>{
      'ballUuid': instance.ballUuid,
      'makerUid': instance.makerUid,
      'success': instance.success,
    };
