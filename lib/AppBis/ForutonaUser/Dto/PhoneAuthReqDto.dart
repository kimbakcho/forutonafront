
import 'package:json_annotation/json_annotation.dart';

part 'PhoneAuthReqDto.g.dart';

@JsonSerializable()
class PhoneAuthReqDto {
  String phoneNumber;
  String internationalizedDialCode;
  String isoCode;

  PhoneAuthReqDto();

  factory PhoneAuthReqDto.fromJson(Map<String, dynamic> json) => _$PhoneAuthReqDtoFromJson(json);
  Map<String, dynamic> toJson() => _$PhoneAuthReqDtoToJson(this);
}