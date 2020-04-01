// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FBallDescirptionBasic.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FBallDescirptionBasic _$FBallDescirptionBasicFromJson(
    Map<String, dynamic> json) {
  return FBallDescirptionBasic()
    ..text = json['text'] as String
    ..desimages = (json['desimages'] as List)
        ?.map((e) => e == null
            ? null
            : FBallDesImagesDto.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$FBallDescirptionBasicToJson(
        FBallDescirptionBasic instance) =>
    <String, dynamic>{
      'text': instance.text,
      'desimages': instance.desimages,
    };
