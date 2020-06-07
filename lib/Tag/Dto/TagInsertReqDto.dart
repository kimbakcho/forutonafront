
import 'package:flutter/cupertino.dart';
import 'package:forutonafront/Tag/Data/Entity/FBallTag.dart';
import 'package:json_annotation/json_annotation.dart';

part 'TagInsertReqDto.g.dart';

@JsonSerializable()
class TagInsertReqDto {
  String ballUuid;
  String tagItem;
  TagInsertReqDto({@required this.ballUuid,@required this.tagItem});


  factory TagInsertReqDto.fromJson(Map<String, dynamic> json) => _$TagInsertReqDtoFromJson(json);
  Map<String, dynamic> toJson() => _$TagInsertReqDtoToJson(this);

  factory TagInsertReqDto.fromFBallTag(FBallTag item ){
    return TagInsertReqDto(ballUuid: item.ballUuid,tagItem: item.tagItem);
  }

}