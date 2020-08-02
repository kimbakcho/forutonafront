
import 'package:forutonafront/FBall/Domain/Value/LikeActionType.dart';
import 'package:json_annotation/json_annotation.dart';

part 'FBallLikeReqDto.g.dart';

@JsonSerializable()
class FBallLikeReqDto {
  String valueUuid;
  String ballUuid;
  int likePoint;
  int disLikePoint;
  LikeActionType likeActionType;

  FBallLikeReqDto();

  factory FBallLikeReqDto.fromJson(Map<String, dynamic> json) => _$FBallLikeReqDtoFromJson(json);
  Map<String, dynamic> toJson() => _$FBallLikeReqDtoToJson(this);
}