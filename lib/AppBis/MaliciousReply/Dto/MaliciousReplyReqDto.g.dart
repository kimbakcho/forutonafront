// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MaliciousReplyReqDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MaliciousReplyReqDto _$MaliciousReplyReqDtoFromJson(Map<String, dynamic> json) {
  return MaliciousReplyReqDto()
    ..replyUuid = json['replyUuid'] as String?
    ..crime = json['crime'] as int?
    ..abuse = json['abuse'] as int?
    ..privacy = json['privacy'] as int?
    ..sexual = json['sexual'] as int?
    ..advertising = json['advertising'] as int?
    ..etc = json['etc'] as int?;
}

Map<String, dynamic> _$MaliciousReplyReqDtoToJson(
        MaliciousReplyReqDto instance) =>
    <String, dynamic>{
      'replyUuid': instance.replyUuid,
      'crime': instance.crime,
      'abuse': instance.abuse,
      'privacy': instance.privacy,
      'sexual': instance.sexual,
      'advertising': instance.advertising,
      'etc': instance.etc,
    };
