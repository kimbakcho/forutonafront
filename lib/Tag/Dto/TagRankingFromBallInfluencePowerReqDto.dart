import 'package:json_annotation/json_annotation.dart';

part 'TagRankingFromBallInfluencePowerReqDto.g.dart';

@JsonSerializable()
class TagRankingFromBallInfluencePowerReqDto {
  double latitude;
  double longitude;
  int limit;

  TagRankingFromBallInfluencePowerReqDto(
      {this.latitude, this.longitude, this.limit})
      : assert(limit != null);

  factory TagRankingFromBallInfluencePowerReqDto.fromJson(
          Map<String, dynamic> json) =>
      _$TagRankingFromBallInfluencePowerReqDtoFromJson(json);

  Map<String, dynamic> toJson() =>
      _$TagRankingFromBallInfluencePowerReqDtoToJson(this);
}
