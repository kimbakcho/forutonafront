import 'package:forutonafront/FBall/Dto/FBallType.dart';
import 'package:json_annotation/json_annotation.dart';

part 'FBallReqDto.g.dart';

@JsonSerializable()
class FBallReqDto {

  FBallReqDto(this.ballType,this.ballUuid);
  FBallType ballType;
  String ballUuid;
  factory FBallReqDto.fromJson(Map<String, dynamic> json) =>
      _$FBallReqDtoFromJson(json);

  Map<String, dynamic> toJson() => _$FBallReqDtoToJson(this);
}