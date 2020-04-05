

import 'package:json_annotation/json_annotation.dart';

import 'FBallType.dart';
import 'UserBallResDto.dart';

part 'UserToPlayBallResDto.g.dart';

@JsonSerializable()
class UserToPlayBallResDto extends UserBallResDto{

  DateTime joinTime;

  UserToPlayBallResDto(this.joinTime) : super('', null, 0.0, 0.0, '', '', 0, 0, 0, null, null, 0.0, '');

  factory UserToPlayBallResDto.fromJson(Map<String, dynamic> json) => _$UserToPlayBallResDtoFromJson(json);
  Map<String, dynamic> toJson() => _$UserToPlayBallResDtoToJson(this);

}