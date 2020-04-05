

import 'package:forutonafront/Common/PageableDto/QueryOrders.dart';
import 'package:json_annotation/json_annotation.dart';

part 'MultiSort.g.dart';

@JsonSerializable(explicitToJson: true)
class MultiSort {

  String sort;
  QueryOrders order;

  MultiSort(this.sort, this.order);

  factory MultiSort.fromJson(Map<String, dynamic> json) => _$MultiSortFromJson(json);
  Map<String, dynamic> toJson() => _$MultiSortToJson(this);




}