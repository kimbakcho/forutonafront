import 'package:json_annotation/json_annotation.dart';

import 'FBallValuationResDto.dart';

part 'FBallLikeResDto.g.dart';

@JsonSerializable()
class FBallLikeResDto {
  int like;
  int dislike;
  FBallValuationResDto fBallValuationResDto;
  FBallLikeResDto();
  factory FBallLikeResDto.fromJson(Map<String, dynamic> json) => _$FBallLikeResDtoFromJson(json);
  Map<String, dynamic> toJson() => _$FBallLikeResDtoToJson(this);
}