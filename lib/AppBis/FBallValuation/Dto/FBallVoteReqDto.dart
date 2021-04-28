

import 'package:forutonafront/AppBis/FBallValuation/Domain/Value/LikeActionType.dart';
import 'package:json_annotation/json_annotation.dart';

part 'FBallVoteReqDto.g.dart';

@JsonSerializable()
class FBallVoteReqDto {

  String? ballUuid;
  int? likePoint;
  int? disLikePoint;
  LikeActionType? likeActionType;

  FBallVoteReqDto();

  factory FBallVoteReqDto.fromJson(Map<String, dynamic> json) => _$FBallVoteReqDtoFromJson(json);
  Map<String, dynamic> toJson() => _$FBallVoteReqDtoToJson(this);
}