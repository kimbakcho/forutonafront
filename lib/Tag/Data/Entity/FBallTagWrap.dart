import 'package:forutonafront/Tag/Data/Entity/FBallTag.dart';
import 'package:json_annotation/json_annotation.dart';

part 'FBallTagWrap.g.dart';

@JsonSerializable()
class FBallTagWrap {
  int totalCount;
  List<FBallTag> tags;

  FBallTagWrap();

  factory FBallTagWrap.fromJson(Map<String, dynamic> json) => _$FBallTagWrapFromJson(json);
  Map<String, dynamic> toJson() => _$FBallTagWrapToJson(this);

}