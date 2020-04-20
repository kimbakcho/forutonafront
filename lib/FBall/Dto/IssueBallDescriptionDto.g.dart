// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'IssueBallDescriptionDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IssueBallDescriptionDto _$IssueBallDescriptionDtoFromJson(
    Map<String, dynamic> json) {
  return IssueBallDescriptionDto()
    ..text = json['text'] as String
    ..desimages = (json['desimages'] as List)
        ?.map((e) => e == null
            ? null
            : FBallDesImagesDto.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..youtubeVideoId = json['youtubeVideoId'] as String;
}

Map<String, dynamic> _$IssueBallDescriptionDtoToJson(
        IssueBallDescriptionDto instance) =>
    <String, dynamic>{
      'text': instance.text,
      'desimages': instance.desimages?.map((e) => e?.toJson())?.toList(),
      'youtubeVideoId': instance.youtubeVideoId,
    };
