

import 'package:forutonafront/Common/PageableDto/QueryOrders.dart';
import 'package:json_annotation/json_annotation.dart';

part 'FSort.g.dart';

@JsonSerializable(explicitToJson: true)
class FSort {

  String sort;
  QueryOrders order;

  FSort(this.sort, this.order);

  factory FSort.fromJson(Map<String, dynamic> json) => _$FSortFromJson(json);
  Map<String, dynamic> toJson() => _$FSortToJson(this);




}