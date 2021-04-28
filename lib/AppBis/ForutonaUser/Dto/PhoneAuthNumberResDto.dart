import 'package:json_annotation/json_annotation.dart';
part 'PhoneAuthNumberResDto.g.dart';
@JsonSerializable()
class PhoneAuthNumberResDto {
  //Phone이 인증된 암호화 토큰
  String? phoneAuthToken;
  String? phoneNumber;
  String? internationalizedDialCode;
  bool? errorFlag;
  String? errorCause;

  PhoneAuthNumberResDto();
  factory PhoneAuthNumberResDto.fromJson(Map<String, dynamic> json) => _$PhoneAuthNumberResDtoFromJson(json);
  Map<String, dynamic> toJson() => _$PhoneAuthNumberResDtoToJson(this);

}