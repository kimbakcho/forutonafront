

import 'package:forutonafront/FBall/Data/Value/FBallType.dart';
import 'package:json_annotation/json_annotation.dart';

part 'FBallJoinReqDto.g.dart';

@JsonSerializable()
class FBallJoinReqDto {
  FBallType ballType;
  String ballUuid;
  String playerUid;

  FBallJoinReqDto(this.ballType, this.ballUuid, this.playerUid);

  factory FBallJoinReqDto.fromJson(Map<String, dynamic> json) => _$FBallJoinReqDtoFromJson(json);
  Map<String, dynamic> toJson() => _$FBallJoinReqDtoToJson(this);
}