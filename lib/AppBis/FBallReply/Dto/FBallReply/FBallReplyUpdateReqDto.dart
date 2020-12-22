
import 'package:json_annotation/json_annotation.dart';

part 'FBallReplyUpdateReqDto.g.dart';

@JsonSerializable()
class FBallReplyUpdateReqDto {
  String replyUuid;
  String replyText;

  FBallReplyUpdateReqDto();
  factory FBallReplyUpdateReqDto.fromJson(Map<String, dynamic> json) =>
      _$FBallReplyUpdateReqDtoFromJson(json);

  Map<String, dynamic> toJson() => _$FBallReplyUpdateReqDtoToJson(this);

}