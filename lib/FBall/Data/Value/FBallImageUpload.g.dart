// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FBallImageUpload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FBallImageUpload _$FBallImageUploadFromJson(Map<String, dynamic> json) {
  return FBallImageUpload()
    ..count = json['count'] as int
    ..urls = (json['urls'] as List)?.map((e) => e as String)?.toList();
}

Map<String, dynamic> _$FBallImageUploadToJson(FBallImageUpload instance) =>
    <String, dynamic>{
      'count': instance.count,
      'urls': instance.urls,
    };
