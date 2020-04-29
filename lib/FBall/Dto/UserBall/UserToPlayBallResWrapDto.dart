import 'package:json_annotation/json_annotation.dart';

import 'UserToPlayBallResDto.dart';

part 'UserToPlayBallResWrapDto.g.dart';

@JsonSerializable()
class UserToPlayBallResWrapDto {
  DateTime searchTime;
  List<UserToPlayBallResDto> contents;


  UserToPlayBallResWrapDto(this.searchTime, this.contents);

  factory UserToPlayBallResWrapDto.fromJson(Map<String, dynamic> json) => _$UserToPlayBallResWrapDtoFromJson(json);
  Map<String, dynamic> toJson() => _$UserToPlayBallResWrapDtoToJson(this);
}
