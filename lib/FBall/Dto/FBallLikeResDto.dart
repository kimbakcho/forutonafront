import 'package:json_annotation/json_annotation.dart';

part 'FBallLikeResDto.g.dart';

@JsonSerializable()
class FBallLikeResDto {
  int like;
  int dislike;
  FBallLikeResDto();
  factory FBallLikeResDto.fromJson(Map<String, dynamic> json) => _$FBallLikeResDtoFromJson(json);
  Map<String, dynamic> toJson() => _$FBallLikeResDtoToJson(this);
}