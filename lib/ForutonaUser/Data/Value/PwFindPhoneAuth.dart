import 'package:forutonafront/ForutonaUser/Dto/PhoneAuthResDto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'PwFindPhoneAuth.g.dart';

@JsonSerializable()
class PwFindPhoneAuth extends PhoneAuthResDto {
  bool error;
  String cause;

  PwFindPhoneAuth();
  factory PwFindPhoneAuth.fromJson(Map<String, dynamic> json) => _$PwFindPhoneAuthFromJson(json);
  Map<String, dynamic> toJson() => _$PwFindPhoneAuthToJson(this);
}