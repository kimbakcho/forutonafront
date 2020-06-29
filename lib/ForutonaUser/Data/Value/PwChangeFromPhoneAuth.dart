import 'package:json_annotation/json_annotation.dart';
part 'PwChangeFromPhoneAuth.g.dart';

@JsonSerializable()
class PwChangeFromPhoneAuth {
  String email;
  String internationalizedPhoneNumber;
  bool errorFlag;
  String cause;

  PwChangeFromPhoneAuth();
  factory PwChangeFromPhoneAuth.fromJson(Map<String, dynamic> json) => _$PwChangeFromPhoneAuthFromJson(json);
  Map<String, dynamic> toJson() => _$PwChangeFromPhoneAuthToJson(this);
}