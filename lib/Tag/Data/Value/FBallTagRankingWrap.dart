import 'package:forutonafront/Tag/Data/Value/TagRanking.dart';
import 'package:json_annotation/json_annotation.dart';

part 'FBallTagRankingWrap.g.dart';

@JsonSerializable()
class FBallTagRankingWrap {
  DateTime searchTime;
  List<TagRanking> contents;
  FBallTagRankingWrap();

  factory FBallTagRankingWrap.fromJson(Map<String, dynamic> json) => _$FBallTagRankingWrapFromJson(json);
  Map<String, dynamic> toJson() => _$FBallTagRankingWrapToJson(this);
}