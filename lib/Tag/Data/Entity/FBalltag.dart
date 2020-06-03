

import 'package:json_annotation/json_annotation.dart';

part 'FBalltag.g.dart';

@JsonSerializable()
class FBalltag {
  String ballUuid;
  String tagItem;

  FBalltag();

  factory FBalltag.fromJson(Map<String, dynamic> json) => _$FBalltagFromJson(json);
  Map<String, dynamic> toJson() => _$FBalltagToJson(this);
}