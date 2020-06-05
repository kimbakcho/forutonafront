// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FBallTagRankingWrap.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FBallTagRankingWrap _$FBallTagRankingWrapFromJson(Map<String, dynamic> json) {
  return FBallTagRankingWrap()
    ..searchTime = json['searchTime'] == null
        ? null
        : DateTime.parse(json['searchTime'] as String)
    ..contents = (json['contents'] as List)
        ?.map((e) =>
            e == null ? null : TagRanking.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$FBallTagRankingWrapToJson(
        FBallTagRankingWrap instance) =>
    <String, dynamic>{
      'searchTime': instance.searchTime?.toIso8601String(),
      'contents': instance.contents,
    };
