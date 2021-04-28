
import 'package:json_annotation/json_annotation.dart';

part 'UserPolicyResDto.g.dart';

@JsonSerializable()
class UserPolicyResDto {
  String? policyName;
  String? policyContent;
  String? lang;
  DateTime? writeDateTime;


  UserPolicyResDto();

  factory UserPolicyResDto.fromJson(Map<String, dynamic> json) => _$UserPolicyResDtoFromJson(json);
  Map<String, dynamic> toJson() => _$UserPolicyResDtoToJson(this);
}