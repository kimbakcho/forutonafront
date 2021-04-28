import 'package:json_annotation/json_annotation.dart';

part 'PhoneAuthResDto.g.dart';

@JsonSerializable()
class PhoneAuthResDto {
  String? phoneNumber;
  String? internationalizedDialCode;
  String? isoCode;
  DateTime? authTime;
  DateTime? authRetryAvailableTime;
  DateTime? makeTime;

  PhoneAuthResDto();

  factory PhoneAuthResDto.fromJson(Map<String, dynamic> json) => _$PhoneAuthResDtoFromJson(json);
  Map<String, dynamic> toJson() => _$PhoneAuthResDtoToJson(this);
}