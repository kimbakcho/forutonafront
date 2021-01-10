// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserAlarmConfigUpdateReqDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserAlarmConfigUpdateReqDto _$UserAlarmConfigUpdateReqDtoFromJson(
    Map<String, dynamic> json) {
  return UserAlarmConfigUpdateReqDto()
    ..alarmChatMessage = json['alarmChatMessage'] as bool
    ..alarmContentReply = json['alarmContentReply'] as bool
    ..alarmReplyAndReply = json['alarmReplyAndReply'] as bool
    ..alarmFollowNewContent = json['alarmFollowNewContent'] as bool
    ..alarmSponNewContent = json['alarmSponNewContent'] as bool;
}

Map<String, dynamic> _$UserAlarmConfigUpdateReqDtoToJson(
        UserAlarmConfigUpdateReqDto instance) =>
    <String, dynamic>{
      'alarmChatMessage': instance.alarmChatMessage,
      'alarmContentReply': instance.alarmContentReply,
      'alarmReplyAndReply': instance.alarmReplyAndReply,
      'alarmFollowNewContent': instance.alarmFollowNewContent,
      'alarmSponNewContent': instance.alarmSponNewContent,
    };
