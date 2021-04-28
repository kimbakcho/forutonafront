// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'IssueBallDescription.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IssueBallDescription _$IssueBallDescriptionFromJson(Map<String, dynamic> json) {
  return IssueBallDescription()
    ..text = json['text'] as String?
    ..desimages = (json['desimages'] as List<dynamic>)
        .map((e) => FBallDesImages.fromJson(e as Map<String, dynamic>))
        .toList()
    ..youtubeVideoId = json['youtubeVideoId'] as String?;
}

Map<String, dynamic> _$IssueBallDescriptionToJson(
        IssueBallDescription instance) =>
    <String, dynamic>{
      'text': instance.text,
      'desimages': instance.desimages,
      'youtubeVideoId': instance.youtubeVideoId,
    };
