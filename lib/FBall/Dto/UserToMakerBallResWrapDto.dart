
import 'package:json_annotation/json_annotation.dart';

import 'UserToMakerBallResDto.dart';

part 'UserToMakerBallResWrapDto.g.dart';

@JsonSerializable()
class UserToMakerBallResWrapDto {
  DateTime searchTime;
  List<UserToMakerBallResDto> contents;

  UserToMakerBallResWrapDto(this.searchTime, this.contents);

  factory UserToMakerBallResWrapDto.fromJson(Map<String, dynamic> json) => _$UserToMakerBallResWrapDtoFromJson(json);
  Map<String, dynamic> toJson() => _$UserToMakerBallResWrapDtoToJson(this);
}