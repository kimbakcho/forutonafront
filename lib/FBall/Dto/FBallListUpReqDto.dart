
import 'package:json_annotation/json_annotation.dart';
part 'FBallListUpReqDto.g.dart';

@JsonSerializable()
class FBallListUpReqDto {

  final double latitude;
  final double longitude;
  final int ballLimit;
  final int page;
  final int size;
  final String sort;


  FBallListUpReqDto({this.latitude, this.longitude, this.ballLimit, this.page,
      this.size, this.sort});

  factory FBallListUpReqDto.fromJson(Map<String, dynamic> json) => _$FBallListUpReqDtoFromJson(json);
  Map<String, dynamic> toJson() => _$FBallListUpReqDtoToJson(this);


}