import 'package:json_annotation/json_annotation.dart';

import 'FBallReplyResDto.dart';

part 'FBallReplyResWrapDto.g.dart';

@JsonSerializable()
class FBallReplyResWrapDto{
  int count;
  int replyTotalCount;
  List<FBallReplyResDto> contents = [];


  FBallReplyResWrapDto();

  factory FBallReplyResWrapDto.fromJson(Map<String, dynamic> json) =>
      _$FBallReplyResWrapDtoFromJson(json);

  Map<String, dynamic> toJson() => _$FBallReplyResWrapDtoToJson(this);
}