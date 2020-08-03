
import 'package:forutonafront/FBall/Domain/Entity/FBallReply.dart';
import 'package:json_annotation/json_annotation.dart';

part 'FBallReplyResWrap.g.dart';

@JsonSerializable()
class FBallReplyResWrap {
  int count;
  int offset;
  int pageSize;
  int replyTotalCount;
  bool onlySubReply;
  List<FBallReply> contents = [];

  FBallReplyResWrap();

  factory FBallReplyResWrap.fromJson(Map<String, dynamic> json) =>
      _$FBallReplyResWrapFromJson(json);

  Map<String, dynamic> toJson() => _$FBallReplyResWrapToJson(this);
}