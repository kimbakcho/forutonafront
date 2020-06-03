import 'package:json_annotation/json_annotation.dart';

part 'TagRanking.g.dart';

@JsonSerializable()
class TagRanking {
  int ranking;
  String tagName;
  double tagPower;
  int tagBallPower;

  TagRanking(this.ranking, this.tagName, this.tagPower);

  factory TagRanking.fromJson(Map<String, dynamic> json) => _$TagRankingFromJson(json);
  Map<String, dynamic> toJson() => _$TagRankingToJson(this);
}