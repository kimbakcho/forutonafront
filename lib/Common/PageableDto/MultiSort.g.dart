// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MultiSort.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MultiSort _$MultiSortFromJson(Map<String, dynamic> json) {
  return MultiSort(
    json['sort'] as String,
    _$enumDecodeNullable(_$QueryOrdersEnumMap, json['order']),
  );
}

Map<String, dynamic> _$MultiSortToJson(MultiSort instance) => <String, dynamic>{
      'sort': instance.sort,
      'order': _$QueryOrdersEnumMap[instance.order],
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$QueryOrdersEnumMap = {
  QueryOrders.ASC: 'ASC',
  QueryOrders.DESC: 'DESC',
};
