
import 'package:json_annotation/json_annotation.dart';

part 'AddressSearchHistory.g.dart';

@JsonSerializable()
class AddressSearchHistory {
  String searchText;
  DateTime searchTime;
  AddressSearchHistory({this.searchText,this.searchTime});

  factory AddressSearchHistory.fromJson(Map<String, dynamic> json) => _$AddressSearchHistoryFromJson(json);
  Map<String, dynamic> toJson() => _$AddressSearchHistoryToJson(this);

}