
import 'package:json_annotation/json_annotation.dart';

import 'SnsSupportService.dart';

part 'FUserSnSJoinReqDto.g.dart';

@JsonSerializable()
class FUserSnSJoinReqDto {
  String? accessToken;
  String? snsUid;
  SnsSupportService? snsService;
  String? fUserUid;
  String? userNickName;
  String? email;
  String? userProfileImageUrl;

  FUserSnSJoinReqDto();
  factory FUserSnSJoinReqDto.fromJson(Map<String, dynamic> json) =>_$FUserSnSJoinReqDtoFromJson(json);
  Map<String, dynamic> toJson() => _$FUserSnSJoinReqDtoToJson(this);

}