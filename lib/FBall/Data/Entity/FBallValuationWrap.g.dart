// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FBallValuationWrap.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FBallValuationWrap _$FBallValuationWrapFromJson(Map<String, dynamic> json) {
  return FBallValuationWrap()
    ..count = json['count'] as int
    ..contents = (json['contents'] as List)
        ?.map((e) => e == null
            ? null
            : FBallValuation.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$FBallValuationWrapToJson(FBallValuationWrap instance) =>
    <String, dynamic>{
      'count': instance.count,
      'contents': instance.contents,
    };
