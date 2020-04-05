
import 'dart:convert';


import 'package:json_annotation/json_annotation.dart';

part 'UserToPlayBallReqDto.g.dart';

@JsonSerializable(explicitToJson: true)
class UserToPlayBallReqDto {
    String playerUid;
    int page;
    int size;
    //MultiSorts 타입의 Json String을 입력
    String sorts;

    UserToPlayBallReqDto(
      this.playerUid, this.page, this.size, this.sorts);

  factory UserToPlayBallReqDto.fromJson(Map<String, dynamic> json) => _$UserToPlayBallReqDtoFromJson(json);
    Map<String, dynamic> toJson() => _$UserToPlayBallReqDtoToJson(this);


}