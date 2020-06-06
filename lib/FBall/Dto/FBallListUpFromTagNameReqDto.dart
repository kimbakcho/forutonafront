

import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

part 'FBallListUpFromTagNameReqDto.g.dart';


@JsonSerializable()
class FBallListUpFromTagNameReqDto {
  String searchTag;
  @JsonKey(name: 'sorts')
  final String sortsJsonText;
  int size;
  int page;
  //거리순 정렬이 있기에 좌표 넘겨줌
  double latitude;
  double longitude;
  FBallListUpFromTagNameReqDto({@required this.searchTag,@required  this.sortsJsonText,@required  this.size,@required  this.page,
    @required this.latitude,@required this.longitude});


  factory FBallListUpFromTagNameReqDto.fromJson(Map<String, dynamic> json) => _$FBallListUpFromTagNameReqDtoFromJson(json);
  Map<String, dynamic> toJson() => _$FBallListUpFromTagNameReqDtoToJson(this);
}