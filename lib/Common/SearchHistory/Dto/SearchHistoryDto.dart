import 'package:forutonafront/Common/SearchHistory/Domain/Value/SearchHistory.dart';
import 'package:json_annotation/json_annotation.dart';

part 'SearchHistoryDto.g.dart';

@JsonSerializable()
class SearchHistoryDto {
  String? searchText;
  DateTime? searchTime;

  SearchHistoryDto({this.searchText, this.searchTime});

  factory SearchHistoryDto.fromJson(Map<String, dynamic> json) =>
      _$SearchHistoryDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SearchHistoryDtoToJson(this);

  factory SearchHistoryDto.fromSearchHistory(
      SearchHistory item) {
    SearchHistoryDto result = SearchHistoryDto();
    result.searchText = item.searchText;
    result.searchTime = item.searchTime;
    return result;
  }
}
