// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserBallResDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserBallResDto _$UserBallResDtoFromJson(Map<String, dynamic> json) {
  return UserBallResDto()
    ..fballResDto = json['fballResDto'] == null
        ? null
        : FBallResDto.fromJson(json['fballResDto'] as Map<String, dynamic>);
}

Map<String, dynamic> _$UserBallResDtoToJson(UserBallResDto instance) =>
    <String, dynamic>{
      'fballResDto': instance.fballResDto,
    };
