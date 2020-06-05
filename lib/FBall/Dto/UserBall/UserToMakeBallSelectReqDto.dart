
import 'package:json_annotation/json_annotation.dart';

part 'UserToMakeBallSelectReqDto.g.dart';

@JsonSerializable()
class UserToMakeBallSelectReqDto {
  String makerUid;
  String ballUuid;

  UserToMakeBallSelectReqDto(this.makerUid, this.ballUuid);
  factory UserToMakeBallSelectReqDto.fromJson(Map<String, dynamic> json) => _$UserToMakeBallSelectReqDtoFromJson(json);
  Map<String, dynamic> toJson() => _$UserToMakeBallSelectReqDtoToJson(this);

}