
import 'package:json_annotation/json_annotation.dart';

part 'UserToMakerBallSelectReqDto.g.dart';

@JsonSerializable()
class UserToMakerBallSelectReqDto {
  String makerUid;
  String ballUuid;

  UserToMakerBallSelectReqDto(this.makerUid, this.ballUuid);
  factory UserToMakerBallSelectReqDto.fromJson(Map<String, dynamic> json) => _$UserToMakerBallSelectReqDtoFromJson(json);
  Map<String, dynamic> toJson() => _$UserToMakerBallSelectReqDtoToJson(this);

}