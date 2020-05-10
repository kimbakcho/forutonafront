import 'PhoneAuthNumberResDto.dart';

import 'package:json_annotation/json_annotation.dart';
part 'PwFindPhoneAuthNumberResDto.g.dart';
@JsonSerializable()
class PwFindPhoneAuthNumberResDto extends PhoneAuthNumberResDto{

  String email;
  //emial + Phone이 인증된 암호화 토큰
  String emailPhoneAuthToken;

  PwFindPhoneAuthNumberResDto();
  factory PwFindPhoneAuthNumberResDto.fromJson(Map<String, dynamic> json) => _$PwFindPhoneAuthNumberResDtoFromJson(json);
  Map<String, dynamic> toJson() => _$PwFindPhoneAuthNumberResDtoToJson(this);
}