
import 'package:json_annotation/json_annotation.dart';
part 'FBallListUpFromBallInfluencePowerReqDto.g.dart';

@JsonSerializable()
class FBallListUpFromBallInfluencePowerReqDto {

  final double latitude;
  final double longitude;

  FBallListUpFromBallInfluencePowerReqDto({this.latitude = 37.508797, this.longitude = 126.890605});

  factory FBallListUpFromBallInfluencePowerReqDto.fromJson(Map<String, dynamic> json) => _$FBallListUpFromBallInfluencePowerReqDtoFromJson(json);
  Map<String, dynamic> toJson() => _$FBallListUpFromBallInfluencePowerReqDtoToJson(this);

}