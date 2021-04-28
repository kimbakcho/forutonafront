import 'package:json_annotation/json_annotation.dart';

import 'FBallValuationResDto.dart';

part 'FBallVoteResDto.g.dart';

@JsonSerializable(explicitToJson: true)
class FBallVoteResDto {
  int? ballLike;
  int? ballDislike;
  int? likeServiceUseUserCount;
  int? ballPower;
  List<FBallValuationResDto>? fballValuationResDto;
  FBallVoteResDto();
  factory FBallVoteResDto.fromJson(Map<String, dynamic> json) => _$FBallVoteResDtoFromJson(json);
  Map<String, dynamic> toJson() => _$FBallVoteResDtoToJson(this);
}