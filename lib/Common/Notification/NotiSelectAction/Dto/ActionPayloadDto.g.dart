// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ActionPayloadDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActionPayloadDto _$ActionPayloadDtoFromJson(Map<String, dynamic> json) {
  return ActionPayloadDto()
    ..commandKey = json['commandKey'] as String
    ..serviceKey = json['serviceKey'] as String
    ..payload = json['payload'] as String;
}

Map<String, dynamic> _$ActionPayloadDtoToJson(ActionPayloadDto instance) =>
    <String, dynamic>{
      'commandKey': instance.commandKey,
      'serviceKey': instance.serviceKey,
      'payload': instance.payload,
    };
