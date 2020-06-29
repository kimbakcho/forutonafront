import 'package:json_annotation/json_annotation.dart';
part 'PhoneAuthNumber.g.dart';
@JsonSerializable()
class PhoneAuthNumber {
  //Phone이 인증된 암호화 토큰
  String phoneAuthToken;
  String phoneNumber;
  String internationalizedPhoneNumber;
  bool errorFlag;
  String errorCause;

  PhoneAuthNumber();
  factory PhoneAuthNumber.fromJson(Map<String, dynamic> json) => _$PhoneAuthNumberFromJson(json);
  Map<String, dynamic> toJson() => _$PhoneAuthNumberToJson(this);
}