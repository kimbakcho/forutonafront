// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserToMakerBallResDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserToMakerBallResDto _$UserToMakerBallResDtoFromJson(
    Map<String, dynamic> json) {
  return UserToMakerBallResDto()
    ..fballResDto = json['fballResDto'] == null
        ? null
        : FBallResDto.fromJson(json['fballResDto'] as Map<String, dynamic>);
}

Map<String, dynamic> _$UserToMakerBallResDtoToJson(
        UserToMakerBallResDto instance) =>
    <String, dynamic>{
      'fballResDto': instance.fballResDto,
    };
