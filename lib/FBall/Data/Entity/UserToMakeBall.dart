import 'package:forutonafront/FBall/Data/Entity/FBall.dart';
import 'package:forutonafront/FBall/Data/Value/FBallState.dart';
import 'package:forutonafront/FBall/Data/Value/FBallType.dart';
import 'package:forutonafront/Tag/Data/Entity/FBallTag.dart';
import 'package:json_annotation/json_annotation.dart';
part 'UserToMakeBall.g.dart';
@JsonSerializable()
class UserToMakeBall extends FBall{
  UserToMakeBall();


  factory UserToMakeBall.fromJson(Map<String, dynamic> json) =>
      _$UserToMakeBallFromJson(json);

  Map<String, dynamic> toJson() => _$UserToMakeBallToJson(this);
}