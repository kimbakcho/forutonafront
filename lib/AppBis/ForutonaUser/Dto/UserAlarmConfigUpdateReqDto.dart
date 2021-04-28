
import 'package:json_annotation/json_annotation.dart';

part 'UserAlarmConfigUpdateReqDto.g.dart';

@JsonSerializable()
class UserAlarmConfigUpdateReqDto {
  bool? alarmChatMessage;
  bool? alarmContentReply;
  bool? alarmReplyAndReply;
  bool? alarmFollowNewContent;
  bool? alarmSponNewContent;

  UserAlarmConfigUpdateReqDto();

  factory UserAlarmConfigUpdateReqDto.fromJson(Map<String, dynamic> json) => _$UserAlarmConfigUpdateReqDtoFromJson(json);
  Map<String, dynamic> toJson() => _$UserAlarmConfigUpdateReqDtoToJson(this);
}