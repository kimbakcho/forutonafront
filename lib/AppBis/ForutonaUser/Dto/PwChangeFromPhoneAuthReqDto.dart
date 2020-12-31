
import 'package:injectable/injectable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'PwChangeFromPhoneAuthReqDto.g.dart';

@JsonSerializable()
@lazySingleton
class PwChangeFromPhoneAuthReqDto {
  String password;
  String email;
  String internationalizedPhoneNumber;
  String emailPhoneAuthToken;

  PwChangeFromPhoneAuthReqDto();

  factory PwChangeFromPhoneAuthReqDto.fromJson(Map<String, dynamic> json) => _$PwChangeFromPhoneAuthReqDtoFromJson(json);
  Map<String, dynamic> toJson() => _$PwChangeFromPhoneAuthReqDtoToJson(this);

}