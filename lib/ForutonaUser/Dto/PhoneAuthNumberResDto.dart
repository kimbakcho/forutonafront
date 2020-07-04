import 'package:forutonafront/ForutonaUser/Data/Value/PhoneAuthNumber.dart';
import 'package:json_annotation/json_annotation.dart';
part 'PhoneAuthNumberResDto.g.dart';
@JsonSerializable()
class PhoneAuthNumberResDto {
  //Phone이 인증된 암호화 토큰
  String phoneAuthToken;
  String phoneNumber;
  String internationalizedPhoneNumber;
  bool errorFlag;
  String errorCause;

  PhoneAuthNumberResDto();
  factory PhoneAuthNumberResDto.fromJson(Map<String, dynamic> json) => _$PhoneAuthNumberResDtoFromJson(json);
  Map<String, dynamic> toJson() => _$PhoneAuthNumberResDtoToJson(this);

  factory PhoneAuthNumberResDto.fromPhoneAuthNumber(PhoneAuthNumber phoneAuthNumber) {
    PhoneAuthNumberResDto resDto = PhoneAuthNumberResDto();
    resDto.phoneAuthToken = phoneAuthNumber.phoneAuthToken;
    resDto.phoneNumber = phoneAuthNumber.phoneNumber;
    resDto.internationalizedPhoneNumber = phoneAuthNumber.internationalizedPhoneNumber;
    resDto.errorFlag = phoneAuthNumber.errorFlag;
    resDto.errorCause = phoneAuthNumber.errorCause;
    return resDto;
  }
}