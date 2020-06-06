

import 'package:json_annotation/json_annotation.dart';

part 'FBallTag.g.dart';

@JsonSerializable()
class FBallTag {
  String ballUuid;
  String tagItem;

  FBallTag();

  factory FBallTag.fromJson(Map<String, dynamic> json) => _$FBallTagFromJson(json);
  Map<String, dynamic> toJson() => _$FBallTagToJson(this);
}