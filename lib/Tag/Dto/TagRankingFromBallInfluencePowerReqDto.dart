

import 'package:geolocator/geolocator.dart';
import 'package:json_annotation/json_annotation.dart';

part 'TagRankingFromBallInfluencePowerReqDto.g.dart';


@JsonSerializable()
class TagRankingFromBallInfluencePowerReqDto {
  double latitude;
  double longitude;
  int limit;

  TagRankingFromBallInfluencePowerReqDto({Position position, this.limit}){
    this.latitude = position.latitude;
    this.longitude = position.longitude;
  }

  factory TagRankingFromBallInfluencePowerReqDto.fromJson(Map<String, dynamic> json) => _$TagRankingFromBallInfluencePowerReqDtoFromJson(json);
  Map<String, dynamic> toJson() => _$TagRankingFromBallInfluencePowerReqDtoToJson(this);
}