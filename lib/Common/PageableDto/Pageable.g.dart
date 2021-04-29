// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Pageable.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pageable _$PageableFromJson(Map<String, dynamic> json) {
  return Pageable(
    page: json['page'] as int?,
    size: json['size'] as int?,
    sort: json['sort'] as String?,
  );
}

Map<String, dynamic> _$PageableToJson(Pageable instance) => <String, dynamic>{
      'page': instance.page,
      'size': instance.size,
      'sort': instance.sort,
    };
