import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'FBallListUpWrapDto.g.dart';

@JsonSerializable()
class FBallListUpWrapDto {
  DateTime searchTime;
  List<FBallResDto> balls;

  FBallListUpWrapDto(this.searchTime, this.balls);

  factory FBallListUpWrapDto.fromJson(Map<String, dynamic> json) =>
      _$FBallListUpWrapDtoFromJson(json);

  Map<String, dynamic> toJson() => _$FBallListUpWrapDtoToJson(this);
}
