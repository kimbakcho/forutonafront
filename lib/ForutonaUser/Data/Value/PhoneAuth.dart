import 'package:json_annotation/json_annotation.dart';

part 'PhoneAuth.g.dart';

@JsonSerializable()
class PhoneAuth {
  String phoneNumber;
  String internationalizedPhoneNumber;
  String isoCode;
  DateTime authTime;
  DateTime authRetryAvailableTime;
  DateTime makeTime;

  PhoneAuth();

  factory PhoneAuth.fromJson(Map<String, dynamic> json) => _$PhoneAuthFromJson(json);
  Map<String, dynamic> toJson() => _$PhoneAuthToJson(this);
}