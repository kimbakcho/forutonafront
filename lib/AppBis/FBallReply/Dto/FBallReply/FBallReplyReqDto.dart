import 'package:json_annotation/json_annotation.dart';

part 'FBallReplyReqDto.g.dart';

@JsonSerializable()
class FBallReplyReqDto {
  String ballUuid;
  int replyNumber;
  bool reqOnlySubReply;


  FBallReplyReqDto();
  factory FBallReplyReqDto.fromJson(Map<String, dynamic> json) =>
      _$FBallReplyReqDtoFromJson(json);

  Map<String, dynamic> toJson() => _$FBallReplyReqDtoToJson(this);
}