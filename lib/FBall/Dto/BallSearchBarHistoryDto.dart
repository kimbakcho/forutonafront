
import 'package:forutonafront/FBall/Data/Value/BallSearchBarHistory.dart';
import 'package:json_annotation/json_annotation.dart';

part 'BallSearchBarHistoryDto.g.dart';

@JsonSerializable()
class BallSearchBarHistoryDto {
  String searchText;
  DateTime searchTime;

  BallSearchBarHistoryDto(this.searchText, this.searchTime);
  factory BallSearchBarHistoryDto.fromJson(Map<String, dynamic> json) => _$BallSearchBarHistoryDtoFromJson(json);
  Map<String, dynamic> toJson() => _$BallSearchBarHistoryDtoToJson(this);

  factory BallSearchBarHistoryDto.fromBallSearchBarHistory(BallSearchBarHistory ballSearchBarHistory){
    return BallSearchBarHistoryDto(ballSearchBarHistory.searchText, ballSearchBarHistory.searchTime);
  }

}