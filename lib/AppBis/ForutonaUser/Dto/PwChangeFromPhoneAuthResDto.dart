import 'package:json_annotation/json_annotation.dart';
part 'PwChangeFromPhoneAuthResDto.g.dart';

@JsonSerializable()
class PwChangeFromPhoneAuthResDto {
  String email;
  String internationalizedPhoneNumber;
  bool errorFlag;
  String cause;

  PwChangeFromPhoneAuthResDto();
  factory PwChangeFromPhoneAuthResDto.fromJson(Map<String, dynamic> json) => _$PwChangeFromPhoneAuthResDtoFromJson(json);
  Map<String, dynamic> toJson() => _$PwChangeFromPhoneAuthResDtoToJson(this);
}