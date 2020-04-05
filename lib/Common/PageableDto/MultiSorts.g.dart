// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MultiSorts.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MultiSorts _$MultiSortsFromJson(Map<String, dynamic> json) {
  return MultiSorts(
    (json['sorts'] as List)
        ?.map((e) =>
            e == null ? null : MultiSort.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$MultiSortsToJson(MultiSorts instance) =>
    <String, dynamic>{
      'sorts': instance.sorts?.map((e) => e?.toJson())?.toList(),
    };
