
import 'dart:convert';


import 'package:forutonafront/Common/PageableDto/MultiSort.dart';
import 'package:json_annotation/json_annotation.dart';

part 'UserToMakeBallReqDto.g.dart';

@JsonSerializable()
class UserToMakeBallReqDto {
  String makerUid;
  int page;
  int size;
  //MultiSorts 타입의 Json String을 입력
  String sorts;


  UserToMakeBallReqDto(
      this.makerUid, this.page, this.size, this.sorts);

  factory UserToMakeBallReqDto.fromJson(Map<String, dynamic> json) => _$UserToMakeBallReqDtoFromJson(json);
  Map<String, dynamic> toJson() => _$UserToMakeBallReqDtoToJson(this);

}