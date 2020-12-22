import 'package:forutonafront/AppBis/ForutonaUser/Dto/PhoneAuthResDto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'PwFindPhoneAuthResDto.g.dart';

@JsonSerializable()
class PwFindPhoneAuthResDto extends PhoneAuthResDto {
  bool error;
  String cause;

  PwFindPhoneAuthResDto();
  factory PwFindPhoneAuthResDto.fromJson(Map<String, dynamic> json) => _$PwFindPhoneAuthResDtoFromJson(json);
  Map<String, dynamic> toJson() => _$PwFindPhoneAuthResDtoToJson(this);
}