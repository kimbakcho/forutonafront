
import 'package:json_annotation/json_annotation.dart';
part 'FBallListUpReqDto.g.dart';

@JsonSerializable()
class FBallListUpReqDto {

  double latitude;
  double longitude;
  int ballLimit;
  int page;
  int size;
  String sort;


  FBallListUpReqDto({this.latitude, this.longitude, this.ballLimit, this.page,
      this.size, this.sort});

  factory FBallListUpReqDto.fromJson(Map<String, dynamic> json) => _$FBallListUpReqDtoFromJson(json);
  Map<String, dynamic> toJson() => _$FBallListUpReqDtoToJson(this);


}