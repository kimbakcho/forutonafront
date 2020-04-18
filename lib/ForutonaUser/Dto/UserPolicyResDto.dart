
import 'package:json_annotation/json_annotation.dart';

part 'UserPolicyResDto.g.dart';

@JsonSerializable()
class UserPolicyResDto {
  String policyName;
  String policyContent;
  String lang;
  DateTime writeDateTime;

  UserPolicyResDto(
      this.policyName, this.policyContent, this.lang, this.writeDateTime);
  factory UserPolicyResDto.fromJson(Map<String, dynamic> json) => _$UserPolicyResDtoFromJson(json);
  Map<String, dynamic> toJson() => _$UserPolicyResDtoToJson(this);
}