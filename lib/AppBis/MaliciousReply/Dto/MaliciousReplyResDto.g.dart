// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MaliciousReplyResDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MaliciousReplyResDto _$MaliciousReplyResDtoFromJson(Map<String, dynamic> json) {
  return MaliciousReplyResDto()
    ..idx = json['idx'] as int?
    ..replyUuid = json['replyUuid'] as String?
    ..crime = json['crime'] as int?
    ..abuse = json['abuse'] as int?
    ..privacy = json['privacy'] as int?
    ..sexual = json['sexual'] as int?
    ..advertising = json['advertising'] as int?
    ..etc = json['etc'] as int?
    ..totalNumberReports = json['totalNumberReports'] as int?
    ..maliciousContentFlag = json['maliciousContentFlag'] as bool?
    ..falseReportFlag = json['falseReportFlag'] as bool?
    ..judgmentTime = json['judgmentTime'] == null
        ? null
        : DateTime.parse(json['judgmentTime'] as String);
}

Map<String, dynamic> _$MaliciousReplyResDtoToJson(
        MaliciousReplyResDto instance) =>
    <String, dynamic>{
      'idx': instance.idx,
      'replyUuid': instance.replyUuid,
      'crime': instance.crime,
      'abuse': instance.abuse,
      'privacy': instance.privacy,
      'sexual': instance.sexual,
      'advertising': instance.advertising,
      'etc': instance.etc,
      'totalNumberReports': instance.totalNumberReports,
      'maliciousContentFlag': instance.maliciousContentFlag,
      'falseReportFlag': instance.falseReportFlag,
      'judgmentTime': instance.judgmentTime?.toIso8601String(),
    };
