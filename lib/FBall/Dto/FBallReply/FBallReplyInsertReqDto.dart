
import 'package:json_annotation/json_annotation.dart';

part 'FBallReplyInsertReqDto.g.dart';

@JsonSerializable()
class FBallReplyInsertReqDto {
  String replyUuid;
  String ballUuid;
  int replyNumber;
  int replySort;
  int replyDepth;
  String replyText;

  FBallReplyInsertReqDto();
  factory FBallReplyInsertReqDto.fromJson(Map<String, dynamic> json) =>
      _$FBallReplyInsertReqDtoFromJson(json);

  Map<String, dynamic> toJson() => _$FBallReplyInsertReqDtoToJson(this);
}