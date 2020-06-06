
import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import 'MultiSort.dart';

part 'MultiSorts.g.dart';


 ///Spring Backend 는 아래와 같이 Controller에서 푼다.
 ///@RequestParam MultiSorts sorts
 ///BackEnd에 보낼때는 toQureyJson() 메소드를 이용하여 String을 보내어준다.
 ///이후 BackEnd 에서 Json을 맵핑 하여 사용하도록 한다.
@JsonSerializable(explicitToJson: true)
class MultiSorts {

  List<MultiSort> sorts;

  factory MultiSorts.fromJson(Map<String, dynamic> json) => _$MultiSortsFromJson(json);
  Map<String, dynamic> toJson() => _$MultiSortsToJson(this);

  String toQueryJson(){
    return json.encode(this);
  }

  MultiSorts(this.sorts);
}