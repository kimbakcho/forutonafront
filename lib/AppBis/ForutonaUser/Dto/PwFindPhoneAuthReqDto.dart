
import 'PhoneAuthReqDto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'PwFindPhoneAuthReqDto.g.dart';

@JsonSerializable()
class PwFindPhoneAuthReqDto extends PhoneAuthReqDto{
  String? email;
  String? emailPhoneAuthToken;

  PwFindPhoneAuthReqDto();

  factory PwFindPhoneAuthReqDto.fromJson(Map<String, dynamic> json) => _$PwFindPhoneAuthReqDtoFromJson(json);
  Map<String, dynamic> toJson() => _$PwFindPhoneAuthReqDtoToJson(this);
}