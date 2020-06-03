import 'package:forutonafront/FBall/Data/Value/FBallState.dart';
import 'package:forutonafront/FBall/Data/Value/FBallType.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';

import 'package:json_annotation/json_annotation.dart';


part 'UserToPlayBallResDto.g.dart';



@JsonSerializable()
class UserToPlayBallResDto extends FBallResDto{
  DateTime joinTime;

  UserToPlayBallResDto();




  factory UserToPlayBallResDto.fromJson(Map<String, dynamic> json) => _$UserToPlayBallResDtoFromJson(json);
  Map<String, dynamic> toJson() => _$UserToPlayBallResDtoToJson(this);

}