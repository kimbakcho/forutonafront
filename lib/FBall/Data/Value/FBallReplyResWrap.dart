import 'package:forutonafront/FBall/Data/Entity/FBallReply.dart';
import 'package:json_annotation/json_annotation.dart';

part 'FBallReplyResWrap.g.dart';

@JsonSerializable()
class FBallReplyResWrap {
  int count;
  int replyTotalCount;
  List<FBallReply> contents = [];

  FBallReplyResWrap();

  factory FBallReplyResWrap.fromJson(Map<String, dynamic> json) =>
      _$FBallReplyResWrapFromJson(json);

  Map<String, dynamic> toJson() => _$FBallReplyResWrapToJson(this);
}