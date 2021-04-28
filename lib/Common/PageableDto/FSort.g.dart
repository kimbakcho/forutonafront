// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FSort.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FSort _$FSortFromJson(Map<String, dynamic> json) {
  return FSort(
    json['sort'] as String,
    _$enumDecode(_$QueryOrdersEnumMap, json['order']),
  );
}

Map<String, dynamic> _$FSortToJson(FSort instance) => <String, dynamic>{
      'sort': instance.sort,
      'order': _$QueryOrdersEnumMap[instance.order],
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

const _$QueryOrdersEnumMap = {
  QueryOrders.ASC: 'ASC',
  QueryOrders.DESC: 'DESC',
};
