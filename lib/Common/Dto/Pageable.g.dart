// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Pageable.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pageable _$PageableFromJson(Map<String, dynamic> json) {
  return Pageable(
    json['page'] as int,
    json['size'] as int,
    (json['sort'] as List)
        ?.map((e) => (e as List)?.map((e) => e as String)?.toList())
        ?.toList(),
  );
}

Map<String, dynamic> _$PageableToJson(Pageable instance) => <String, dynamic>{
      'page': instance.page,
      'size': instance.size,
      'sort': instance.sort,
    };
