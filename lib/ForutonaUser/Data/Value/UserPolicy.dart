
import 'package:forutonafront/ForutonaUser/Dto/UserPolicyResDto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'UserPolicy.g.dart';

@JsonSerializable()
class UserPolicy {
  String policyName;
  String policyContent;
  String lang;
  DateTime writeDateTime;

  UserPolicy();

  factory UserPolicy.fromUserPolicyResDto(UserPolicyResDto resDto){
    UserPolicy item = new UserPolicy();
    item.policyName = resDto.policyName;
    item.policyContent = resDto.policyContent;
    item.lang = resDto.lang;
    item.writeDateTime = resDto.writeDateTime;
    return item;
  }

  factory UserPolicy.fromJson(Map<String, dynamic> json) => _$UserPolicyFromJson(json);
  Map<String, dynamic> toJson() => _$UserPolicyToJson(this);
}