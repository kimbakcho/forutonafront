import 'package:forutonafront/Common/AddressSearchHistory/Domain/Value/AddressSearchHistory.dart';
import 'package:json_annotation/json_annotation.dart';

part 'AddressSearchHistoryDto.g.dart';

@JsonSerializable()
class AddressSearchHistoryDto {
  String searchText;
  DateTime searchTime;

  AddressSearchHistoryDto({this.searchText, this.searchTime});

  factory AddressSearchHistoryDto.fromJson(Map<String, dynamic> json) =>
      _$AddressSearchHistoryDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AddressSearchHistoryDtoToJson(this);

  factory AddressSearchHistoryDto.fromAddressSearchHistory(
      AddressSearchHistory item) {
    AddressSearchHistoryDto result = AddressSearchHistoryDto();
    result.searchText = item.searchText;
    result.searchTime = item.searchTime;
    return result;
  }
}
