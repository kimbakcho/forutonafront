// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FBallImageUploadResDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FBallImageUploadResDto _$FBallImageUploadResDtoFromJson(
    Map<String, dynamic> json) {
  return FBallImageUploadResDto()
    ..count = json['count'] as int
    ..urls = (json['urls'] as List)?.map((e) => e as String)?.toList();
}

Map<String, dynamic> _$FBallImageUploadResDtoToJson(
        FBallImageUploadResDto instance) =>
    <String, dynamic>{
      'count': instance.count,
      'urls': instance.urls,
    };
