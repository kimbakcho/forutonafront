import 'package:forutonafront/ForutonaUser/Data/Value/PwFindPhoneAuth.dart';
import 'package:forutonafront/ForutonaUser/Dto/PhoneAuthResDto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'PwFindPhoneAuthResDto.g.dart';

@JsonSerializable()
class PwFindPhoneAuthResDto extends PhoneAuthResDto {
  bool error;
  String cause;

  factory PwFindPhoneAuthResDto.fromPwFindPhoneAuth(PwFindPhoneAuth item){
    PwFindPhoneAuthResDto resDto = PwFindPhoneAuthResDto();
    resDto.error = item.error;
    resDto.cause = item.cause;
    resDto.phoneNumber = item.phoneNumber;
    resDto.internationalizedPhoneNumber = item.internationalizedPhoneNumber;
    resDto.isoCode = item.isoCode;
    resDto.authTime = item.authTime;
    resDto.authRetryAvailableTime = item.authRetryAvailableTime;
    resDto.makeTime = item.makeTime;
    return resDto;
  }

  PwFindPhoneAuthResDto();
  factory PwFindPhoneAuthResDto.fromJson(Map<String, dynamic> json) => _$PwFindPhoneAuthResDtoFromJson(json);
  Map<String, dynamic> toJson() => _$PwFindPhoneAuthResDtoToJson(this);
}