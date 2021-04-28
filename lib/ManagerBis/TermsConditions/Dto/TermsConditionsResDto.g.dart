// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TermsConditionsResDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TermsConditionsResDto _$TermsConditionsResDtoFromJson(
    Map<String, dynamic> json) {
  return TermsConditionsResDto()
    ..idx = json['idx'] as int?
    ..termsName = json['termsName'] as String?
    ..termsContent = json['termsContent'] as String?
    ..modifyDate = json['modifyDate'] == null
        ? null
        : DateTime.parse(json['modifyDate'] as String)
    ..modifyUser = json['modifyUser'] == null
        ? null
        : MUserInfoResDto.fromJson(json['modifyUser'] as Map<String, dynamic>);
}

Map<String, dynamic> _$TermsConditionsResDtoToJson(
        TermsConditionsResDto instance) =>
    <String, dynamic>{
      'idx': instance.idx,
      'termsName': instance.termsName,
      'termsContent': instance.termsContent,
      'modifyDate': instance.modifyDate?.toIso8601String(),
      'modifyUser': instance.modifyUser,
    };
