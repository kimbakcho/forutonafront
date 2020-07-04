import 'package:forutonafront/ForutonaUser/Data/Value/PhoneAuth.dart';
import 'package:json_annotation/json_annotation.dart';

part 'PhoneAuthResDto.g.dart';

@JsonSerializable()
class PhoneAuthResDto {
  String phoneNumber;
  String internationalizedPhoneNumber;
  String isoCode;
  DateTime authTime;
  DateTime authRetryAvailableTime;
  DateTime makeTime;

  PhoneAuthResDto();

  factory PhoneAuthResDto.fromPhoneAuth(PhoneAuth phoneAuth){
    PhoneAuthResDto phoneAuthResDto = PhoneAuthResDto();
    phoneAuthResDto.phoneNumber = phoneAuth.phoneNumber;
    phoneAuthResDto.internationalizedPhoneNumber = phoneAuth.internationalizedPhoneNumber;
    phoneAuthResDto.isoCode = phoneAuth.isoCode;
    phoneAuthResDto.authTime = phoneAuth.authTime;
    phoneAuthResDto.authRetryAvailableTime = phoneAuth.authRetryAvailableTime;
    phoneAuthResDto.makeTime = phoneAuth.makeTime;
    return phoneAuthResDto;
  }

  factory PhoneAuthResDto.fromJson(Map<String, dynamic> json) => _$PhoneAuthResDtoFromJson(json);
  Map<String, dynamic> toJson() => _$PhoneAuthResDtoToJson(this);
}