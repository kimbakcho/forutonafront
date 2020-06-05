
import 'package:forutonafront/FBall/Data/Entity/FBall.dart';
import 'package:forutonafront/FBall/Data/Value/FBallState.dart';
import 'package:forutonafront/FBall/Data/Value/FBallType.dart';
import 'package:json_annotation/json_annotation.dart';

part 'UserToPlayBall.g.dart';

@JsonSerializable()
class UserToPlayBall extends FBall{
  DateTime joinTime;

  UserToPlayBall();
  factory UserToPlayBall.fromJson(Map<String, dynamic> json) =>
      _$UserToPlayBallFromJson(json);

  Map<String, dynamic> toJson() => _$UserToPlayBallToJson(this);


}