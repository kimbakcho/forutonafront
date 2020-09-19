import 'package:json_annotation/json_annotation.dart';

part 'FBallListUpFromBIReqDto.g.dart';

@JsonSerializable()
class FBallListUpFromBIReqDto {
  final double userLatitude;
  final double userLongitude;
  final double mapCenterLatitude;
  final double mapCenterLongitude;

  FBallListUpFromBIReqDto(
      {this.userLongitude = 126.890605,
      this.userLatitude = 37.508797,
      this.mapCenterLatitude = 37.508797,
      this.mapCenterLongitude = 126.890605});

  factory FBallListUpFromBIReqDto.fromJson(Map<String, dynamic> json) =>
      _$FBallListUpFromBIReqDtoFromJson(json);

  Map<String, dynamic> toJson() => _$FBallListUpFromBIReqDtoToJson(this);
}
