
import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import 'MultiSort.dart';

part 'MultiSorts.g.dart';

@JsonSerializable(explicitToJson: true)
class MultiSorts {

  List<MultiSort> sorts;

  factory MultiSorts.fromJson(Map<String, dynamic> json) => _$MultiSortsFromJson(json);
  Map<String, dynamic> toJson() => _$MultiSortsToJson(this);

  String toQureyJson(){
    return json.encode(this);
  }

  MultiSorts(this.sorts);
}