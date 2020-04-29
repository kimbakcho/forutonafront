
import 'dart:convert';


import 'package:forutonafront/Common/PageableDto/MultiSort.dart';
import 'package:json_annotation/json_annotation.dart';

part 'UserToMakerBallReqDto.g.dart';

@JsonSerializable()
class UserToMakerBallReqDto {
  String makerUid;
  int page;
  int size;
  //MultiSorts 타입의 Json String을 입력
  String sorts;


  UserToMakerBallReqDto(
      this.makerUid, this.page, this.size, this.sorts);

  factory UserToMakerBallReqDto.fromJson(Map<String, dynamic> json) => _$UserToMakerBallReqDtoFromJson(json);
  Map<String, dynamic> toJson() => _$UserToMakerBallReqDtoToJson(this);

}