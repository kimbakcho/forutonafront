
import 'package:json_annotation/json_annotation.dart';
part 'PwChangeFromPhoneAuthReqDto.g.dart';

@JsonSerializable()
class PwChangeFromPhoneAuthReqDto {
  String password;
  String email;
  String internationalizedPhoneNumber;
  String emailPhoneAuthToken;

  PwChangeFromPhoneAuthReqDto();

  factory PwChangeFromPhoneAuthReqDto.fromJson(Map<String, dynamic> json) => _$PwChangeFromPhoneAuthReqDtoFromJson(json);
  Map<String, dynamic> toJson() => _$PwChangeFromPhoneAuthReqDtoToJson(this);

}