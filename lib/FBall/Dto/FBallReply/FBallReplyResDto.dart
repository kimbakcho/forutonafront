import 'package:json_annotation/json_annotation.dart';

part 'FBallReplyResDto.g.dart';

@JsonSerializable()
class FBallReplyResDto {
  String replyUuid;
  String ballUuid;
  String uid;
  int replyNumber;
  int replySort;
  int replyDepth;
  String replyText;
  DateTime replyUploadDateTime;
  DateTime replyUpdateDateTime;
  String userNickName;
  String userProfilePictureUrl;
  bool deleteFlag;

  FBallReplyResDto();
  factory FBallReplyResDto.fromJson(Map<String, dynamic> json) =>
      _$FBallReplyResDtoFromJson(json);

  Map<String, dynamic> toJson() => _$FBallReplyResDtoToJson(this);
}