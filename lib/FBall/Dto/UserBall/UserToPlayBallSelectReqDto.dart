
import 'package:json_annotation/json_annotation.dart';
part 'UserToPlayBallSelectReqDto.g.dart';
@JsonSerializable()
class UserToPlayBallSelectReqDto{
  String playerUid;
  String ballUuid;


  UserToPlayBallSelectReqDto(this.playerUid, this.ballUuid);

  factory UserToPlayBallSelectReqDto.fromJson(Map<String, dynamic> json) => _$UserToPlayBallSelectReqDtoFromJson(json);
  Map<String, dynamic> toJson() => _$UserToPlayBallSelectReqDtoToJson(this);
}