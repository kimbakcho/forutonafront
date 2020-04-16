
import 'package:json_annotation/json_annotation.dart';

part 'FUserInfoPwChangeReqDto.g.dart';

@JsonSerializable()
class FUserInfoPwChangeReqDto {
  String pw;

  FUserInfoPwChangeReqDto(this.pw);

  factory FUserInfoPwChangeReqDto.fromJson(Map<String, dynamic> json) => _$FUserInfoPwChangeReqDtoFromJson(json);
  Map<String, dynamic> toJson() => _$FUserInfoPwChangeReqDtoToJson(this);
}