
import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

part 'RelationTagRankingFromTagNameReqDto.g.dart';

@JsonSerializable()
class RelationTagRankingFromTagNameReqDto {
  String searchTagName;

  RelationTagRankingFromTagNameReqDto({@required this.searchTagName});


  factory RelationTagRankingFromTagNameReqDto.fromJson(Map<String, dynamic> json) => _$RelationTagRankingFromTagNameReqDtoFromJson(json);
  Map<String, dynamic> toJson() => _$RelationTagRankingFromTagNameReqDtoToJson(this);

}