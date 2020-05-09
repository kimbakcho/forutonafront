
import 'package:json_annotation/json_annotation.dart';
part 'PhoneAuthNumberReqDto.g.dart';
@JsonSerializable()
class PhoneAuthNumberReqDto {
  String phoneNumber;
  String internationalizedPhoneNumber;
  String isoCode;
  String authNumber;
  PhoneAuthNumberReqDto();
  factory PhoneAuthNumberReqDto.fromJson(Map<String, dynamic> json) => _$PhoneAuthNumberReqDtoFromJson(json);
  Map<String, dynamic> toJson() => _$PhoneAuthNumberReqDtoToJson(this);
}