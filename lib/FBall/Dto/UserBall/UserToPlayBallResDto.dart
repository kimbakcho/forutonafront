

import 'package:forutonafront/FBall/Dto/FBallType.dart';
import 'package:json_annotation/json_annotation.dart';

import 'UserBallResDto.dart';

part 'UserToPlayBallResDto.g.dart';



@JsonSerializable()
class UserToPlayBallResDto extends UserBallResDto{

  DateTime joinTime;

  UserToPlayBallResDto(this.joinTime) : super();

  factory UserToPlayBallResDto.fromJson(Map<String, dynamic> json) => _$UserToPlayBallResDtoFromJson(json);
  Map<String, dynamic> toJson() => _$UserToPlayBallResDtoToJson(this);

}