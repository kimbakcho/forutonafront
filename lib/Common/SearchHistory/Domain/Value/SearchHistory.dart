
import 'package:json_annotation/json_annotation.dart';

part 'SearchHistory.g.dart';

@JsonSerializable()
class SearchHistory {
  String? searchText;
  DateTime? searchTime;
  SearchHistory({this.searchText,this.searchTime});

  factory SearchHistory.fromJson(Map<String, dynamic> json) => _$SearchHistoryFromJson(json);
  Map<String, dynamic> toJson() => _$SearchHistoryToJson(this);

}