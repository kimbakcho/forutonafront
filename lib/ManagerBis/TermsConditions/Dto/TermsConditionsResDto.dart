import 'package:forutonafront/ManagerBis/MUserInfo/Dto/MUserInfoResDto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'TermsConditionsResDto.g.dart';

@JsonSerializable()
class TermsConditionsResDto {
  int? idx;
  String? termsName;
  String? termsContent;
  DateTime? modifyDate;
  MUserInfoResDto? modifyUser;

  TermsConditionsResDto();

  factory TermsConditionsResDto.fromJson(Map<String, dynamic> json) => _$TermsConditionsResDtoFromJson(json);
  Map<String, dynamic> toJson() => _$TermsConditionsResDtoToJson(this);
}