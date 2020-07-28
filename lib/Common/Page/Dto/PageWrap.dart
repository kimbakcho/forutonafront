
import 'package:json_annotation/json_annotation.dart';

part 'PageWrap.g.dart';

@JsonSerializable()
class PageWrap<T> {
  PageWrap();
  @JsonKey(fromJson: _dataFromJson, toJson: _dataToJson)
  List<T> contents;

  factory PageWrap.fromJson(Map<String, dynamic> json) => _$PageFromJson(json);
  Map<String, dynamic> toJson() => _$PageToJson(this);

}
T _dataFromJson<T>(Map<String, dynamic> input) {
  return input['data'] as T;
}

Map<String, dynamic> _dataToJson<T>(T input) =>
    {'value': input};