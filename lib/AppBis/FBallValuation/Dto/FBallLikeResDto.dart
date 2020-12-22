import 'package:json_annotation/json_annotation.dart';

import 'FBallValuationResDto.dart';

part 'FBallLikeResDto.g.dart';

@JsonSerializable(explicitToJson: true)
class FBallLikeResDto {
  int ballLike;
  int ballDislike;
  int likeServiceUseUserCount;
  int ballPower;
  FBallValuationResDto fballValuationResDto;
  FBallLikeResDto();
  factory FBallLikeResDto.fromJson(Map<String, dynamic> json) => _$FBallLikeResDtoFromJson(json);
  Map<String, dynamic> toJson() => _$FBallLikeResDtoToJson(this);
}