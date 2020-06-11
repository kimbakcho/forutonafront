// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FSorts.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FSorts _$FSortsFromJson(Map<String, dynamic> json) {
  return FSorts()
    ..sorts = (json['sorts'] as List)
        ?.map(
            (e) => e == null ? null : FSort.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$FSortsToJson(FSorts instance) => <String, dynamic>{
      'sorts': instance.sorts?.map((e) => e?.toJson())?.toList(),
    };
