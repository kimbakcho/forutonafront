
import 'package:json_annotation/json_annotation.dart';

part 'FBallReplyInsertReqDto.g.dart';

@JsonSerializable()
class FBallReplyInsertReqDto {
  String? replyUuid;
  String? ballUuid;
  String? replyText;

  FBallReplyInsertReqDto();
  factory FBallReplyInsertReqDto.fromJson(Map<String, dynamic> json) =>
      _$FBallReplyInsertReqDtoFromJson(json);

  Map<String, dynamic> toJson() => _$FBallReplyInsertReqDtoToJson(this);
}