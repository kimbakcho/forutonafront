
import 'package:json_annotation/json_annotation.dart';

import 'UserToMakeBallResDto.dart';

part 'UserToMakeBallResWrapDto.g.dart';

@JsonSerializable()
class UserToMakeBallResWrapDto {
  DateTime searchTime;
  List<UserToMakeBallResDto> contents;

  UserToMakeBallResWrapDto(this.searchTime, this.contents);

  factory UserToMakeBallResWrapDto.fromJson(Map<String, dynamic> json) => _$UserToMakeBallResWrapDtoFromJson(json);
  Map<String, dynamic> toJson() => _$UserToMakeBallResWrapDtoToJson(this);
}