import 'package:injectable/injectable.dart';

import 'PhoneAuthNumberReqDto.dart';
import 'package:json_annotation/json_annotation.dart';
part 'PwFindPhoneAuthNumberReqDto.g.dart';

@JsonSerializable()
class PwFindPhoneAuthNumberReqDto extends PhoneAuthNumberReqDto{
  String? email;

  PwFindPhoneAuthNumberReqDto();
  factory PwFindPhoneAuthNumberReqDto.fromJson(Map<String, dynamic> json) => _$PwFindPhoneAuthNumberReqDtoFromJson(json);
  Map<String, dynamic> toJson() => _$PwFindPhoneAuthNumberReqDtoToJson(this);
}