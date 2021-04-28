// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MaliciousBallResDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MaliciousBallResDto _$MaliciousBallResDtoFromJson(Map<String, dynamic> json) {
  return MaliciousBallResDto()
    ..idx = json['idx'] as int?
    ..ballUuid = json['ballUuid'] as String?
    ..totalNumberReports = json['totalNumberReports'] as int?
    ..crime = json['crime'] as int?
    ..abuse = json['abuse'] as int?
    ..privacy = json['privacy'] as int?
    ..sexual = json['sexual'] as int?
    ..advertising = json['advertising'] as int?
    ..etc = json['etc'] as int?
    ..maliciousContentFlag = json['maliciousContentFlag'] as bool?
    ..falseReportFlag = json['falseReportFlag'] as bool?
    ..judgmentTime = json['judgmentTime'] == null
        ? null
        : DateTime.parse(json['judgmentTime'] as String)
    ..judgmentUid = json['judgmentUid'] == null
        ? null
        : MUserInfoResDto.fromJson(json['judgmentUid'] as Map<String, dynamic>);
}

Map<String, dynamic> _$MaliciousBallResDtoToJson(
        MaliciousBallResDto instance) =>
    <String, dynamic>{
      'idx': instance.idx,
      'ballUuid': instance.ballUuid,
      'totalNumberReports': instance.totalNumberReports,
      'crime': instance.crime,
      'abuse': instance.abuse,
      'privacy': instance.privacy,
      'sexual': instance.sexual,
      'advertising': instance.advertising,
      'etc': instance.etc,
      'maliciousContentFlag': instance.maliciousContentFlag,
      'falseReportFlag': instance.falseReportFlag,
      'judgmentTime': instance.judgmentTime?.toIso8601String(),
      'judgmentUid': instance.judgmentUid,
    };
