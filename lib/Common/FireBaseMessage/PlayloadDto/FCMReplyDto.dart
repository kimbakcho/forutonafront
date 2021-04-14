
import 'package:forutonafront/AppBis/FBall/Domain/Value/FBallType.dart';
import 'package:json_annotation/json_annotation.dart';

part 'FCMReplyDto.g.dart';

@JsonSerializable()
class FCMReplyDto {
  String replyUserUid;
  String nickName;
  String replyText;
  String userProfileImageUrl;
  String ballUuid;
  String replyTitleType;
  FBallType fBallType;

  FCMReplyDto();

  factory FCMReplyDto.fromJson(Map<String, dynamic> json) => _$FCMReplyDtoFromJson(json);
  Map<String, dynamic> toJson() => _$FCMReplyDtoToJson(this);
}
