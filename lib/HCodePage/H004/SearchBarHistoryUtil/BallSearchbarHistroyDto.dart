
import 'package:json_annotation/json_annotation.dart';

part 'BallSearchbarHistroyDto.g.dart';

@JsonSerializable()
class BallSearchbarHistroyDto {
  String searchText;
  DateTime searchTime;

  BallSearchbarHistroyDto(this.searchText, this.searchTime);
  factory BallSearchbarHistroyDto.fromJson(Map<String, dynamic> json) => _$BallSearchbarHistroyDtoFromJson(json);
  Map<String, dynamic> toJson() => _$BallSearchbarHistroyDtoToJson(this);

}