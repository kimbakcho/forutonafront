// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TagInsertReqDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TagInsertReqDto _$TagInsertReqDtoFromJson(Map<String, dynamic> json) {
  return TagInsertReqDto(
    json['ballUuid'] as String,
    json['tagItem'] as String,
  );
}

Map<String, dynamic> _$TagInsertReqDtoToJson(TagInsertReqDto instance) =>
    <String, dynamic>{
      'ballUuid': instance.ballUuid,
      'tagItem': instance.tagItem,
    };
