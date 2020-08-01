import 'package:flutter/cupertino.dart';
import 'package:forutonafront/FBall/Dto/BallSearchBarHistoryDto.dart';

import 'package:json_annotation/json_annotation.dart';

part 'BallSearchBarHistory.g.dart';

@JsonSerializable()
class BallSearchBarHistory {
  String searchText;
  DateTime searchTime;

  BallSearchBarHistory({@required this.searchText,@required this.searchTime});
  factory BallSearchBarHistory.fromJson(Map<String, dynamic> json) => _$BallSearchBarHistoryFromJson(json);
  Map<String, dynamic> toJson() => _$BallSearchBarHistoryToJson(this);
  factory BallSearchBarHistory.fromBallSearchBarHistoryDto(BallSearchBarHistoryDto ballSearchBarHistoryDto){
    return BallSearchBarHistory(searchText: ballSearchBarHistoryDto.searchText, searchTime: ballSearchBarHistoryDto.searchTime);
  }
}