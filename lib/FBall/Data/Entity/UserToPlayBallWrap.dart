import 'package:json_annotation/json_annotation.dart';

import 'UserToPlayBall.dart';

part 'UserToPlayBallWrap.g.dart';

@JsonSerializable()
class UserToPlayBallWrap {
  DateTime searchTime;
  List<UserToPlayBall> contents;

  UserToPlayBallWrap(this.searchTime, this.contents);

  factory UserToPlayBallWrap.fromJson(Map<String, dynamic> json) =>
      _$UserToPlayBallWrapFromJson(json);

  Map<String, dynamic> toJson() => _$UserToPlayBallWrapToJson(this);
}

