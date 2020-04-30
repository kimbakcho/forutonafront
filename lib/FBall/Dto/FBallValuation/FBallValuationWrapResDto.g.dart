// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FBallValuationWrapResDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FBallValuationWrapResDto _$FBallValuationWrapResDtoFromJson(
    Map<String, dynamic> json) {
  return FBallValuationWrapResDto()
    ..count = json['count'] as int
    ..contents = (json['contents'] as List)
        ?.map((e) => e == null
            ? null
            : FBallValuationResDto.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$FBallValuationWrapResDtoToJson(
        FBallValuationWrapResDto instance) =>
    <String, dynamic>{
      'count': instance.count,
      'contents': instance.contents,
    };
