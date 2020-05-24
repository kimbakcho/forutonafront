
import 'package:json_annotation/json_annotation.dart';

import '../FBallResDto.dart';
import '../FBallType.dart';

part 'UserBallResDto.g.dart';

@JsonSerializable()
class UserBallResDto {
  FBallResDto fballResDto;
  UserBallResDto();

  factory UserBallResDto.fromJson(Map<String, dynamic> json) => _$UserBallResDtoFromJson(json);
  Map<String, dynamic> toJson() => _$UserBallResDtoToJson(this);
}