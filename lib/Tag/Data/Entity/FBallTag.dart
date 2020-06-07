

import 'package:forutonafront/Tag/Dto/FBallTagResDto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'FBallTag.g.dart';

@JsonSerializable()
class FBallTag {
  String ballUuid;
  String tagItem;

  FBallTag({this.ballUuid,this.tagItem});

  factory FBallTag.fromJson(Map<String, dynamic> json) => _$FBallTagFromJson(json);
  Map<String, dynamic> toJson() => _$FBallTagToJson(this);

  factory FBallTag.fromFBallTagResDto(FBallTagResDto item){
    return FBallTag(ballUuid: item.ballUuid,tagItem: item.tagItem);
  }
}