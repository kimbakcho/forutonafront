import 'package:json_annotation/json_annotation.dart';

import 'UserToMakeBall.dart';
import 'UserToPlayBall.dart';

part 'UserToMakeBallWrap.g.dart';

@JsonSerializable()
class UserToMakeBallWrap {
  DateTime searchTime;
  List<UserToMakeBall> contents;
  UserToMakeBallWrap();

  factory UserToMakeBallWrap.fromJson(Map<String, dynamic> json) =>
      _$UserToMakeBallWrapFromJson(json);

  Map<String, dynamic> toJson() => _$UserToMakeBallWrapToJson(this);
}