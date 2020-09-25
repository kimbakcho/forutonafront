import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'TagRankingFromBallInfluencePowerReqDto.g.dart';

@JsonSerializable()
class TagRankingFromBallInfluencePowerReqDto {
  double mapCenterLatitude;
  double mapCenterLongitude;

  TagRankingFromBallInfluencePowerReqDto(
      {@required this.mapCenterLatitude, @required this.mapCenterLongitude});

  factory TagRankingFromBallInfluencePowerReqDto.fromJson(
          Map<String, dynamic> json) =>
      _$TagRankingFromBallInfluencePowerReqDtoFromJson(json);

  Map<String, dynamic> toJson() =>
      _$TagRankingFromBallInfluencePowerReqDtoToJson(this);
}
