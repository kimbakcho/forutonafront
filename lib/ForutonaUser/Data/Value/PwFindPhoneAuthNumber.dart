import 'package:forutonafront/ForutonaUser/Data/Value/PhoneAuthNumber.dart';


import 'package:json_annotation/json_annotation.dart';
part 'PwFindPhoneAuthNumber.g.dart';
@JsonSerializable()
class PwFindPhoneAuthNumber extends PhoneAuthNumber{

  String email;
  //emial + Phone이 인증된 암호화 토큰
  String emailPhoneAuthToken;

  PwFindPhoneAuthNumber();
  factory PwFindPhoneAuthNumber.fromJson(Map<String, dynamic> json) => _$PwFindPhoneAuthNumberFromJson(json);
  Map<String, dynamic> toJson() => _$PwFindPhoneAuthNumberToJson(this);
}