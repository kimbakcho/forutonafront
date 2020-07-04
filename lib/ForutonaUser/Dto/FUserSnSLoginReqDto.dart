
import 'package:json_annotation/json_annotation.dart';

import 'SnsSupportService.dart';

part 'FUserSnSLoginReqDto.g.dart';

@JsonSerializable()
class FUserSnSLoginReqDto {
  String accessToken;
  String snsUid;
  SnsSupportService snsService;
  String fUserUid;
  String userNickName;
  String email;
  String userProfileImageUrl;

  FUserSnSLoginReqDto();
  factory FUserSnSLoginReqDto.fromJson(Map<String, dynamic> json) => _$FUserSnSLoginReqDtoFromJson(json);
  Map<String, dynamic> toJson() => _$FUserSnSLoginReqDtoToJson(this);

}