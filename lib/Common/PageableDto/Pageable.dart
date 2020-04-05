import 'package:json_annotation/json_annotation.dart';

part 'Pageable.g.dart';

@JsonSerializable()
class Pageable{

  int page = 0;
  int size = 10;
  List<List<String>> sort = new List<List<String>>();

  Pageable(this.page, this.size, this.sort);


  factory Pageable.fromJson(Map<String, dynamic> json) => _$PageableFromJson(json);
  Map<String, dynamic> toJson() => _$PageableToJson(this);
}